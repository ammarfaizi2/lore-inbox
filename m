Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVATPZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVATPZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVATPZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:25:30 -0500
Received: from users.linvision.com ([62.58.92.114]:20634 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262152AbVATPW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:22:58 -0500
Date: Thu, 20 Jan 2005 16:22:56 +0100
From: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, bryder@sgi.com, kuba@mareimbrium.org,
       ftdi-usb-sio-devel@lists.sourceforge.net, edwin@harddisk-recovery.nl
Subject: Re: Bug when using custom baud rates....
Message-ID: <20050120152256.GA3614@bitwizard.nl>
References: <20050120145422.GB18037@bitwizard.nl> <20050120150857.GH13036@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20050120150857.GH13036@kroah.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 20, 2005 at 07:08:58AM -0800, Greg KH wrote:
> On Thu, Jan 20, 2005 at 03:54:22PM +0100, Rogier Wolff wrote:
> > Hi,
> > 
> > When using custom baud rates, the code does: 
> > 
> > 
> >        if ((new_serial.baud_base != priv->baud_base) ||
> >             (new_serial.baud_base < 9600))
> >                 return -EINVAL;
> > 
> > Which translates to english as: 
> > 
> > 	If you changed the baud-base, OR the new one is
> > 	invalid, return invalid. 
> > 
> > but it should be:
> > 
> > 	If you changed the baud-base, OR the new one is
> > 	invalid, return invalid. 
> 
> You mean AND, not OR here, right?  :)

:-) Sorry. Too noisy here. 

> > Patch attached. 
> 
> Have a 2.6 patch?

Patch told me: 
   patching file drivers/usb/serial/ftdi_sio.c
   Hunk #1 succeeded at 1137 (offset 156 lines).

but the resulting patch is attached. 

		Roger. 

-- 
+-- Rogier Wolff -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Files foetsie, bestanden kwijt, alle data weg?!
| Blijf kalm en neem contact op met Harddisk-recovery.nl!

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ftdi_2.6fix"

diff -ur linux-2.6.11-r1-clean/drivers/usb/serial/ftdi_sio.c linux-2.6.11-r1-ftdio_fix/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.11-r1-panoramix/drivers/usb/serial/ftdi_sio.c	Wed Jan 12 09:19:32 2005
+++ linux-2.6.11-r1-ftdio_fix/drivers/usb/serial/ftdi_sio.c	Thu Jan 20 16:20:24 2005
@@ -1137,7 +1137,7 @@
 		goto check_and_exit;
 	}
 
-	if ((new_serial.baud_base != priv->baud_base) ||
+	if ((new_serial.baud_base != priv->baud_base) &&
 	    (new_serial.baud_base < 9600))
 		return -EINVAL;
 

--BXVAT5kNtrzKuDFl--
