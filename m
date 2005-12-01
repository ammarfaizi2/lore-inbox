Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVLAVBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVLAVBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVLAVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:01:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53635 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932459AbVLAVA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:00:59 -0500
Subject: Re: Gene's pcHDTV 3000 analog problem
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Perry Gilfillan <perrye@linuxmail.org>,
       Hartmut Hackmann <hartmut.hackmann@t.online.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>, Don Koch <aardvark@krl.com>,
       Michael Krufky - V4L <mkrufky@m1k.net>
In-Reply-To: <438F38E6.7090303@m1k.net>
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
	 <c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>
	 <438CFFAD.7070803@m1k.net>	<200511300007.56004.gene.heskett@verizon.net>
	 <438D38B3.2050306@m1k.net>	<200511301553.jAUFrSQx026450@p-chan.krl.com>
	 <438E7107.3000407@linuxmail.org>	<438E8365.4020200@linuxmail.org>
	 <438E84A4.8000601@m1k.net> <438E8A58.4010003@linuxmail.org>
	 <438EBD43.3080400@linuxmail.org>  <438F38E6.7090303@m1k.net>
Content-Type: multipart/mixed; boundary="=-Gba+dDciAmLrDIoWKGbI"
Date: Thu, 01 Dec 2005 19:00:59 -0200
Message-Id: <1133470859.23362.59.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.103.127.81 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.103.127.81 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gba+dDciAmLrDIoWKGbI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

	After checking the datasheets of Thompson tuner, and I have one guess:

	At board description, tda9887 is not there. This tuner needs to work
properly.

	This small patch does enable it for your board.

	You should notice that you may need to use some parameters for tda0887
to work properly, like using port1=0 port2=0 qss=0 as insmod options for
this module. (these are some on/off bits at the chip, to enable some
special functions - if 0/0/0 doesn't work you may need to test 0/0/1, ..
1/1/1).

Cheers, 
Mauro.

--=-Gba+dDciAmLrDIoWKGbI
Content-Disposition: attachment; filename=v4l_ena_tda9887.patch
Content-Type: text/x-patch; name=v4l_ena_tda9887.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: linux/drivers/media/video/cx88/cx88-cards.c
===================================================================
RCS file: /cvs/video4linux/v4l-dvb/linux/drivers/media/video/cx88/cx88-cards.c,v
retrieving revision 1.108
diff -u -p -r1.108 cx88-cards.c
--- linux/drivers/media/video/cx88/cx88-cards.c	25 Nov 2005 10:24:13 -0000	1.108
+++ linux/drivers/media/video/cx88/cx88-cards.c	1 Dec 2005 20:56:43 -0000
@@ -569,6 +569,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,

--=-Gba+dDciAmLrDIoWKGbI--

