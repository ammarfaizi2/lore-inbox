Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUE2Sfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUE2Sfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUE2Sfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 14:35:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:36310 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264652AbUE2Sfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 14:35:37 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
References: <40B8D2F8.6090905@pobox.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Did I SELL OUT yet??
Date: Sat, 29 May 2004 20:31:17 +0200
In-Reply-To: <40B8D2F8.6090905@pobox.com> (Jeff Garzik's message of "Sat, 29
 May 2004 14:14:16 -0400")
Message-ID: <jeaczraxvu.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> @@ -3680,7 +3680,7 @@
>  	case SIOCETHTOOL:
>  		return bond_ethtool_ioctl(bond_dev, ifr);
>  	case SIOCGMIIPHY:
> -		mii = (struct mii_ioctl_data *)&ifr->ifr_data;
> +		mii = if_mii(&ifr);
>  		if (!mii) {
>  			return -EINVAL;
>  		}
> @@ -3691,7 +3691,7 @@
>  		 * We do this again just in case we were called by SIOCGMIIREG
>  		 * instead of SIOCGMIIPHY.
>  		 */
> -		mii = (struct mii_ioctl_data *)&ifr->ifr_data;
> +		mii = if_mii(&ifr);

These two look wrong, too many &.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
