Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283594AbRLWFOx>; Sun, 23 Dec 2001 00:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283618AbRLWFOn>; Sun, 23 Dec 2001 00:14:43 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:7691 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283594AbRLWFOf>;
	Sun, 23 Dec 2001 00:14:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Phil Brutsche <pbrutsch@tux.creighton.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        usb@in.tum.de
Subject: Re: [PATCH] 2.4.17 compile error + fix 
In-Reply-To: Your message of "22 Dec 2001 22:28:56 MDT."
             <1009081736.968.0.camel@fury> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 16:14:22 +1100
Message-ID: <22287.1009084462@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Dec 2001 22:28:56 -0600, 
Phil Brutsche <pbrutsch@tux.creighton.edu> wrote:
>diff -urN linux/drivers/usb/usb-uhci.c
>linux-2.4.17-modified/drivers/usb/usb-uhci.c
>--- linux/drivers/usb/usb-uhci.c        Fri Dec 21 11:41:55 2001
>+++ linux-2.4.17-modified/drivers/usb/usb-uhci.c        Sat Dec 22
>22:10:27 2001
>@@ -3001,7 +3001,7 @@
>        s->irq = irq;
>
>        if(uhci_start_usb (s) < 0) {
>-               uhci_pci_remove(dev);
>+               __devexit_p (uhci_pci_remove(dev));
>                return -1;
>        }
>
>The resulting kernel boots fine on a PII; there are no problems with
>hot-plugging USB devices.
>
>Marcelo, please consider for 2.4.18.

Do not apply, the code is wrong, uhci_pci_remove is called from
mainline code.  If the mainline code is correct then uhci_pci_remove
must not be defined as __devexit/__devexit_p.  If uhci_pci_remove is
not supposed to be called then the mainline code has to be changed.  In
either case, it is a job for the uhci maintainer.

