Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288047AbSBDUFg>; Mon, 4 Feb 2002 15:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSBDUFX>; Mon, 4 Feb 2002 15:05:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3388 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288047AbSBDUFO>; Mon, 4 Feb 2002 15:05:14 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <18006.1012796941@ocs3.intra.ocs.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Feb 2002 13:01:24 -0700
In-Reply-To: <18006.1012796941@ocs3.intra.ocs.com.au>
Message-ID: <m1k7tt6mp7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> On 03 Feb 2002 11:43:08 -0700, 
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >O.k. I have been thinking about this some more, and I have come up with a
> couple
> 
> >alternate of solutions....
> >My final and favorite is to take an ELF image, define a couple of ELF
> >note types, and add a bunch those notes saying which pieces are
> >hardware dependent.  So a smart ELF loader can prune the image as it
> >is loaded, and a stupid one will just attempt to load everything.  And
> >with the setup for this not being bootloader specific it will probably
> >encourage device pruning loaders.
> 
> That is not an ELF loader, it is an ELF *linker*.  The vmlinux image
> has had all the relocations fixed up, you no longer have the data
> required to discard sections.  To prune hardware dependent pieces means
> moving data around and adjusting relocation entries.  you have to go
> back one stage, to the individual objects, and that means linking.

Not if what you are actually pruning is your cpio archive of modules
that will become your initramfs.  I admit insmod then needs to run to
insert those modules.

> Seems like an awful lot of work.

It may actually be, on the setup side.  But any solution that is
setup to run on all x86 platforms is a lot of work.  On the bootloader
side adding a file a initramfs is the same complexity as removing one.

Eric
