Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263799AbRFHOe2>; Fri, 8 Jun 2001 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbRFHOeS>; Fri, 8 Jun 2001 10:34:18 -0400
Received: from [151.17.201.167] ([151.17.201.167]:50554 "EHLO proxy.teamfab.it")
	by vger.kernel.org with ESMTP id <S263799AbRFHOeB>;
	Fri, 8 Jun 2001 10:34:01 -0400
Message-ID: <3B20E1B2.C2198491@teamfab.it>
Date: Fri, 08 Jun 2001 16:31:14 +0200
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: m.luca@iname.com, tytso@mit.edu
Subject: [PATCH] Support Timedia/Sunix/Exsys PCI card problem in Serial 5.0.5 / 
 Kernel 2.4.xx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've found a bug in the serial driver 5.0.5, the problem is
that the Sunix pci 4port serial card wasn't correctly detected.

I'm using the serial 5.0.5 serial driver on a vanilla 2.2.19 kernel.

Searching the web I've found this changes that looks wrong :

http://www.linuxhq.com/kernel/v2.3/patch/patch-2.4.0-test7/linux_drivers_char_serial.c.html

here the obvious patch that made it work again here on 2.2.19 kernel.
Should be applied also on 2.4.x :

--- serial.c.ori        Fri Jun  8 16:12:16 2001
+++ serial.c    Fri Jun  8 16:12:30 2001
@@ -4178,7 +4178,7 @@
        for (i=0; timedia_data[i].num; i++) {
                ids = timedia_data[i].ids;
                for (j=0; ids[j]; j++) {
-                       if (pci_get_subvendor(dev) == ids[j]) {
+                       if (pci_get_subdevice(dev) == ids[j]) {
                                board->num_ports = timedia_data[i].num;
                                return 0;
                        }

ciao,
luca
