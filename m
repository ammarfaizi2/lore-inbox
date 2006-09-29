Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbWI2B1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWI2B1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWI2B1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:27:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41346 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161260AbWI2B1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:27:42 -0400
Message-Id: <200609290051.k8T0psZL014050@laptop13.inf.utfsm.cl>
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] More USB patches for 2.6.18 
In-Reply-To: Message from Andrew Morton <akpm@osdl.org> 
   of "Thu, 28 Sep 2006 16:59:51 MST." <20060928165951.2c5bd4c7.akpm@osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Thu, 28 Sep 2006 20:51:54 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:34:42 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 28 Sep 2006 21:26:44 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

[...]

> That's the "some gccs dont like static function decls in that scope" thing.
> 
> I fixed it (unpleasantly) like this:
> 
> 
> diff -puN drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack drivers/usb/host/ohci-hub.c
> --- a/drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack
> +++ a/drivers/usb/host/ohci-hub.c
> @@ -132,6 +132,10 @@ static inline struct ed *find_head (stru
>  	return ed;
>  }
>  
> +#ifdef CONFIG_PM
> +static int ohci_restart(struct ohci_hcd *ohci);
> +#endif
> +

The #ifdef is unneeded here.

>  /* caller has locked the root hub */
>  static int ohci_rh_resume (struct ohci_hcd *ohci)
>  __releases(ohci->lock)
> @@ -181,8 +185,6 @@ __acquires(ohci->lock)
>  #ifdef	CONFIG_PM
>  	if (status == -EBUSY) {
>  		if (!autostopped) {
> -			static int ohci_restart (struct ohci_hcd *ohci);
> -
>  			spin_unlock_irq (&ohci->lock);
>  			(void) ohci_init (ohci);
>  			status = ohci_restart (ohci);
> _
> 
> -
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
