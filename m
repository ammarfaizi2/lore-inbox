Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268311AbTCCDcQ>; Sun, 2 Mar 2003 22:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268312AbTCCDcQ>; Sun, 2 Mar 2003 22:32:16 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:53196 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S268311AbTCCDcO>;
	Sun, 2 Mar 2003 22:32:14 -0500
Date: Mon, 3 Mar 2003 04:42:33 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kai@tp1.ruhr-uni-bochum.de, torvalds@transmeta.com
Subject: Re: do_mounts: Move CONFIG_BLK_DEV_RAM stuff into own file
Message-ID: <20030303034233.GA19909@h55p111.delphi.afb.lu.se>
References: <200303020306.h2236cB22227@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303020306.h2236cB22227@hera.kernel.org>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18pgqX-0005Gh-00*qODPZEvb846* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 07:12:35AM +0000, Linux Kernel Mailing List wrote:
> diff -Nru a/init/Makefile b/init/Makefile
> --- a/init/Makefile	Sat Mar  1 19:06:40 2003
> +++ b/init/Makefile	Sat Mar  1 19:06:40 2003
> @@ -3,8 +3,9 @@
>  #
>  
>  obj-y			:= main.o version.o do_mounts.o initramfs.o
> -obj-$(CONFIG_DEVFS_FS)	+= do_mounts_devfs.o
> -obj-$(CONFIG_BLK_DEV_MD)+= do_mounts_md.o
> +obj-$(CONFIG_DEVFS_FS)		+= do_mounts_devfs.o
> +obj-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
> +obj-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o

This breaks compilation with initial ramdisk off and ramdisk on (or as
module). do_mounts_rd.o should be pulled in by CONFIG_BLK_DEV_INITRD not
CONFIG_BLK_DEV_RAM. Fix below.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1031, 2003-03-03 04:31:30+01:00, andersg@0x63.nu
  Use right configoption for selecting compilation of do_mounts_rd


 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/init/Makefile b/init/Makefile
--- a/init/Makefile	Mon Mar  3 04:36:10 2003
+++ b/init/Makefile	Mon Mar  3 04:36:10 2003
@@ -4,7 +4,7 @@
 
 obj-y			:= main.o version.o do_mounts.o initramfs.o
 obj-$(CONFIG_DEVFS_FS)		+= do_mounts_devfs.o
-obj-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
+obj-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_rd.o
 obj-$(CONFIG_BLK_DEV_MD)	+= do_mounts_md.o
 
 # files to be removed upon make clean

===================================================================


This BitKeeper patch contains the following changesets:
1.1031
## Wrapped with gzip_uu ##


begin 664 bkpatch5388
M'XL(`*K-8CX``\V476O;,!2&KZ-?(>@N-H)M'7W8CL$C:]*UH5T;LG6W0;:5
MV(MM!5M.-_"/G^.4AF1CL-&+Z0B!I"/QZCT/NL"/M:J"@2P35=5K=(%O=&V"
M`?GN,KMLNOE"ZV[N)-)()U$[9Z.J4N5.M'&B7#^A+F,N39SB77<^&(#-7E;,
MCZT*!HNKZ\>[#PN$PA!/4EFNU6=E<!@BHZN=S)-Z+$V:Z](VE2SK0AEIQ[IH
M7U);2@CM0H#'B'!;<`GWVA@2`,E!)81RW^7H^0'C9^&GYUD?(#S.6N;ZPD-3
M##80!I@PI^^8\(!!P,B00$`(/KL/#P%;!%WBUU4]0?&^`+C*UJG!L2Y7V5IO
M3:9+O-(5KE6N8I.5ZVZKV&:Y['?T"B=Z6>BF-/6R2M`M9H*+$9H?_4767S:$
MB"3H/=[(;&RV8%=-6EE-F5F1CM.FL!/59F5FG$]RHU99K@[O$Y3`"+CH7&7"
MI2T;";8"-E+4BZ)$J',7?[WC4!G&`/S6I=3W>TY.TO:LO*ZL(WJI+M19"7\K
M$2CE'J>=1")X#P_EY^B`_P=TX']%YV#Z`[:JI[YW*,Q/_?\'EJ8>!C3;#SKZ
M9KUY.WFX_SB[7E[>W2ZG5U^7L_O9E\7TW6`8GJBQ]?$WB5,5;^JF"!GE@G.1
*H)^V>@`"J@0`````
`
end
