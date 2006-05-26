Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWEZAK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWEZAK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWEZAK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:10:26 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:41919 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030205AbWEZAKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:10:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LIjxNofBmo/viPZzVHhMRGzI92KNEHFuyeZHt/3bmYS03e/YhsWzr/OrCaYncMkIKHjsh4adtL4mUMACgLZJr4X+h9emtxsD7m95ztmd8K3vQtpV3LBClV4ybTO43Acp9+8DPeYy4+bIH15lLSb5AFVdNukFZAqRCZLmVpTPyX4=
Message-ID: <4476489C.3030808@gmail.com>
Date: Thu, 25 May 2006 20:15:24 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irda: missing allocation result check in irlap_change_speed()
References: <4474F6A6.1000006@gmail.com> <20060525.162222.107938414.davem@davemloft.net>
In-Reply-To: <20060525.162222.107938414.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> If the allocation fails we should probably do something
> more interesting here, such as schedule a timer to try
> again later.  Otherwise the speed change will silently
> never occur.
>   
I thought the speed change would be piggybacked on the next frame, same
as when 'now' == 0. Is that not the case?

	self->speed = speed;

	/* Change speed now, or just piggyback speed on frames */
	if (now) {
		/* Send down empty frame to trigger speed change */
		skb = dev_alloc_skb(0);
		if (skb)
			irlap_queue_xmit(self, skb);
	}


