Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279374AbRJWLXm>; Tue, 23 Oct 2001 07:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279375AbRJWLX3>; Tue, 23 Oct 2001 07:23:29 -0400
Received: from hermes.domdv.de ([193.102.202.1]:20228 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279378AbRJWLVm>;
	Tue, 23 Oct 2001 07:21:42 -0400
Message-ID: <XFMail.20011023132050.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.6-3.Linux:20011023130727:5243=_"
Date: Tue, 23 Oct 2001 13:20:50 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] BOOTP Standalone Floppy Boot (2.4.13pre6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.6-3.Linux:20011023130727:5243=_
Content-Type: text/plain; charset=us-ascii

If using 2.4.x standalone floppy boot (i.e. dd if=vmlinuz of=/dev/fd0, then
booting from this floppy) with a BOOTP/NFS root enabled kernel fails. This
behaviour is different from 2.2.x. 2.4.x uses:

__setup("ip=", ip_auto_config_setup);
__setup("nfsaddrs=", nfsaddrs_config_setup);

None of these are called when there are no boot parameters. In case of
standalone floppy boot there are NO boot parameters. This results in no BOOTP
and NFS root configuration done and thus boot failure.

The fix is to set ic_enable to 1 as the default to get the same beaviour as for
2.2.x.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.4.6-3.Linux:20011023130727:5243=_
Content-Disposition: attachment; filename="ipconfig1.patch"
Content-Transfer-Encoding: 7bit
Content-Description: ipconfig1.patch
Content-Type: text/plain; charset=us-ascii; name=ipconfig1.patch; SizeOnDisk=398

--- linux/net/ipv4/ipconfig.c	Tue Oct 23 12:58:28 2001
+++ linux-fixed/net/ipv4/ipconfig.c	Tue Oct 23 12:55:02 2001
@@ -100,7 +100,7 @@
  */
 int ic_set_manually __initdata = 0;		/* IPconfig parameters set manually */
 
-int ic_enable __initdata = 0;			/* IP config enabled? */
+int ic_enable __initdata = 1;			/* IP config enabled? */
 
 /* Protocol choice */
 int ic_proto_enabled __initdata = 0

--_=XFMail.1.4.6-3.Linux:20011023130727:5243=_--
End of MIME message
