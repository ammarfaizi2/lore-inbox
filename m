Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280619AbRKNO3G>; Wed, 14 Nov 2001 09:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280615AbRKNO25>; Wed, 14 Nov 2001 09:28:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48004 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280609AbRKNO2j>;
	Wed, 14 Nov 2001 09:28:39 -0500
Date: Wed, 14 Nov 2001 06:28:34 -0800 (PST)
Message-Id: <20011114.062834.68910928.davem@redhat.com>
To: mostrows@speakeasy.net
Cc: tip@internetwork-ag.de, linux-kernel@vger.kernel.org, paulus@samba.org,
        linux-ppp@vger.kernel.org
Subject: Re: [PATCH] ppp_generic causes skput:under: w/ pppoatm and
 vc-encaps
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1005747834.8776.5.camel@brick.watson.ibm.com>
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de>
	<20011113.210221.55509229.davem@redhat.com>
	<1005747834.8776.5.camel@brick.watson.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Michal Ostrowski <mostrows@speakeasy.net>
   Date: 14 Nov 2001 09:23:53 -0500
   
   If you look at pppoatm_send(),  you'll see that you do an
   skb_realloc_headroom if there's no space for the headers.   If
   pvcc->chan.hdrlen is set properly then this will be the exceptional,
   rather than the common case.

Their problem is on receive, not send.  That's problematic because in
that case the ATM drivers allocate and size the SKBs.
