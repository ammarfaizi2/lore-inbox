Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbVKWLgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbVKWLgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 06:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVKWLgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 06:36:51 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:61623 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030403AbVKWLgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 06:36:50 -0500
Date: Wed, 23 Nov 2005 09:36:55 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org, ehabkost@mandriva.com
Subject: Re: [PATCH 2/2] - usbserial: race-condition fix.
Message-Id: <20051123093655.5555f23e.lcapitulino@mandriva.com.br>
In-Reply-To: <20051122221353.GA10311@suse.de>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br>
	<20051122221353.GA10311@suse.de>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005 14:13:53 -0800
Greg KH <gregkh@suse.de> wrote:

| On Tue, Nov 22, 2005 at 07:59:26PM -0200, Luiz Fernando Capitulino wrote:
| > @@ -60,6 +61,7 @@ struct usb_serial_port {
| >  	struct usb_serial *	serial;
| >  	struct tty_struct *	tty;
| >  	spinlock_t		lock;
| > +	struct semaphore        sem;
| 
| You forgot to document what this semaphore is used for.

 Okay.

| Hm, can we just use the spinlock already present in the port structure
| for this?  Well, drop the spinlock and use the semaphore?  Yeah, that
| means grabbing a semaphore for ever write for some devices, but USB data
| rates are slow enough it wouldn't matter :)

 As far as I read the code, I found that spinlock is only used by the
generic driver, in the
drivers/usb/serial/generic.c:usb_serial_generic_write() function.

 Can we drop the spinlock there and use our new semaphore? Or should we
create a new spinlock just to use there?

 I ask it because the semaphore will be used to serialize open()/close()
operations in the usb-serial driver, is a bit weird to use the same
semaphore in a write() function of other driver.

-- 
Luiz Fernando N. Capitulino
