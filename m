Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWJEEIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWJEEIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWJEEIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:08:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43944 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750740AbWJEEIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:08:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
Date: Wed, 04 Oct 2006 22:06:27 -0600
In-Reply-To: <20061003201340.afa7bfce.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 3 Oct 2006 20:13:40 -0700")
Message-ID: <m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 3 Oct 2006 13:25:11 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
>> Increasingly the cobbled together boot protocol that
>> is bzImage does not have the flexibility to deal
>> with booting in new situations.
>> 
>> Now that we no longer support the bootsector loader
>> we have 512 bytes at the very start of a bzImage that
>> we can use for other things.
>> 
>> Placing an ELF header there allows us to retain
>> a single binary for all of x86 while at the same
>> time describing things that bzImage does not allow
>> us to describe.
>
> Seems that the entire kernel effort is an ongoing plot to make my poor
> little Vaio stop working.  This patch turns it into a black-screened rock
> as soon as it does grub -> linux.  Stock-standard FC5 install, config at
> http://userweb.kernel.org/~akpm/config-sony.txt.

Ugh.  I just tested this with a grub 0.97-5 from what I assume is a
standard FC5 install (I haven't touched it) and the kernel boots.
I only have a 64bit user space on that machine so init doesn't
start but I get the rest of the kernel messages.

There were several testers working at redhat so a pure redhat
incompatibility would be a surprise.

I don't think the formula is a simple grub+bzImage == death.

There is something more subtle going on here.  

I'm not certain where to start looking.  Andrew it might help if we
could get the dying binary just in case some weird compile or
processing problem caused insanely unlikely things like the multiboot
binary to show up in your grub install.  I don't think that is it,
but it should allow us to rule out that possibility.

Eric
