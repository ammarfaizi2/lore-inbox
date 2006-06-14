Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWFNONl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWFNONl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWFNONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:13:41 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:4750 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964958AbWFNONk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:13:40 -0400
Date: Wed, 14 Jun 2006 11:13:36 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Mark Lord <lkml@rtr.ca>, Greg KH <gregkh@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] clean tty fields on failed device open
Message-ID: <20060614111336.30c6e5e7@doriath.conectiva>
In-Reply-To: <20060614135205.GA5814@fks.be>
References: <20060612204918.GA16898@suse.de>
	<448DD968.2010000@rtr.ca>
	<20060612212812.GA17458@suse.de>
	<448DE28D.3040708@rtr.ca>
	<448DF6F6.2050803@rtr.ca>
	<20060613114604.GB10834@fks.be>
	<20060613132655.03bcc1d3@doriath.conectiva>
	<20060613144512.22526797@doriath.conectiva>
	<20060614115229.GA20751@fks.be>
	<20060614104918.09fc175a@doriath.conectiva>
	<20060614135205.GA5814@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 15:52:05 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Wed, Jun 14, 2006 at 10:49:18AM -0300, Luiz Fernando N. Capitulino wrote:
| >  Hmm, I'd prefer something like this:
| 
| OK
| 
| If either the driver's open() method or try_module_get() fails, we need to
| set 'tty->driver_data' and 'port->tty' to NULL in serial_open(), otherwise
| we'll get an OOPS in usb_device_disconnect() when the device is disconnected.
| 
| Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

Acked-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

| 
| diff -urp linux-2.6.17-rc6/drivers/usb/serial/usb-serial.c linux-2.6.17-rc6.a/drivers/usb/serial/usb-serial.c
| --- linux-2.6.17-rc6/drivers/usb/serial/usb-serial.c	2006-06-14 13:03:55.000000000 +0200
| +++ linux-2.6.17-rc6.a/drivers/usb/serial/usb-serial.c	2006-06-14 13:23:34.000000000 +0200
| @@ -230,6 +232,8 @@ bailout_module_put:
|  	module_put(serial->type->driver.owner);
|  bailout_mutex_unlock:
|  	port->open_count = 0;
| +	tty->driver_data = NULL;
| +	port->tty = NULL;
|  	mutex_unlock(&port->mutex);
|  bailout_kref_put:
|  	kref_put(&serial->kref, destroy_serial);
| 
| -- 
| Frank Gevaerts                                 frank.gevaerts@fks.be
| fks bvba - Formal and Knowledge Systems        http://www.fks.be/
| Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
| B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19


-- 
Luiz Fernando N. Capitulino
