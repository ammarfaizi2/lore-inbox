Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277223AbRJQVST>; Wed, 17 Oct 2001 17:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRJQVSJ>; Wed, 17 Oct 2001 17:18:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277223AbRJQVSB>; Wed, 17 Oct 2001 17:18:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] pivot_root and initrd
Date: 17 Oct 2001 14:17:59 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qksi7$sdc$1@cesium.transmeta.com>
In-Reply-To: <p05100300b7f2b3b94b17@[10.128.7.49]> <3BCDCF1D.6030202@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BCDCF1D.6030202@usa.net>
By author:    Eric <ebrower@usa.net>
In newsgroup: linux.dev.kernel
> 
> I am mystified that the call to 'exec /sbin/init' works if you are using 
> the standard (you mention "based on RedHat7.1" util-linux") /sbin/init 
> proggie, and that a standard RH7.1 initscripts would not complain when 
> the root filesystem is already mounted r/w.
> 
> I would also guess that you are susceptible to the kernel's change_root 
> call if your /sbin/init terminates.  I'll have to play with the disk a bit.
> 

I modify the initscripts to not try to fsck and remount the root --
its a ramfs (tmpfs in a later version) after all.  If I had been
mounting a filesystem off the harddisk I would either have mounted it
readonly and left the init scripts as-is, or fscked it before
mounting.

I pass the following command line options to the kernel (this is set
up in isolinux.cfg):

        append initrd=initrd.gz root=/dev/ram0 init=/linuxrc single

By specifying root=/dev/ram0 and an explicit init (which I'm calling
/linuxrc but could just as easily have called /sbin/init) I'm telling
the kernel that this is the final root, and effectively turn off most
of the initrd legacy weirdness.

If /sbin/init exits, the kernel panics, just like it would normally do
if init goes away.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
