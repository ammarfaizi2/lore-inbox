Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVKPMam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVKPMam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVKPMam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:30:42 -0500
Received: from barclay.balt.net ([195.14.162.78]:8799 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S1030296AbVKPMam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:30:42 -0500
Date: Wed, 16 Nov 2005 14:29:18 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Zhu Yi <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051116122918.GC31362@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com> <20051115140023.GB9910@gemtek.lt> <1132120145.18679.12.camel@debian.sh.intel.com> <20051116094551.GA23140@gemtek.lt> <20051116114052.GA14042@gemtek.lt> <Pine.LNX.4.58.0511161415010.4402@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511161415010.4402@sbz-30.cs.Helsinki.FI>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka, 

Ok , I will revert previous fix and apply the new patch you had sent.
Also I can confirm that previous patch indeed doesn't fix the problem.
Anyway please look through trace.3 perhaps you will find anything
useful ;)

Any bits to turn on for debugging when loading module (I have now 
debug=0x10000, to see f/w loading/restart problems ...).

I am off to compile new kernel ...

Z.


On Wed, Nov 16, 2005 at 02:18:48PM +0200, Pekka J Enberg wrote:
> Hi Zilvinas,
> 
> On Wed, 16 Nov 2005, Zilvinas Valinskas wrote:
> > I just have noticed there are messages logged on Nov 3rd ... Doh! Please
> > see the latest logged message :
> > 
> > http://www.gemtek.lt/~zilvinas/dumps/trace.2 
> 
> The patch I sent to you won't fix the above error. Please try this patch 
> instead. I think the driver is in a middle of a reset when 
> wpa_supplicant() causes ipw_request_direct_scan() to trigger.
> 
> 			Pekka
> 
> Index: 2.6/drivers/net/wireless/ipw2200.c
> ===================================================================
> --- 2.6.orig/drivers/net/wireless/ipw2200.c
> +++ 2.6/drivers/net/wireless/ipw2200.c
> @@ -8926,6 +8926,10 @@ static int ipw_request_direct_scan(struc
>  	struct ipw_scan_request_ext scan;
>  	int err = 0, scan_type;
>  
> +	if (!(priv->status & STATUS_INIT) ||
> +	    (priv->status & STATUS_EXIT_PENDING))
> +		return 0;
> +
>  	down(&priv->sem);
>  
>  	if (priv->status & STATUS_RF_KILL_MASK) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
