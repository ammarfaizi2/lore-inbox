Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUIQL7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUIQL7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268710AbUIQL7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:59:40 -0400
Received: from ozlabs.org ([203.10.76.45]:36518 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268709AbUIQL7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:59:38 -0400
Date: Fri, 17 Sep 2004 21:58:42 +1000
From: Anton Blanchard <anton@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917115842.GJ2825@krispykreme>
References: <16714.14118.212946.499226@wombat.chubb.wattle.id.au> <414A7A01.9080708@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414A7A01.9080708@nortelnetworks.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I did a similar test once for ppc that found that an increment followed by 
> a test (marked unlikely) was actually quicker in practice than modulo 
> arithmetic. The branch predictor got it right most of the time, so the 
>  test was almost free.

Yep x % y where y isnt constant could result in a divide which will blow
away 60+ cycles on some ppc machines. You can do a whole lot in those 60
cycles. Many memcpys for example :)

We removed all modulo arithmetic in the e1000 driver (replaced it with
if (x > y) x = 0) and managed to measure an improvement. 

Anton
