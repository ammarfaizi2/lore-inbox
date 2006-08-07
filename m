Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWHGR3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHGR3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHGR3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:29:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:35470 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932240AbWHGR3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:29:53 -0400
Subject: RE: Options depending on STANDALONE
From: Thomas Renninger <trenn@suse.de>
Reply-To: trenn@suse.de
To: "Brown, Len" <len.brown@intel.com>
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Organization: Novell/SUSE
Date: Mon, 07 Aug 2006 19:33:31 +0200
Message-Id: <1154972011.4302.712.camel@queen.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 16:49 -0400, Brown, Len wrote:
> >On Thu, Aug 03, 2006 at 10:25:43PM +0200, Adrian Bunk wrote:
> >> ACPI_CUSTOM_DSDT seems to be the most interesting case.
> >> It's anyway not usable for distribution kernels, and AFAIR the ACPI 
> >> people prefer to get the kernel working with all original DSDTs
> >> (which usually work with at least one other OS) than letting 
> >> the people workaround the problem by using a custom DSDT.
> >
> >Not true at all.  For SuSE kernels, we have a patch that lets people
> >load a new DSDT from initramfs due to broken machines requiring a
> >replacement in order to work properly.
> 
> CONFIG_ACPI_CUSTOM_DSDT allows hackers to debug their system
> by building a modified DSDT into the kernel to over-ride what
> came with the system.  It would make no sense for a distro
> to use it, unless the distro were shipping only on 1 model machine.
> This technique is necessary for debugging, but makes no
> sense for production.
> 
> The initramfs method shipped by SuSE is more flexible, allowing
> the hacker to stick the DSDT image in the initrd and use it
> without re-compiling the kernel.
> 
> I have refused to accept the initrd patch into Linux many times,
> and always will.
> 
> I've advised SuSE many times that they should not be shipping it,
> as it means that their supported OS is running on modified firmware --
> which, by definition, they can not support.  
Tainting the kernel if done so should be sufficient.
> Indeed, one could view
> this method as couter-productive to the evolution of Linux --
> since it is our stated goal to run on the same machines that Windows
> runs on -- without requiring customers to modify those machines
> to run Linux.

There are three reasons for the initrd patch (last one also applies for
the compile in functionality):

1)
There might be "BIOS bugs" that will never get fixed:
https://bugzilla.novell.com/show_bug.cgi?id=160671
(Because it's an obvious BIOS bug, "compatibility" fixing it could make
things worse).

2)
There might be "ACPICA/kernel bugs" that take a while until they get
fixed:

This happens often. There comes out a new machine, using AML in a
slightly other way, we need to fix it in kernel/ACPICA. Until the patch
appears mainline may take a month or two. Until the distro of your
choice that makes use of the fix comes out might take half a year or
more...
And backporting ACPICA fixes to older kernels is currently not possible
as ACPICA patches appear in a big bunch of some thousand lines patches.
But this hopefully changes soon.

In my mind come:
- alias broken in certain cases
   https://bugziall.novell.com/show_bug.cgi?id=113099
- recon amount of elements in packages
   https://bugzilla.novell.com/show_bug.cgi?id=189488
- wrong offsets at Field and Operation Region declarations
   -> should be compatible for quite a while now
- ...

3)
Debugging.
This is why at least compile in or via initrd must be provided in
mainline kernel IMHO. Intel people themselves ask the bug reporter to
override ACPI tables with a patched table to debug the system.
Do you really think ripping out all overriding functionality from the
kernel is a good idea?

     Thomas

It is true that some users are happy with a fixed DSDT, even you tell
them to find the root cause..., but sooner or later they always come
back.

