Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUFYOCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUFYOCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266736AbUFYOCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:02:17 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:64651 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266732AbUFYOCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:02:15 -0400
Message-ID: <20040625140214.65080.qmail@web81307.mail.yahoo.com>
Date: Fri, 25 Jun 2004 07:02:14 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
To: Marc Waeckerlin <marc.waeckerlin@siemens.com>
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-145092153-1088172134=:64726"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-145092153-1088172134=:64726
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Marc Waeckerlin wrote:
> Am Donnerstag, 24. Juni 2004 18.11 schrieb Dmitry Torokhov unter "RE:
> Continue: psmouse.c - synaptics touchpad driver sync problem":
> > You still need to use "dmesg -s 100000" even if you specifie logbuf_len.
> > Anyway, the data probably goes into /var/log/messages as well... If it
> is
> > there please send it my way (not on the list). I should be able to
> handle
> > 100K e-mail.
> 
> Of course, but there are still no other lines left...
> 
> I don't know how big I'd have to set the buffer, but I tried to set it to
> 2^25
> (~33E6), but then the buffer seems to be reset to default? What's the
> limit?
> 
> See the attachment for the 1E5 buffer.
> 

Still don't have the initialization part... Is there any way you could
make your /var/log/messages file accessible via ftp or http?

Anyway, I also have a tiy patch to try out (attached, not tested/
not compiled). Please let me know how ifit makes any improvement.

Thank you.

--
Dmitry
--0-145092153-1088172134=:64726
Content-Type: text/plain; name="i8042-muxerr.patch"
Content-Description: i8042-muxerr.patch
Content-Disposition: inline; filename="i8042-muxerr.patch"

diff -urN 2.6.7/drivers/input/serio/i8042.c linux-2.6.7/drivers/input/serio/i8042.c
--- 2.6.7/drivers/input/serio/i8042.c	2004-06-23 15:09:26.091494400 -0500
+++ linux-2.6.7/drivers/input/serio/i8042.c	2004-06-25 08:51:48.125136000 -0500
@@ -406,12 +406,12 @@
 	if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
 
 		if (str & I8042_STR_MUXERR) {
+			printk(KERN_INFO "i8042.c: MUX reports error condition %02x\n", data);
 			switch (data) {
 				case 0xfd:
 				case 0xfe: dfl = SERIO_TIMEOUT; break;
 				case 0xff: dfl = SERIO_PARITY; break;
 			}
-			data = 0xfe;
 		} else dfl = 0;
 
 		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",

--0-145092153-1088172134=:64726--
