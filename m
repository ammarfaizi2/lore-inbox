Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270371AbTGSSVK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGSSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:21:10 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:60820
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S270371AbTGSSUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:20:51 -0400
Message-ID: <794001c34e24$d8f83440$7f0a0a0a@lappy7>
Reply-To: "Sean" <seanlkml@rogers.com>
From: "Sean" <seanlkml@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH]  "blk: request botched" error on floppy write
Date: Sat, 19 Jul 2003 14:37:45 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_793D_01C34E03.51ADF810"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.102.213.186] using ID <seanlkml@rogers.com> at Sat, 19 Jul 2003 14:35:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_793D_01C34E03.51ADF810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The floppy drive appears to be working for some people with the 
2.6 kernel as is.  However, there have also been reports of some
problems (see http://bugme.osdl.org/show_bug.cgi?id=654 )

The attached patch against 2.6.0-test1 fixes the problem on all the 
machines i've tested.

Cheers,
Sean

------=_NextPart_000_793D_01C34E03.51ADF810
Content-Type: application/octet-stream;
	name="floppy_req_botched.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="floppy_req_botched.patch"

--- test1/drivers/block/floppy.c.old	Sat Jul 19 13:48:18 2003=0A=
+++ test1/drivers/block/floppy.c	Sat Jul 19 13:52:07 2003=0A=
@@ -4261,6 +4261,7 @@=0A=
 			floppy_sizes[i] =3D MAX_DISK_SIZE << 1;=0A=
 =0A=
 	blk_init_queue(&floppy_queue, do_fd_request, &floppy_lock);=0A=
+	blk_queue_max_hw_segments(&floppy_queue, 1); =0A=
 	reschedule_timeout(MAXTIMEOUT, "floppy init", MAXTIMEOUT);=0A=
 	config_types();=0A=
 =0A=

------=_NextPart_000_793D_01C34E03.51ADF810--

