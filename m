Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946737AbWKJQNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946737AbWKJQNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946738AbWKJQNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:13:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12977 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1946737AbWKJQNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:13:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Magnus Damm <magnus.damm@gmail.com>, Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061102101942.452.73192.sendpatchset@localhost>
	<20061102101949.452.23441.sendpatchset@localhost>
	<m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com>
	<m1irhnnb09.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30611092253q6bd15701x1f5da122de5c7075@mail.gmail.com>
	<20061110144922.GA8155@in.ibm.com>
Date: Fri, 10 Nov 2006 09:10:42 -0700
In-Reply-To: <20061110144922.GA8155@in.ibm.com> (Vivek Goyal's message of
	"Fri, 10 Nov 2006 09:49:22 -0500")
Message-ID: <m1fycrjn99.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:
>
> IMHO, I think we should go by the specs (8byte boundary alignment on 64bit
> platforms) until and unless it can be proven that specs are wrong. This
> probably will mean that we will break things for sometime (until and unless
> it is fixed in tool chain and probably will also break the capability to use
> an older kernel for capturing dump). But that's unavoidable if we want to be
> compliant to specs.

I just looked a little more, and the notes gcc generates on x86_64 are only 4
byte aligned. (.note.ABI-tag)

The linux kernel gcc, gdb.  I think that is enough to say that notes need to
be 4 byte aligned on Linux.   The core ELF spec also calls out 4 byte alignment
(although it does not mention ELFCLASS64).

I think the evidence is that someone intended to the alignment to go to 8 bytes
with the move to 64bits but it did not catch on in the real world.

So yes I believe the evidence is quite strong that the spec is wrong. 
(Not on some rare platforms certainly but in general).

Eric
