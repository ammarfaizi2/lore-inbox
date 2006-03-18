Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWCRB0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWCRB0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWCRB0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:26:13 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9610 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750779AbWCRB0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:26:11 -0500
Date: Sat, 18 Mar 2006 10:26:53 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: y-goto@jp.fujitsu.com, akpm@osdl.org, tony.luck@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH: 002/017]Memory hotplug for new nodes v.4.(change name
 old add_memory() to arch_add_memory())
Message-Id: <20060318102653.57c6a2af.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1142615538.10906.67.camel@localhost.localdomain>
References: <20060317162757.C63B.Y-GOTO@jp.fujitsu.com>
	<1142615538.10906.67.camel@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, 17 Mar 2006 09:12:18 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Fri, 2006-03-17 at 17:20 +0900, Yasunori Goto wrote:
> > This patch changes name of old add_memory() to arch_add_memory.
> > and use node id to get pgdat for the node at NODE_DATA().
> > 
> > Note: Powerpc's old add_memory() is defined as __devinit. However,
> >       add_memory() is usually called only after bootup. 
> >       I suppose it may be redundant. But, I'm not sure about powerpc.
> >       So, I keep it. (But, __meminit is better than __devinit at least.)
> 
> My thoughts when originally designing the API were that the architecture
> may be the only bit that actually knows where the memory _is_.  So, we
> shouldn't involve the generic code in figuring this out.
> 
> You can see the result of this in the next patch because there is a new
> function introduced to hide the arch-specific node lookup.  If that was
> simply done in the already arch-specific add_memory() function, then you
> wouldn't need arch_nid_probe() and its related #ifdefs at all.
> 
If *determine node* function is moved to arch specific parts,
memory hot add need more and more codes to determine  paddr -> nid in arch
specific codes. Then, we have to add new paddr->nid function even if new nid is
passed by firmware. We *lose* useful information of nid from firmware if 
add_memory() has just 2 args, (start, end). 

Considering ACPI, ia64/x86_64 can share codes and it depends on ACPI , not on arch. 


It's trade-off between add special tiny #ifdef for probe
(not-firmware-supported memory hotplug) and add many codes for firmware-supported
memory hotplug function. Again, we *lose* information of nid from firmware 
if add_memory() has just 2 args (start, end). This is bad thing.

-- Kame

