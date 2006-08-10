Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWHJGaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWHJGaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWHJGaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:30:39 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:12142 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161060AbWHJGai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:30:38 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: David Miller <davem@davemloft.net>
Cc: tgraf@suug.ch, phillips@google.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060809.165846.107940575.davem@davemloft.net>
References: <44D976E6.5010106@google.com>
	 <20060809131942.GY14627@postel.suug.ch> <1155132440.12225.70.camel@twins>
	 <20060809.165846.107940575.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 08:25:59 +0200
Message-Id: <1155191159.12225.108.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 16:58 -0700, David Miller wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Wed, 09 Aug 2006 16:07:20 +0200
> 
> > Hmm, what does sk_buff::input_dev do? That seems to store the initial
> > device?
> 
> You can run grep on the tree just as easily as I can which is what I
> did to answer this question.  It only takes a few seconds of your
> time to grep the source tree for things like "skb->input_dev", so
> would you please do that before asking more questions like this?

That is exactly what I did, but I wanted a bit of confirmation. Sorry if
it 
offends you, but I'm a bit new to this network thing.

> It does store the initial device, but as Thomas tried so hard to
> explain to you guys these device pointers in the skb are transient and
> you cannot refer to them outside of packet receive processing.

Yes, I understood that after Thomas' last mail.

> The reason is that there is no refcounting performed on these devices
> when they are attached to the skb, for performance reasons, and thus
> the device can be downed, the module for it removed, etc. long before
> the skb is freed up.

I understood that, thanks.

