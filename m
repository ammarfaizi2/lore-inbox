Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDHOs3>; Sun, 8 Apr 2001 10:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRDHOsS>; Sun, 8 Apr 2001 10:48:18 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:25031 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S132567AbRDHOsF>; Sun, 8 Apr 2001 10:48:05 -0400
Message-ID: <3AD079EA.50DA97F3@rcn.com>
Date: Sun, 08 Apr 2001 09:47:06 -0500
From: Marvin Stodolsky <stodolsk@rcn.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: build -->/usr/src/linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MODULE SUPPORT [GENERAL], KMOD
P:      Keith Owens
M:      kaos@ocs.com.au
L:      linux-kernel@vger.kernel.org
============================================

Though I've done some rational searching through the Documetation,
an explanation hasn't manifested, as to why there has appeared in the
2.4.nn   ??????:


# ls -l /lib/modules/2.4.3/
total 24
lrwxrwxrwx    1 root     root  ???????   20 Apr  2 17:00 build ->
/usr/src/linux-2.4.3
drwxr-xr-x    6 root     root         1024 Apr  2 17:00 kernel
-rw-r--r--    1 root     root         4725 Apr  8 08:06 modules.dep
-rw-r--r--    1 root     root           31 Apr  8 08:06
modules.generic_string
-rw-r--r--    1 root     root         4388 Apr  8 08:06
modules.isapnpmap
-rw-r--r--    1 root     root           29 Apr  8 08:06
modules.parportmap
-rw-r--r--    1 root     root         8723 Apr  8 08:06 modules.pcimap
-rw-r--r--    1 root     root         1317 Apr  8 08:06 modules.usbmap
lrwxrwxrwx    1 root     root           35 Apr  2 17:05 pcmcia ->
/lib/modules/2.4.3-oldpcmcia/pcmcia

-----------
Could someone enlighten me?  What is it necessary for?

It's presence has required some gymnastics, per below, during module
installation for the Winmodem driver, ltmodem.o requiring a subsequent
"depmod -a"

MarvS
===========================================================
from the module install script  ./ltinst

# To avoid non-relevant complaint noise that would be generated during
#    depmod -a   within update-modules
# under 2.4.nn kernels due to the symbolic Link
#   /lib/modules/2.4.nn/build --> /usr/src/linux
# if kernel-source "make clean" is run betweem build_module & 
#   ltinst (install ltmodem.o in the /lib/modules/  tree)
# The Link is moved to  /tmp and after "update-modules" is  restored.
if [ -L /lib/modules/$SYS/build ]; then
mv /lib/modules/$SYS/build /tmp
fi

# Updating module dependancies
if [ -f /etc/modutils/aliases ]; then
update-modules
else
depmod -a
fi

# Restoring build link if any
if [ -L /tmp/build ]; then
mv /tmp/build /lib/modules/$SYS/
fi
