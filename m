Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUDIFST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 01:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUDIFST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 01:18:19 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:7375 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261635AbUDIFSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 01:18:16 -0400
Date: Thu, 08 Apr 2004 22:18:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [patch 0/3] memory hotplug prototype
Message-ID: <1493892704.1081487887@[10.10.2.4]>
In-Reply-To: <20040409023745.DCBA6706E0@sv1.valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp><29700000.1081361575@flay><20040408091610.65C29706C3@sv1.valinux.co.jp><4200000.1081443395@flay> <20040409023745.DCBA6706E0@sv1.valinux.co.jp>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not trying to make my patches IA64 specific, and my patch is quite
> machine independent.  However, some of them, such as placing mem_map at
> boot time or hotplug events, are machine dependent by nature.

Sounds good - maybe I'd misread your intentions - sorry.
 
> I'm afraid that the memsection thing is overkill for systems whose
> hotpluggable memory unit is large.  I understand there's need for
> memsection, but I think that should be optional.

If you're doing things that are logically nodes on the system anyway,
that makes sense. However, I really hate the idea of breaking up existing
logical groupings of memory just to do hotplug ... zones represent a logical
type of memory to the system, where the memory is somehow logically 
"different" from that in other zones (eg it fullils some restraint of
DMA or "permanently mapped kernel space", or has a different locality
to cpus (NUMA)). Yes, I know the current non-NUMA discontigmem violates
that premise (and thus must die ;-)).

Perhaps I'm confusing your patches with sombody elses - it gets hard 
to keep track of all the groups involved, sorry ;-)

> BTW, I think memory hotplugging on 32 bit archs are difficult because
> of their narrow address space.  For example:
> 	1. A system boots with 1GB * 4 blocks of RAM.
> 	2. The second RAM block is removed.
> 	3. A 2GB block is inserted in the second slot.
> Where does these RAM block appear in physical space, 

I don't think we have control over that - it's a machine issue.

> and where should their mem_map be placed? 

ia32 has a really hard time doing that, as it has to be in permanent
KVA space. Moreover, you have alignment requirements between sections.
Probably for the first cut, we'll have to just reserve enough mem_map 
for any physical address that might appear for that machine. If Dave's
nonlinear stuff can sort out the alignment requirements, we can probably 
do a "vmalloc-like" remapping out of physical ranges in the new mem
segment, much as I did in remap_numa_kva for NUMA support.

M.

