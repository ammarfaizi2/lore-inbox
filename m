Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUDPSmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUDPSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:42:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39887 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263600AbUDPSmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:42:43 -0400
Date: Fri, 16 Apr 2004 14:42:28 -0400
From: Bill Nottingham <notting@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] oops when loading ehci_hcd
Message-ID: <20040416184228.GA7597@nostromo.devel.redhat.com>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20040416082311.GA2756@nostromo.devel.redhat.com> <4080229B.4020307@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4080229B.4020307@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell (david-b@pacbell.net) said: 
> Bill Nottingham wrote:
> >With a 2.6.6-rc1 based kernel. Happened when loading ehci_hcd some
> >10 hours after booting, couldn't reproduce in initial attempts. I
> >suppose the question is also why it failed to init, but it certainly
> >didn't like the failure...
> 
> Hmm, no it didn't.  The "illegal capability" is the hardware acting
> broken (what kind of EHCI hardware?); I've had reports of similar
> stuff happening after ACPI resume (bogus PCI config space values,
> in this case zero).

In fact, I believe I did do suspend/resume at some point previous
in the day. Thinkpad T40p - the ACPI suspend/resume probably explains
why it didn't happen again after reboot.

> --- 1.75/drivers/usb/host/ehci-hcd.c	Wed Apr 14 20:20:58 2004
> +++ edited/drivers/usb/host/ehci-hcd.c	Fri Apr 16 11:03:50 2004
> @@ -592,7 +592,8 @@
>  
>  	/* root hub is shut down separately (first, when possible) */
>  	spin_lock_irq (&ehci->lock);
> -	ehci_work (ehci, NULL);
> +	if (ehci->async)
> +		ehci_work (ehci, NULL);
>  	spin_unlock_irq (&ehci->lock);
>  	ehci_mem_cleanup (ehci);

Will try that at some point, thanks!

Bill

