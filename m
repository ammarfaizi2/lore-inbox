Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSAVSHJ>; Tue, 22 Jan 2002 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289335AbSAVSGv>; Tue, 22 Jan 2002 13:06:51 -0500
Received: from server1.symplicity.com ([209.61.154.230]:55821 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S289290AbSAVSGr>; Tue, 22 Jan 2002 13:06:47 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: "=?iso-8859-1?Q?'Jakob_=D8stergaard'?=" <jakob@unthought.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Autostart RAID 1+0 (root)
Date: Tue, 22 Jan 2002 13:07:32 -0500
Message-ID: <003801c1a36f$a9a27c20$9865fea9@pcsn630778>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20020122184600.C11697@unthought.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Does the kernel support autostarting nested RAID partitions?
> > > 
> 
> Yes it does.  If you have persistent superblocks on all arrays, they
> *should* autostart.
> 
> If you boot from the 4G disk, does the array start properly ? 
>  Does it start properly even if you remove your /etc/raidtab ?
> 
> Please check that you have the correct RAID levels either 
> compiled into your kernel, or on an initrd.

1.  I have persistent superblocks on all arrays.  
2.  Booting from the 4G does allow the arrays to start properly.
3.  The first two arrays (md0 and md1, the mirrors) start properly
without raidtab.  The third, the stripe between md0 and md1, does not.
4.  All raid levels are compiled as modules, along with reiserfs, and my
scsi card driver in an initrd.  I also tried compiling a monolithic
kernel with all of these without success.

I did, in fact, get it working.  The only way I was able to do boot with
my nested array autostarted and mounted as root was to create an initrd
with a statically compiled raidstart and a copy of my raidtab in the
initrd's etc dir.  I then issue "raidstart mdx" commands for each of the
arrays in linuxrc.  I actually just modified the mkinitrd genereated
initrd image.

I can only conclude that autostarting nested arrays either doesn't work,
or is broken in RH-2.4.9-13.  I have not tried a more recent kernel with
this machine.

Thanks

Al

