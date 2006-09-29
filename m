Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWI2AIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWI2AIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWI2AIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:08:40 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:28238 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965043AbWI2AIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:08:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YiTFA37WbsRH1FMs+gJbYJuXTrxyB57A+JhGagsCGnhAKfBakHpn3Voq9HbRL2a+31ZrcY9Zw2w6KuUtagej+52da0oegwseGFcLfzVco1AvuZTd/alEODaZT0Jfy7rT+bsRoxFubv/eyf+U1IvajCaG98d1KDmB2+UIMQ1Ni1A=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [GIT PATCH] More USB patches for 2.6.18
Date: Thu, 28 Sep 2006 17:08:33 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <20060928224250.GA23841@kroah.com> <Pine.LNX.4.64.0609281639040.3952@g5.osdl.org> <20060928165951.2c5bd4c7.akpm@osdl.org>
In-Reply-To: <20060928165951.2c5bd4c7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281708.34599.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>  /* caller has locked the root hub */

Better to just always include the forward decl... much cleaner!

... reviewing and testing those new OHCI changes is still on my
list; all that suspend stuff needs care, things that work on PCs don't
necessarily work on embedded hardware (where OHCI is common, and
PM tends to be more critical).

- Dave

