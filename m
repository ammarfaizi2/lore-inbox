Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWAZK2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWAZK2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWAZK2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:28:51 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:65477 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932281AbWAZK2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:28:50 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [softmac-dev] [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt
Date: Thu, 26 Jan 2006 12:25:10 +0200
User-Agent: KMail/1.8.2
Cc: Johannes Berg <johannes@sipsolutions.net>,
       "John W. Linville" <linville@tuxdriver.com>, jbenc@suse.cz,
       netdev@vger.kernel.org, softmac-dev@sipsolutions.net,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com> <1138026752.3957.98.camel@localhost> <20060125154402.GB9224@shaftnet.org>
In-Reply-To: <20060125154402.GB9224@shaftnet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601261225.10506.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 January 2006 17:44, Stuffed Crust wrote:
> On Mon, Jan 23, 2006 at 03:32:32PM +0100, Johannes Berg wrote:
> > Shouldn't you BSS-filter management packets too?
> 
> Filtering on BSSID is necessary for management frames, especially when 
> multicast management frames are thrown into the mix.  

ieee80211_rx_mgt can do any filtering necessary.

Foreign mgmt packets, if properly used, can provide us with constantly
updated info about local wireless neighborhood: available Ad-hoc
networks and BSSes, signal quality of APs etc. Something resembling
constantly running scan. For example, acx driver does exactly this.

Note that typically mgmt traffic is rather low and processing it
(instead of dropping) won't add much overhead.
 
> For example, STAs are supposed to respect broadcast disassoc/deauth
> messages, but of course should ignore them if they're not destined for
> the local BSSID. 

This filtering can (should) be done in ieee80211_rx_mgt.

> The only extra-BSS management frames that should not be dropped are are
> beacons and probe responses.  That said, probe responses are directed so
> our A1 (RA) filter will probably drop the frame if it is not destined
> for us.
--
vda
