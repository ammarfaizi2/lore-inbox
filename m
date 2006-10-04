Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWJDIGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWJDIGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWJDIGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:06:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60041 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161173AbWJDIGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:06:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com>
Date: Wed, 04 Oct 2006 02:04:49 -0600
In-Reply-To: <45233B58.1050208@zytor.com> (H. Peter Anvin's message of "Tue,
	03 Oct 2006 21:40:56 -0700")
Message-ID: <m1sli4cxr2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Vivek Goyal wrote:
>> Hi Andrew,
>> Right now I don't have access to my test machine.  Tomorrow morning,
>> very first thing I am going to try it out with your config file.
>> This patch just adds and ELF header to bzImage which is not even used
>> by grub.
>>
>
> Oh yes, it will be.  See below.
>
>> So without this patch you are able to boot the kernel on your laptop?
>
> Danger, Will Robinson.  GRUB, Etherboot, and a whole bunch of other boot loaders
> will recognize an ELF binary and load it as such.  They will typically load it
> as an executable (not a relocatable object) -- I doubt many of them check that
> appropriate part of the ELF header -- so unless your kernel can be safely loaded
> *AND RUN* in that mode this is not going to work.

The bzImage be safely loaded run in that mode.  The only question is one
of arguments.  Because there are no standards.  For Etherboot we are good.
For the insanity that is GRUB I haven't the faintest clue but we should
be ok as we don't have a multiboot header.

> The entrypoint is going to be a major headache, since the standard kernel is
> entered in real mode, whereas an ELF file will typically be entered in protected
> mode, quite possibly using the C calling convention to pass the command line as
> (argc, argv).  God only knows how they're going to deal with an initrd.
>
> It may very well be that the ELF magic number has to be obfuscated.

The entry point that is exported is the kernels protected mode entry point
that is used after the real mode code has been run.  This is to allow
bootloaders like kexec where running the real-mode code is insane or
impossible to be used.  

The calling conventions though are not changed, this is just formalizing
something that various groups have been doing for years.  Since it is
all in the bzImage we still only have a single file format to support,
so any bootloader that can load a standard bzImage and run the kernels
real mode code should still do it that way but.  If you can't the
rest of the information is available.

Eric
