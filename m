Return-Path: <linux-kernel-owner+w=401wt.eu-S1752317AbWLVTYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWLVTYf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbWLVTYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:24:34 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:42256 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752317AbWLVTYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:24:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=jeEwx3l5DjxQ1kYv9rS777RxySjg0tOs+Zo21FOk7MQ2K++8mv1GdyTqF9bTseGbJ+03N4wspShOtr/76UVxygABEwIaU28CI9Il4Tk7jX3wCxj5XTGxMPGzDtJ5dt3kQ741y9QpqfIsTG5HoA30Ec/j5Ugd+mOPU9WDprAcigo=  ;
X-YMail-OSG: sJy0BGMVM1l0b2ViDJ5.oD..8pooKlRiELMmmbr8LQtE82roxiHMhwL3Zl39jvMSwK8LN4rQKfiZgaM6cOmSNjuiUJ9nPHu9ja0ta5yChmN_sQqFOF_lMb8vuKQN_GYwI.p_.YpkXYhHAg--
Date: Fri, 22 Dec 2006 11:24:31 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 5/6] input: ads7846 forces SPI mode 1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192431.72EDB1F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@nokia.com>
Date:  Fri May 26 16:30:10 2006 -0700

Input: ads7846: select correct SPI mode
    
Talk to ADS7846 chip using SPI mode 1, which is what the chip
supports:  writes on falling clock edge, reads on rising.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:45.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:46.000000000 -0800
@@ -773,6 +773,10 @@ static int __devinit ads7846_probe(struc
 	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
 	 */
 	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_1;
+	err = spi_setup(spi);
+	if (err < 0)
+		return err;
 
 	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
 	input_dev = input_allocate_device();
