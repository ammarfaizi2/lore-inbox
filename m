Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWHORaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWHORaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWHORaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:30:17 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:43127 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030375AbWHORaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:30:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=U8zQqSTl6m0JBkeEXgXOp8KlxsTNlOmFY/G8LbEg1T1vk5P/DUjyHbegaPRyGNbKwR4NmpGKSofFFBB3EJR5pJJ124IxPhanZ1GQY96ityYPe6pQJlwD3YcgkOjaKFohuBWginNIdH0lIOku6UhZoFw70fde/ROwvZwK2LnS1Ak=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: CONFIG_NETDEVICES does not do anything
Date: Tue, 15 Aug 2006 19:29:57 +0200
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0608100831580.10926@yvahk01.tjqt.qr> <20060813192723.GC21487@mars.ravnborg.org>
In-Reply-To: <20060813192723.GC21487@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151929.57504.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 21:27, Sam Ravnborg wrote:
> On Thu, Aug 10, 2006 at 08:34:30AM +0200, Jan Engelhardt wrote:
> > Hello,
> >
> >
> > when deselecting CONFIG_NETDEVICES, many selectable items (PHY device
> > support, Ethernet 10/100/1000/10000) stay in place. Is there a reason
> > they are lacking 'depends on NETDEVICES' or did I found a bug^W glitch?
>
> It was changed by appended commit.
> I do not see why the if/endif was removed - Paolo?

I did not consider the "enable NET disable NETDEVICES" case, I was too much in 
a hurry. Sorry for that.

> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 6a6a084..47c72a6 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -4,9 +4,9 @@ # Network device configuration
>  #
>
>  menu "Network device support"
> +	depends on NET
>
>  config NETDEVICES
> -	depends on NET
>  	default y if UML
>  	bool "Network device support"
>  	---help---

This hunk can be left, it's just the below ones which needs to be reversed.

> @@ -24,9 +24,6 @@ config NETDEVICES
>
>  	  If unsure, say Y.
>
> -# All the following symbols are dependent on NETDEVICES - do not repeat
> -# that for each of the symbols.
> -if NETDEVICES
>
>  config IFB
>  	tristate "Intermediate Functional Block support"
> @@ -2718,8 +2715,6 @@ config NETCONSOLE
>  	If you want to log kernel messages over the network, enable this.
>  	See <file:Documentation/networking/netconsole.txt> for details.
>
> -endif #NETDEVICES
> -
>  config NETPOLL
>  	def_bool NETCONSOLE

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
