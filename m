Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWFNNtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWFNNtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWFNNtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:49:23 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:29111 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964928AbWFNNtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:49:23 -0400
Date: Wed, 14 Jun 2006 10:49:18 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Mark Lord <lkml@rtr.ca>, Greg KH <gregkh@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] clean tty fields on failed device open
Message-ID: <20060614104918.09fc175a@doriath.conectiva>
In-Reply-To: <20060614115229.GA20751@fks.be>
References: <448DD50F.3060002@rtr.ca>
	<448DC93E.9050200@rtr.ca>
	<20060612204918.GA16898@suse.de>
	<448DD968.2010000@rtr.ca>
	<20060612212812.GA17458@suse.de>
	<448DE28D.3040708@rtr.ca>
	<448DF6F6.2050803@rtr.ca>
	<20060613114604.GB10834@fks.be>
	<20060613132655.03bcc1d3@doriath.conectiva>
	<20060613144512.22526797@doriath.conectiva>
	<20060614115229.GA20751@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 13:52:30 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Tue, Jun 13, 2006 at 02:45:12PM -0300, Luiz Fernando N. Capitulino wrote:
| >  Could you redo and submit please?
| 
| OK. Here it is:
| 
| Fixes a BUG on disconnect. gregkh-usb-usb-rmmod-pl2303-after-28.patch (from -mm trees)
| is also needed to fix all problems.

 Hmm, I'd prefer something like this:

"""
If either the driver's open() method or try_module_get() fails, we need to
set 'tty->driver_data' and 'port->tty' to NULL in serial_open(), otherwise
we'll get an OOPS in usb_device_disconnect() when the device is disconnected.
"""

-- 
Luiz Fernando N. Capitulino
