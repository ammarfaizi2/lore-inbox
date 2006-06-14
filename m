Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWFNLw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWFNLw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 07:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWFNLw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 07:52:59 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:44934 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1750995AbWFNLw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 07:52:59 -0400
Date: Wed, 14 Jun 2006 13:52:30 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Mark Lord <lkml@rtr.ca>,
       Greg KH <gregkh@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] clean tty fields on failed device open
Message-ID: <20060614115229.GA20751@fks.be>
References: <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca> <448DF6F6.2050803@rtr.ca> <20060613114604.GB10834@fks.be> <20060613132655.03bcc1d3@doriath.conectiva> <20060613144512.22526797@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613144512.22526797@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.815,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 02:45:12PM -0300, Luiz Fernando N. Capitulino wrote:
>  Could you redo and submit please?

OK. Here it is:

Fixes a BUG on disconnect. gregkh-usb-usb-rmmod-pl2303-after-28.patch (from -mm trees)
is also needed to fix all problems.

Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

diff -urp linux-2.6.17-rc6/drivers/usb/serial/usb-serial.c linux-2.6.17-rc6.a/drivers/usb/serial/usb-serial.c
--- linux-2.6.17-rc6/drivers/usb/serial/usb-serial.c	2006-06-14 13:03:55.000000000 +0200
+++ linux-2.6.17-rc6.a/drivers/usb/serial/usb-serial.c	2006-06-14 13:23:34.000000000 +0200
@@ -230,6 +232,8 @@ bailout_module_put:
 	module_put(serial->type->driver.owner);
 bailout_mutex_unlock:
 	port->open_count = 0;
+	tty->driver_data = NULL;
+	port->tty = NULL;
 	mutex_unlock(&port->mutex);
 bailout_kref_put:
 	kref_put(&serial->kref, destroy_serial);

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19
