Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSLMLxu>; Fri, 13 Dec 2002 06:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSLMLxu>; Fri, 13 Dec 2002 06:53:50 -0500
Received: from ulima.unil.ch ([130.223.144.143]:32427 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S262354AbSLMLxs>;
	Fri, 13 Dec 2002 06:53:48 -0500
Date: Fri, 13 Dec 2002 13:01:38 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 won't boot with devfs enabled
Message-ID: <20021213120138.GB584@ulima.unil.ch>
References: <20021210111835.A92@ma-northadams1b-112.bur.adelphia.net> <3DF70CA8.CC553446@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DF70CA8.CC553446@aitel.hist.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 11:00:08AM +0100, Helge Hafting wrote:

TREMENDOUS: without those four ligns, I can boot 2.5.51 ;-)

Thank you very much!!!

> Booting anything later than 2.5.48 with devfs configured
> either needs an extra kernel parameter, or a code change.  
> Something broke when do_mounts.c were reorganized.
> It doesn't matter wether devfs is used or not, as long as it
> is configured.  
> 
> The lilo solution:
> lilo tend to have a "root=/dev/hda1" or similiar.
> This gets converted to "root=0301" on the kernel command line.
> (Look at dmesg after a successful boot)
> 
> But this don't work for some reason when devfs is configured.
> Use the following:
> 
> append="root=/dev/hda1"
> 
> to solve the problem.  This isn't converted to numbers and works.
> Of course if you use auto-mounted devfs then you don't
> have a /dev/hda1 but a /dev/ide/host0/bus0/target0/lun0/part1
> instead.  If so, use that as root instead. You still have
> to use the append= trick.
> 
> The code solution:
> Edit init/do_mounts.c
> Remove the following lines from the beginning of
> the function prepare_namespace:
> #ifdef CONFIG_DEVFS_FS
>         sys_mount("devfs", "/dev", "devfs", 0, NULL);
>         do_devfs = 1;
> #endif
> Then recompile, and the kernel should work with any lilo setup that
> worked for 2.5.47 and earlier.  At least it worked for the setups
> I tried.
> 
> This has no effect on kernels without devfs, and helps for kernels
> comiled with devfs wether devfs is used or not.
> I posted a patch for this, but there were no interest at all.

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
