Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVE1DPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVE1DPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVE1DPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:15:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25826 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261312AbVE1DPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:15:25 -0400
Message-ID: <4297E246.1070606@pobox.com>
Date: Fri, 27 May 2005 23:15:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Benc <jbenc@suse.cz>, "David S. Miller" <davem@davemloft.net>
CC: NetDev <netdev@oss.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       pavel@suse.cz
Subject: Re: [3/5] netdev: HH_DATA_OFF bugfix
References: <20050524150711.01632672@griffin.suse.cz> <20050524151204.554f73cb@griffin.suse.cz>
In-Reply-To: <20050524151204.554f73cb@griffin.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jiri Benc wrote: > When the hardware header size is a
	multiple of HH_DATA_MOD, HH_DATA_OFF() > incorrectly returns
	HH_DATA_MOD (instead of 0). > > Signed-off-by: Jiri Benc
	<jbenc@suse.cz> > > --- linux/include/linux/netdevice.h > +++
	work/include/linux/netdevice.h > @@ -204,7 +209,7 @@ > /* cached
	hardware header; allow for machine alignment needs. */ > #define
	HH_DATA_MOD 16 > #define HH_DATA_OFF(__len) \ > - (HH_DATA_MOD -
	((__len) & (HH_DATA_MOD - 1))) > + (HH_DATA_MOD - (((__len - 1) &
	(HH_DATA_MOD - 1)) + 1)) > #define HH_DATA_ALIGN(__len) \ >
	(((__len)+(HH_DATA_MOD-1))&~(HH_DATA_MOD - 1)) > unsigned long
	hh_data[HH_DATA_ALIGN(LL_MAX_HEADER) / sizeof(long)]; [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Benc wrote:
> When the hardware header size is a multiple of HH_DATA_MOD, HH_DATA_OFF()
> incorrectly returns HH_DATA_MOD (instead of 0).
> 
> Signed-off-by: Jiri Benc <jbenc@suse.cz>
> 
> --- linux/include/linux/netdevice.h
> +++ work/include/linux/netdevice.h
> @@ -204,7 +209,7 @@
>  	/* cached hardware header; allow for machine alignment needs.        */
>  #define HH_DATA_MOD	16
>  #define HH_DATA_OFF(__len) \
> -	(HH_DATA_MOD - ((__len) & (HH_DATA_MOD - 1)))
> +	(HH_DATA_MOD - (((__len - 1) & (HH_DATA_MOD - 1)) + 1))
>  #define HH_DATA_ALIGN(__len) \
>  	(((__len)+(HH_DATA_MOD-1))&~(HH_DATA_MOD - 1))
>  	unsigned long	hh_data[HH_DATA_ALIGN(LL_MAX_HEADER) / sizeof(long)];


You'll want to run this one by DaveM.  He would be the appropriate one 
to merge this, since it affects all ethernet devices (net/ethernet/eth.c 
uses HH_DATA_OFF macro).

I'm going over the rest of the ieee80211/ipw patches...

	Jeff


