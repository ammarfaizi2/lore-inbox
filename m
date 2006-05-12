Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWELRky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWELRky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWELRky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:40:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29064
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932168AbWELRkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:40:53 -0400
Date: Fri, 12 May 2006 10:40:47 -0700 (PDT)
Message-Id: <20060512.104047.37111282.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: brice@myri.com, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, gallatin@myri.com
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060512064710.GA27065@2ka.mipt.ru>
References: <20060510231347.GC25334@electric-eye.fr.zoreil.com>
	<4463CE88.20301@myri.com>
	<20060512064710.GA27065@2ka.mipt.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Fri, 12 May 2006 10:47:11 +0400

> On Fri, May 12, 2006 at 01:53:44AM +0200, Brice Goglin (brice@myri.com) wrote:
> > > Imho you will want to work directly with pages shortly.
> > >   
> > 
> > We had thought about doing this, but were a little nervous since we did
> > not know of any other drivers that worked directly with pages.  If this
> > is an official direction to work directly with pages, we will. 
> 
> s2io does. e1000 does it with skb frags.
> If your hardware allows header split and driver can put headers into
> skb->data and real data into frag_list, that allows to create various
> interesting things like receiving zero-copy support and netchannels
> support. It is work in progress, not official direction currently,
> but this definitely will help your driver to support future high 
> performance extensions.

The most important impact is not having to use order 1 pages
for jumbo MTU frames, which are more likely to fail allocations
thant order 0 pages under heavy load.
