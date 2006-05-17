Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWEQPJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWEQPJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEQPJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:09:42 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:37828
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750971AbWEQPJl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:09:41 -0400
Message-Id: <200605171509.k4HF9dPR019875@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux cbon <linuxcbon@yahoo.fr>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: Your message of "Wed, 17 May 2006 16:53:35 +0200."
             <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147878578_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 11:09:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147878578_4166P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <19866.1147878578.1@turing-police.cc.vt.edu>

On Wed, 17 May 2006 16:53:35 +0200, linux cbon said:

> It is already happening today with X, because :
> X runs as root - ouch.
> X can write into kernel memory - ouch.
> X can mess with clocks - ouch.
> X can mess with PCI bus - ouch.

You're confusing "X" with "One misdesigned implementation of X".  If
you actually checked the list archives, you'll see that there are steps
underway to drastically reduce the amount of stuff that X does...

> We dont need 2 kernels like today.
> All "dangerous code" should be in kernel.

Erm. No.  Dangerous code should remain out in userspace where it can't
cause as much damage.

> > Do you really want to put all that complexity into
> > the kernel?
> 
> Kernel is already complex, that wouldnt affect it.

% size /usr/src/linux-2.6.17-rc4-mm1/vmlinux /lib/modules/2.6.17-rc4-mm1/kernel/drivers/video/nvidia.ko
   text    data     bss     dec     hex filename
3681149  893719  316992 4891860  4aa4d4 /usr/src/linux-2.6.17-rc4-mm1/vmlinux
2910736 1299276   10388 4220400  4065f0 /lib/modules/2.6.17-rc4-mm1/kernel/drivers/video/nvidia.ko

Wow, that one module is 75% of the size of my kernel...

OK.. Maybe I run a lot of modules?

% lsmod | grep -v nvidia | wc
     43     143    1793
% lsmod | grep -v nvidia | awk '{sum +=$2} END {print sum}'
627006

Nope, only another 600K or so. Puts us up to 4.2M or so kernel, plus 3M of nvidia..

But wait, there's more.  Let's look at the X server and all its shared libs.

# size `lsof -p 2087 | egrep 'mem.*REG' | awk '{print $9}'`
   text    data     bss     dec     hex filename
  32711     448     480   33639    8367 /lib/libnss_files-2.4.90.so
  28347     668       8   29023    715f /usr/lib/xorg/modules/libramdac.so
 242306    2396      44  244746   3bc0a /usr/lib/xorg/modules/libfb.so
 130662    1848     332  132842   206ea /usr/lib/xorg/modules/extensions/libextmod.so
   1087     160      32    1279     4ff /usr/lib/tls/libnvidia-tls.so.1.0.8756
7983042  127036   17376 8127454  7c03de /usr/lib/libGLcore.so.1.0.8756
   9457    1524      60   11041    2b21 /usr/lib/xorg/modules/input/kbd_drv.so
  38096    3352      16   41464    a1f8 /usr/lib/xorg/modules/input/mouse_drv.so
 578630   73544    3968  656142   a030e /usr/lib/xorg/modules/extensions/libglx.so.1.0.8756
 219189   89192       4  308385   4b4a1 /usr/lib/xorg/modules/libpcidata.so
 434782   11352       4  446138   6ceba /usr/lib/libfreetype.so.6.3.8
1230342   10368   11312 1252022  131ab6 /lib/libc-2.4.90.so
  43260     420     292   43972    abc4 /lib/libgcc_s-4.1.0-20060512.so.1
 141605     336      64  142005   22ab5 /lib/libm-2.4.90.so
  71955     704       4   72663   11bd7 /usr/lib/libz.so.1.2.3
  17096     368       4   17468    443c /usr/lib/libXdmcp.so.6.0.0
  16794    3776    1248   21818    553a /usr/lib/libfontenc.so.1.0.0
   6550     368      12    6930    1b12 /usr/lib/libXau.so.6.0.0
 439854   25036   47916  512806   7d326 /usr/lib/libXfont.so.1.4.1
   6814     400      48    7262    1c5e /lib/libdl-2.4.90.so
 154483    2376    1088  157947   268fb /usr/lib/liblbxutil.so.1.0.0
  27966     608    1064   29638    73c6 /usr/lib/xorg/modules/linux/libdrm.so
  28409     908      36   29353    72a9 /usr/lib/xorg/modules/extensions/libdri.so
   1541     396       4    1941     795 /usr/lib/xorg/modules/fonts/libbitmap.so
  99149    2392     192  101733   18d65 /lib/ld-2.4.90.so

Totalling it up: 
11984127 359976   85608 12429711

Yowza.  124 *meg*.

> But that would greatly simplify the whole system.

Yeah, adding 124 meg to a 4.2M kernel will simplify it...


--==_Exmh_1147878578_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEazyycC3lWbTT17ARAuwCAKDVGdiYtXbKmSEDdkhmQbW+nERKYQCfSnHu
lrfM3Zt0XcEeJgMRlHOs5uI=
=/edX
-----END PGP SIGNATURE-----

--==_Exmh_1147878578_4166P--
