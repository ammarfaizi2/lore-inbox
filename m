Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVIJVRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVIJVRv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVIJVRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:17:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:9446 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932127AbVIJVRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:17:51 -0400
Date: Sat, 10 Sep 2005 14:17:11 -0700
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 5/10] drivers/char: pci_find_device remove (drivers/char/specialix.c)
Message-ID: <20050910211711.GA13660@suse.de>
References: <200509101221.j8ACL9XI017246@localhost.localdomain> <43234860.7050206@pobox.com> <43234972.3010003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43234972.3010003@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 11:00:34PM +0200, Jiri Slaby wrote:
> Jeff Garzik napsal(a):
> >Jiri Slaby wrote:
> >
> >>Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> >>
> >> specialix.c |    9 ++++++---
> >> 1 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/char/specialix.c b/drivers/char/specialix.c
> >>--- a/drivers/char/specialix.c
> >>+++ b/drivers/char/specialix.c
> >>@@ -2502,9 +2502,9 @@ static int __init specialix_init(void)
> >>                 i++;
> >>                 continue;
> >>             }
> >>-            pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
> >>-                                    PCI_DEVICE_ID_SPECIALIX_IO8, 
> >>-                                    pdev);
> >>+            pdev = pci_get_device (PCI_VENDOR_ID_SPECIALIX,
> >>+                    PCI_DEVICE_ID_SPECIALIX_IO8,
> >>+                    pdev);
> >>             if (!pdev) break;
> >> 
> >>             if (pci_enable_device(pdev))
> >>@@ -2517,7 +2517,10 @@ static int __init specialix_init(void)
> >>             sx_board[i].flags |= SX_BOARD_IS_PCI;
> >>             if (!sx_probe(&sx_board[i]))
> >>                 found ++;
> >>+
> >>         }
> >>+        if (i >= SX_NBOARD)
> >>+            pci_dev_put(pdev);
> >
> >
> >should be converted to PCI probing, rather than this.
> I won't do that, i did that for 2 drivers and nobody was interested in 
> that (and its much time left for nothing). These (unrewritten) drivers 
> would be deleted in some time. Greg wants simply wipe this function out.

No, I want it done correctly.  If I simply wanted the function removed,
I would have done this kind of wholesale conversion a long time ago.

If the code needs to be converted to the proper pci probing logic,
that's the better way to do it, and that's what should be done.

thanks,

greg k-h
