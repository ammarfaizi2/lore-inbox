Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWISDVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWISDVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWISDVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:21:24 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:14181 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751700AbWISDVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:21:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=SMdt90Oi1z8FprcnR6i0/aI7EXVdsi5AkXsQoonjg4721OU/muxwy9kAPT+HQi6VBjAxCdReWbB1vRZ/rKck6vSFexe0FFxGVQvvC1r02j1ivkh7XLcWaRMVZVkCKkDhjKQd3myTqi3i3qxrFHF831Q8aP2xdw4cWk1VHLXTRlE=  ;
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Date: Mon, 18 Sep 2006 20:21:19 -0700
User-Agent: KMail/1.7.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609131558.03391.rjw@sisk.pl> <200609141319.53942.rjw@sisk.pl> <20060915154515.ae14372c.zaitcev@redhat.com>
In-Reply-To: <20060915154515.ae14372c.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609182021.19624.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 September 2006 3:45 pm, Pete Zaitcev wrote:
> On Thu, 14 Sep 2006 13:19:53 +0200, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > In fact I can reproduce it on two different boxes now.
> 
> How about the attached?
> 
> -- Pete

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


> diff -urp -X dontdiff linux-2.6.18-rc6/drivers/usb/host/ohci-hcd.c linux-2.6.18-rc6-lem/drivers/usb/host/ohci-hcd.c
> --- linux-2.6.18-rc6/drivers/usb/host/ohci-hcd.c	2006-09-06 21:56:32.000000000 -0700
> +++ linux-2.6.18-rc6-lem/drivers/usb/host/ohci-hcd.c	2006-09-14 22:48:15.000000000 -0700
> @@ -775,7 +775,9 @@ static void ohci_stop (struct usb_hcd *h
>  
>  	ohci_usb_reset (ohci);
>  	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> -	
> +	free_irq(hcd->irq, hcd);
> +	hcd->irq = -1;
> +
>  	remove_debug_files (ohci);
>  	unregister_reboot_notifier (&ohci->reboot_notifier);
>  	ohci_mem_cleanup (ohci);
> 
