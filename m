Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVAGTe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVAGTe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVAGTey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:34:54 -0500
Received: from galileo.bork.org ([134.117.69.57]:3724 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261547AbVAGTdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:33:54 -0500
Date: Fri, 7 Jan 2005 14:33:54 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Marco Cipullo <cipullo@libero.it>, clameter@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: From last __GFP_ZERO changes
Message-ID: <20050107193354.GT18461@localhost>
References: <200501061243.58968.cipullo@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501061243.58968.cipullo@libero.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jan 06, 2005 at 12:43:58PM +0100, Marco Cipullo wrote:
> From last __GFP_ZERO changes:
> 
> --- a/drivers/block/pktcdvd.c	2005-01-06 03:27:45 -08:00
> +++ b/drivers/block/pktcdvd.c	2005-01-06 03:27:45 -08:00
> @@ -135,12 +135,10 @@
>  		goto no_bio;
>  
>  	for (i = 0; i < PAGES_PER_PACKET; i++) {
> -		pkt->pages[i] = alloc_page(GFP_KERNEL);
> +		pkt->pages[i] = alloc_page(GFP_KERNEL|| __GFP_ZERO);
> 
> Is this OK?
> 
> Or should be
> 
>  	for (i = 0; i < PAGES_PER_PACKET; i++) {
> -		pkt->pages[i] = alloc_page(GFP_KERNEL);
> +		pkt->pages[i] = alloc_page(GFP_KERNEL| __GFP_ZERO);

It definitely should be the latter.

CCing Christoph so he can fix this up.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
