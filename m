Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVIFOuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVIFOuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVIFOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:50:14 -0400
Received: from main.gmane.org ([80.91.229.2]:45780 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750700AbVIFOuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:50:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: Patch for link detection for R8169
Date: Tue, 06 Sep 2005 16:46:55 +0200
Message-ID: <pan.2005.09.06.14.46.50.324819@free.fr>
References: <431DA887.2010008@zabrze.zigzag.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 06 Sep 2005 16:32:39 +0200, Miroslaw Mieszczak a écrit :

> There is a patch to driver of RLT8169 network card. This match make 
> possible detection of the link status even if network interface is down.
> This is usefull for laptop users.
> 
> 
> 
> --- r8169.c	2005-09-02 15:34:52.000000000 +0200
> +++ linux/drivers/net/r8169.c	2005-09-05 21:11:15.000000000 +0200
> @@ -538,14 +538,27 @@
>  
>  static unsigned int rtl8169_tbi_link_ok(void __iomem *ioaddr)
>  {
> -	return RTL_R32(TBICSR) & TBILinkOk;
> +	return (RTL_R32(TBICSR) & TBILinkOk) == TBILinkOk ? 1:0;
>  }
>  
>  static unsigned int rtl8169_xmii_link_ok(void __iomem *ioaddr)
>  {
> -	return RTL_R8(PHYstatus) & LinkStatus;
> +	return (RTL_R8(PHYstatus) & LinkStatus) == LinkStatus ? 1:0;
>  }
>  
(a==b)?1:0 is stupid just use (a==b) ...
And in this case I am sure we care only if it is null or non-null,
so there no need to change that...

