Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWAXIHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWAXIHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWAXIHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:07:44 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26285 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1030363AbWAXIHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:07:42 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: bcm43xx-dev@lists.berlios.de
Subject: Re: [Bcm43xx-dev] Re: [softmac-dev] [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx or ieee80211_rx_mgt
Date: Tue, 24 Jan 2006 10:06:10 +0200
User-Agent: KMail/1.8.2
Cc: Johannes Berg <johannes@sipsolutions.net>,
       "John W. Linville" <linville@tuxdriver.com>, jbenc@suse.cz,
       netdev@vger.kernel.org, softmac-dev@sipsolutions.net,
       linux-kernel@vger.kernel.org
References: <20060118200616.GC6583@tuxdriver.com> <200601221404.52757.vda@ilport.com.ua> <1138026752.3957.98.camel@localhost>
In-Reply-To: <1138026752.3957.98.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241006.10372.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 16:32, Johannes Berg wrote:
> On Sun, 2006-01-22 at 14:04 +0200, Denis Vlasenko wrote:
> > +       hdr = (struct ieee80211_hdr_4addr *)skb->data;: 
> > +       fc = le16_to_cpu(hdr->frame_ctl);: 
> > +: 
> > +       switch (fc & IEEE80211_FCTL_FTYPE) {: 
> > +       case IEEE80211_FTYPE_MGMT: 
> > +               ieee80211_rx_mgt(ieee, hdr, stats);: 
> > +               return 0;: 
> 
> Shouldn't you BSS-filter management packets too?
> 
> > +       is_packet_for_us = 0;: 
> > +       switch (ieee->iw_mode) {: 
> > +       case IW_MODE_ADHOC: 
> > +               /* promisc: get all */
> > +               if (ieee->dev->flags & IFF_PROMISC): 
> > +                       is_packet_for_us = 1;
> 
> And I still think BSS-filtering is correct even in the promisc case. Any
> other opinions why either way is right or not? [I think we should filter
> because upper layers won't know the packet wasn't for us if it was
> broadcast in another BSSID]

In wired networks promisc literally means "receive all packets", right?

But for wireless, maybe we should filter them out, or else running tcpdump
on the iface will force us to listen to ARP packets from unrelated networks.
That would be rather surprising and disrupting.
--
vda
