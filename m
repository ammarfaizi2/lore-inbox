Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbVLRLal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVLRLal (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 06:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVLRLal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 06:30:41 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:12946 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932683AbVLRLal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 06:30:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: gcoady@gmail.com
Subject: Re: 2.6.15-rc5-mm3
Date: Sun, 18 Dec 2005 12:31:55 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>
References: <20051214234016.0112a86e.akpm@osdl.org> <276aq1pc2us3np77rd8p6gvifbdj4nf2vd@4ax.com>
In-Reply-To: <276aq1pc2us3np77rd8p6gvifbdj4nf2vd@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181231.55981.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 18 December 2005 09:16, Grant Coady wrote:
> On Wed, 14 Dec 2005 23:40:16 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> >  Probably-unfixed bugs from -mm1 and -mm2 include:
> [...]
> >  - Grant Coady <grant_lkml@dodo.com.au>: "Locked up on boot just after
> >    USB 2.0 initialised, EHCI 1.00 ..."
> 
> With ehci compiled in I get a kernel panic during boot, ehci as module 
> and the things boots.  Then 'modprobe ehci_hcd' provokes a similar panic :(
> 
> Nothing useful in logs.

Could you please use the appended patch and see if that makes things better
(or worse)?

Greetings,
Rafael


 drivers/usb/host/ehci-hcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc5-mm2/drivers/usb/host/ehci-hcd.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/drivers/usb/host/ehci-hcd.c	2005-12-11 13:57:27.000000000 +0100
+++ linux-2.6.15-rc5-mm2/drivers/usb/host/ehci-hcd.c	2005-12-13 22:10:53.000000000 +0100
@@ -617,7 +617,7 @@
 	}
 
 	/* remote wakeup [4.3.1] */
-	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
+	if (status & STS_PCD) {
 		unsigned	i = HCS_N_PORTS (ehci->hcs_params);
 
 		/* resume root hub? */
