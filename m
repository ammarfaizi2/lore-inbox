Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWDGKbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWDGKbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDGKbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:31:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:17845 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751263AbWDGKbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:31:38 -0400
Date: Fri, 7 Apr 2006 14:26:03 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
Message-ID: <20060407102602.GA27764@2ka.mipt.ru>
References: <4433C456.7010708@gmail.com> <20060407062428.GA31351@2ka.mipt.ru> <44361F39.4020501@gmail.com> <20060407094732.GA13235@2ka.mipt.ru> <443638D8.2010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <443638D8.2010800@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 07 Apr 2006 14:26:04 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 06:03:04PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
> >>Can you explain why there is such a big difference between 
> >>netlink_unicast and netlink_broadcast?
> >>    
> >
> >Netlink broadcast clones skbs, while unicasting requires the whole new
> >one.
> >  
> No, I also use clone to send skb, so they should have the same overhead.

I missed that.
After rereading fsevent_send_to_process() I do not see how original skb
is freed though.

> >>>Btw, you need some rebalancing of the per-cpu queues, probably in
> >>>keventd, since CPUs can go offline and your messages will stuck foreve
> >>>there.
> >>> 
> >>>      
> >>Does keventd not do it? if so, keventd should be modified.
> >>    
> >
> >How does keventd know about your own structures?
> >You have an per-cpu object, but your keventd function gets object 
> >from running cpu, not from any other cpus.

-- 
	Evgeniy Polyakov
