Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVLMA17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVLMA17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVLMA17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:27:59 -0500
Received: from mail.dvmed.net ([216.237.124.58]:2247 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932277AbVLMA16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:27:58 -0500
Message-ID: <439E1581.40808@pobox.com>
Date: Mon, 12 Dec 2005 19:27:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: Re: [patch 4/4] UHCI: add missing memory barriers
References: <20051212192030.873030000@press.kroah.org> <20051212200136.GE27657@kroah.com>
In-Reply-To: <20051212200136.GE27657@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Greg Kroah-Hartman wrote: > From: Alan Stern
	<stern@rowland.harvard.edu> > > This patch (as617) adds a couple of
	memory barriers that Ben H. forgot in > his recent suspend/resume fix.
	> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu> >
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de> > > --- >
	drivers/usb/host/uhci-hcd.c | 2 ++ > 1 file changed, 2 insertions(+) >
	> --- greg-2.6.orig/drivers/usb/host/uhci-hcd.c > +++
	greg-2.6/drivers/usb/host/uhci-hcd.c > @@ -717,6 +717,7 @@ static int
	uhci_suspend(struct usb_hcd * > * at the source, so we must turn off
	PIRQ. > */ > pci_write_config_word(to_pci_dev(uhci_dev(uhci)),
	USBLEGSUP, 0); > + mb(); > clear_bit(HCD_FLAG_HW_ACCESSIBLE,
	&hcd->flags); > uhci->hc_inaccessible = 1; > hcd->poll_rh = 0; > @@
	-738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h > * really
	don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0 > */ >
	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags); > + mb(); [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> This patch (as617) adds a couple of memory barriers that Ben H. forgot in
> his recent suspend/resume fix.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/usb/host/uhci-hcd.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- greg-2.6.orig/drivers/usb/host/uhci-hcd.c
> +++ greg-2.6/drivers/usb/host/uhci-hcd.c
> @@ -717,6 +717,7 @@ static int uhci_suspend(struct usb_hcd *
>  	 * at the source, so we must turn off PIRQ.
>  	 */
>  	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
> +	mb();
>  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
>  	uhci->hc_inaccessible = 1;
>  	hcd->poll_rh = 0;
> @@ -738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h
>  	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
>  	 */
>  	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> +	mb();

Are these just guesses, or what?

Why not smp_mb__before_clear_bit() or smp_mb__after_clear_bit() ?

	Jeff



