Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWIHM7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWIHM7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWIHM7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:59:01 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:47771 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751033AbWIHM7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:59:00 -0400
Message-ID: <45016909.4080908@linuxtv.org>
Date: Fri, 08 Sep 2006 08:58:49 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
References: <20060906224631.999046890@quad.kroah.org> <20060906225740.GD15922@kroah.com>
In-Reply-To: <20060906225740.GD15922@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

Greg,

Can we hold off on this until the 2.6.17.13 review cycle?  This patch
has not been sent to the linux-dvb mailing list, it has not been
reviewed or tested except for the Author and Marcel.

Please also add me to the cc list for the stable patches review.

DVB maintainers,

Marcel expressed some concerns about this patch on LKML, see thread:

http://lkml.org/lkml/2006/9/6/314

He says that the code in our mercurial tree, and in 2.6.18-rcX does this
in a much nicer way, but that it involves some major changes.  If this
patch seems acceptable, then we can apply it for 2.6.17.y, and the
larger, more appropriate change will be seen when 2.6.18 gets released.

I, myself, do not know enough about the internals of dvb_net ... but I
think that we should agree to this patch before it gets applied to -stable

Regards,

Mike Krufky


> 
> ------------------
> From: Ang Way Chuang <wcang@nrg.cs.usm.my>
> 
> ULE (Unidirectional Lightweight Encapsulation RFC 4326) decapsulation
> code has a bug that allows an attacker to send a malformed ULE packet
> with SNDU length of 0 and bring down the receiving machine. This patch
> fix the bug and has been tested on version 2.6.17.11. This bug is 100%
> reproducible and the modified source code (GPL) used to produce this bug
> will be posted on http://nrg.cs.usm.my/downloads.htm shortly.  The
> kernel will produce a dump during CRC32 checking on faulty ULE packet.
> 
> 
> Signed-off-by: Ang Way Chuang <wcang@nrg.cs.usm.my>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/media/dvb/dvb-core/dvb_net.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.17.11.orig/drivers/media/dvb/dvb-core/dvb_net.c
> +++ linux-2.6.17.11/drivers/media/dvb/dvb-core/dvb_net.c
> @@ -492,7 +492,8 @@ static void dvb_net_ule( struct net_devi
>  				} else
>  					priv->ule_dbit = 0;
>  
> -				if (priv->ule_sndu_len > 32763) {
> +				if (priv->ule_sndu_len > 32763 ||
> +				    priv->ule_sndu_len < ((priv->ule_dbit) ? 4 : 4 + ETH_ALEN)) {
>  					printk(KERN_WARNING "%lu: Invalid ULE SNDU length %u. "
>  					       "Resyncing.\n", priv->ts_count, priv->ule_sndu_len);
>  					priv->ule_sndu_len = 0;
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

