Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRLGHtm>; Fri, 7 Dec 2001 02:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLGHtc>; Fri, 7 Dec 2001 02:49:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:26127 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282799AbRLGHtR>;
	Fri, 7 Dec 2001 02:49:17 -0500
Date: Fri, 7 Dec 2001 08:49:10 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] / ALSA-0.9.0beta[9,10]
Message-Id: <20011207084910.7ec3b9c3.rene.rebe@gmx.net>
In-Reply-To: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20011207003528.1448673e.rene.rebe@gmx.net>
	<200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 23:09:14 -0700
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:

> Rene Rebe writes:
> > At least since 2.4.17-pre4 and -pre5 devfs is not handling
> > permissions in the right way with ALSA:
> 
> Please define what is the "right way".

Sorry I toght the commands wabout would be enought:

As root they are listable and read and writeable (for examples via ls -l,
cat /dev/dsp > ~/my-speach.snd or cat ~/my-speach.snd > /dev/dsp), ussing
mpg123 ...

> > rene@jackson:/dev > l dsp sound/dsp 
> > ls: sound/dsp: Permission denied
> > lr-xr-xr-x   1 root     root            9 Dec  7 00:14 dsp -> sound/dsp
> > rene@jackson:/dev > cd sound/
> > bash: cd: sound/: Permission denied
> > rene@jackson:/dev > 
> > 
> > rene@jackson:/dev > l snd
> > ls: snd/..: Permission denied
> > ls: snd/.: Permission denied
> > ls: snd/controlC0: Permission denied
> > ls: snd/controlC1: Permission denied
> > ls: snd/timer: Permission denied
> > ls: snd/midiC0D0: Permission denied
> > ls: snd/pcmC0D2p: Permission denied
> > ls: snd/pcmC0D1c: Permission denied
> > ls: snd/pcmC0D0p: Permission denied
> > ls: snd/pcmC0D0c: Permission denied
> > ls: snd/midiC1D0: Permission denied
> > ls: snd/pcmC1D0p: Permission denied
> > ls: snd/pcmC1D0c: Permission denied
> > total 0
> > 
> > They all have 666 (or 777 for dirs)!
> 
> Are you saying this is good or bad?

This is good. The permissions of the files are correct (everyone can use
sound), but I can (as you see in the command's output) neither access nor
read/write them as normal user - but all this works as root.

> > It is possible to this as root.
> 
> It's possible to do what? List the inodes? Open then? What?

Yes. All this is possible as root but not using anothe UID.

> > Also loading the modules gives me:
> > Dec  7 00:31:58 jackson kernel: devfs: devfs_register(unknown): could not append to parent, err: -17
> 
> Two possibilities:
> 
> - the module is trying to register "unknown" twice. The old devfs core
>   was forgiving about this (although it was always a driver bug to
>   attempt to create a duplicate). The new core won't let you do that.
>   Error 17 is EEXIST. Please fix the driver
> 
> - something in user-space created the "unknown" inode before the
>   driver could create it. This is a configuration bug. It seems
>   Mandrake has boot scripts which indiscriminately "restore" inodes in
>   /dev. This is a bug, because they also restore inodes created by the

I do not restore devices-nodes un reboot.

>   drivers, whereas they should only be restoring admin-created inodes.
>   Grab devfsd-v1.3.20 which has the RESTORE directive which does this
>   properly, and blow away the part of the Mandrake boot scripts which
>   are causing the problem

I use the devfsd.conf to configure the permission when a device registers.

> FYI: what happens now with duplicates is that the old entry remains,
> and the new one is discarded. If you really are creating the same
> entry, there should be no harm, just that annoying message.

The device-nodes seems to be all there they work as root, but not as normal
user. But it seems to be a ALSA issue, because only the ALSA nodes have this
strange behaviour ... ?

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

Have to leave now - can respond again in 8 hours ...

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
