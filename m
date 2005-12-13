Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVLMDDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVLMDDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVLMDDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:03:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:55011 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932378AbVLMDDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:03:34 -0500
Date: Mon, 12 Dec 2005 19:03:12 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: Re: [patch 4/4] UHCI: add missing memory barriers
Message-ID: <20051213030312.GA1617@suse.de>
References: <20051212192030.873030000@press.kroah.org> <20051212200136.GE27657@kroah.com> <439E1581.40808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439E1581.40808@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 07:27:45PM -0500, Jeff Garzik wrote:
> Greg Kroah-Hartman wrote:
> >From: Alan Stern <stern@rowland.harvard.edu>
> >
> >This patch (as617) adds a couple of memory barriers that Ben H. forgot in
> >his recent suspend/resume fix.
> >
> >Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >
> >---
> > drivers/usb/host/uhci-hcd.c |    2 ++
> > 1 file changed, 2 insertions(+)
> >
> >--- greg-2.6.orig/drivers/usb/host/uhci-hcd.c
> >+++ greg-2.6/drivers/usb/host/uhci-hcd.c
> >@@ -717,6 +717,7 @@ static int uhci_suspend(struct usb_hcd *
> > 	 * at the source, so we must turn off PIRQ.
> > 	 */
> > 	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
> >+	mb();
> > 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> > 	uhci->hc_inaccessible = 1;
> > 	hcd->poll_rh = 0;
> >@@ -738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h
> > 	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
> > 	 */
> > 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> >+	mb();
> 
> Are these just guesses, or what?
> 
> Why not smp_mb__before_clear_bit() or smp_mb__after_clear_bit() ?

I don't know, Alan?
