Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQKOK6j>; Wed, 15 Nov 2000 05:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129386AbQKOK63>; Wed, 15 Nov 2000 05:58:29 -0500
Received: from slc62.modem.xmission.com ([166.70.9.62]:44808 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129340AbQKOK6Q>; Wed, 15 Nov 2000 05:58:16 -0500
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001114011331.B1496@codepoet.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Nov 2000 07:59:18 -0700
In-Reply-To: Erik Andersen's message of "Tue, 14 Nov 2000 01:13:32 -0700"
Message-ID: <m1bsvia9bt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> writes:

> On Thu Nov 09, 2000 at 01:18:24AM -0700, Eric W. Biederman wrote:
> > 
> > I have recently developed a patch that allows linux to directly boot
> > into another linux kernel.  
> 
> Looks very cool.  I'm curious about your decision to use ELF images.  This
> makes it much less conveinient to use due to the kernel postprocessing, and
> makes it that the kernel binary from which you initially boot is not
> necessirily the same as the binary that you re-boot into.  

The decision here was that I needed to pass a vector of 
<physical address, length, data> pairs.  The elf program header
is dead simple and provides it.  So I either had to invent a
complicated argument passing mechanism for a syscall or have the
kernel parse a file.

> Wouldn't it be more reasonable to simply try to exec whatever file is provided?
> If the concern is initrds; they can be simply pasted into the kernel binary.

That's exactly what my preprocessing does. 

vmlinux is also an elf binary.  As is arch/i386/boot/bvmlinux but it
is compressed.

All mkelfImage does is the pasting of initrd's, command lines,
and just a touch of argument conversion code.

What I don't do deliberately is allow or need setup.S which does
syscalls to run.  All it does are BIOS calls, and store them in a
nasty data structure.  I have replaced that data structure with 
something that is maintainable.  

I would like very much to not need mkelfImage.  However that
requires further changes to the kernel, and I cannot boot an unpatched
kernel with that method.  

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
