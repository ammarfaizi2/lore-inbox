Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbTJPICG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTJPICF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:02:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:15565 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262748AbTJPICA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:02:00 -0400
Date: Thu, 16 Oct 2003 10:01:59 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: jgarzik@pobox.com, wind@cocodriloo.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031015172030.GA20098@wind.cocodriloo.com>
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <17122.1066291319@www7.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen problems like this when a bad driver was spending loads of time
in it's SA_INTERRUPT (ie meant to be 'fast') IRQ handler ...this buffered up
*lots * of packets to be handled, and caused this message.

Perhaps we should profile?

Dan

> On Tue, Oct 14, 2003 at 02:02:48PM -0400, Jeff Garzik wrote:
> > Antonio Vargas wrote:
> > >This happens to me also on 2.4.18 and 2.4.19 (yes, I know they are
> old).
> > >
> > >Happens about once every 5 months, with the box running at
> > >about 1 month uptime per reboot (home server, there is no UPS)
> > 
> > 
> > It's fairly normal for this event to occur.  It's due to the 8139 
> > hardware..  sometimes (perhaps during a DoS or ping flood) you can 
> > receive far more tiny packets than the driver wishes to deal with in a 
> > single interrupt.
> > 
> > The real solution is to convert the driver to NAPI...
> > 
> > 	Jeff
> 
> NAPI is the method where you block hardware interrupts and
> then handle the data by periodic polling? I wonder how could
> I get this error, given that my network is a 10Mbit one ;)
> 
> -- 
> winden/network
> 
> 1. Dado un programa, siempre tiene al menos un fallo.
> 2. Dadas varias lineas de codigo, siempre se pueden acortar a menos
> lineas.
> 3. Por induccion, todos los programas se pueden
>    reducir a una linea que no funciona.
> 

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

