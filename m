Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280605AbRKNOYQ>; Wed, 14 Nov 2001 09:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280601AbRKNOYH>; Wed, 14 Nov 2001 09:24:07 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:40093 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280603AbRKNOX4>; Wed, 14 Nov 2001 09:23:56 -0500
Subject: Re: [PATCH] ppp_generic causes skput:under: w/ pppoatm and vc-encaps
From: Michal Ostrowski <mostrows@speakeasy.net>
To: tip@internetwork-ag.de
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        paulus@samba.org, linux-ppp@vger.kernel.org
In-Reply-To: <20011113.210221.55509229.davem@redhat.com>
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de> 
	<20011113.210221.55509229.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Nov 2001 09:23:53 -0500
Message-Id: <1005747834.8776.5.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you set the hdrlen field of the ppp_channel that pppoatm registers
(pvcc->chan.hdrlen, in pppoatm_assign_vcc()) then ppp_generic will
always over-allocate skb space to allow for extra headers to be pushed
in.  This mechanism was put is so that we wouldn't have to copy the
frame in order to slap on PPPoE headers onto it.  I think it's a good
idea to be doing this, especially if you're going to play with
hard_header_len.

If you look at pppoatm_send(),  you'll see that you do an
skb_realloc_headroom if there's no space for the headers.   If
pvcc->chan.hdrlen is set properly then this will be the exceptional,
rather than the common case.



> Here is my "better fix". In pppoatm, we should be increasing the
> device header length appropriately.  ie. dev->hard_header_len needs to
> be increased in the pppoatm driver when vc-encaps is used.
> 
> Franks a lot,
> David S. Miller
> davem@redhat.com


-- 
Michal Ostrowski
mostrows@speakeasy.net

