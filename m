Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVEJMa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVEJMa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVEJMa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:30:59 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:54470 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261624AbVEJMaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:30:46 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: coywolf@lovecn.org
Subject: Re: kexec?
Date: Tue, 10 May 2005 12:15:48 +0200
User-Agent: KMail/1.7.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
References: <20050508202050.GB13789@charite.de> <20050509183428.6d7934a6.rddunlap@osdl.org> <2cd57c9005051000004c57050@mail.gmail.com>
In-Reply-To: <2cd57c9005051000004c57050@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505101215.48993.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 09:00, Coywolf Qi Hunt wrote:
> On 5/10/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> > On Sun, 8 May 2005 22:20:50 +0200 Ralf Hildebrandt wrote:
> > | I know kexec used to be a patch, but has it gone into the mainstream
> > | kernels yet?
> >
> > Nope, it's only in the -mm patchset.
> > Testing/reporting that could help....
>
> coywolf@prodigy:~/kexec-tools-1.95/objdir/build/bin$ ./kexec_test
> Segmentation fault
>
> prodigy:/home/coywolf/kexec-tools-1.95/objdir/build/sbin# ./kexec -l
> /var/local/build/vmlinux
> kexec_load failed: Cannot assign requested address
> entry       = (nil)
> nr_segments = 2
> segment[0].buf   = 0x80b4558
> segment[0].bufsz = 15c
> segment[0].mem   = (nil)
> segment[0].memsz = 15c
> segment[1].buf   = 0xb7d53008
> segment[1].bufsz = 2a0086
> segment[1].mem   = 0x100000
> segment[1].memsz = 2c8a78
>
> prodigy:/home/coywolf/kexec-tools-1.95/objdir/build/sbin# ./kexec -l
> /var/local/build/arch/i386/boot/bzImage
> kexec_load failed: Cannot assign requested address
> entry       = 0x91734
> nr_segments = 2
> segment[0].buf   = 0x80b4480
> segment[0].bufsz = 1850
> segment[0].mem   = 0x90000
> segment[0].memsz = 1850
> segment[1].buf   = 0xb7eaa008
> segment[1].bufsz = 14032d
> segment[1].mem   = 0x100000
> segment[1].memsz = 14032d

Hi,

I've been doing some kexec tests (as described in Documentation/kdump.txt) too 
but can't get to load the image and get similar error messages. Let me know 
if you need more info about the hardware. The first_kernel was booted with 
"crashkernel=64M@16M" and the 16M value was configured into the second during 
kconfig in "Physical address where the kernel is loaded" as 0x1000000.

[root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1 maxcpus=1 
init 1"

kexec_load failed: Cannot assign requested address
entry       = 0x1498 flags = 1
nr_segments = 4
segment[0].buf   = 0x8067ba0
segment[0].bufsz = 80c0
segment[0].mem   = 0x1000
segment[0].memsz = a000
segment[1].buf   = 0x806fd80
segment[1].bufsz = 1000
segment[1].mem   = 0xb000
segment[1].memsz = 1000
segment[2].buf   = 0xb6dbc008
segment[2].bufsz = 3d619c
segment[2].mem   = 0x1000000
segment[2].memsz = 3d7000
segment[3].buf   = 0xb7193008
segment[3].bufsz = 2b086
segment[3].mem   = 0x13d8000
segment[3].memsz = 55000



