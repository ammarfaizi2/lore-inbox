Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266169AbRGLQ2f>; Thu, 12 Jul 2001 12:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266171AbRGLQ2Z>; Thu, 12 Jul 2001 12:28:25 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:23819 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266169AbRGLQ2M>; Thu, 12 Jul 2001 12:28:12 -0400
Message-ID: <3B4DD05F.99C2C71@t-online.de>
Date: Thu, 12 Jul 2001 18:29:19 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Patch(2.4.6):serial unmaintained (bugfix pci timedia/sunix/exsys pci 
 cards)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this  one-liner fixes a longstanding bug in serial
for Timedia/Sunix/Exsys PCI cards !

The fix was sent to Ted several times since 02/2001 and
uploaded to http://sourceforge.net/projects/serial/.
There was no reaction.

By listing a defunct MAINTAINER the progress of linux is stuck
as patches go to /dev/null by
- the maintainer (who got lost for unknown, perhaps even valid reasons)
- Linus, as he waits for approval by the maintainer.

Linus, can you please include this patch?

Regards, Gunther



(Without this patch serial recognizes wrong number of serial ports!)
--- linux/drivers/char/serial.c-246     Thu Jul 12 18:12:08 2001
+++ linux/drivers/char/serial.c Thu Jul 12 18:13:40 2001
@@ -4193,7 +4193,7 @@
        for (i=0; timedia_data[i].num; i++) {
                ids = timedia_data[i].ids;
                for (j=0; ids[j]; j++) {
-                       if (pci_get_subvendor(dev) == ids[j]) {
+                       if (pci_get_subdevice(dev) == ids[j]) {
                                board->num_ports = timedia_data[i].num;
                                return 0;
                        }
