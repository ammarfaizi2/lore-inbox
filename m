Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbVIBORL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbVIBORL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbVIBORL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:17:11 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:14305 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S1161022AbVIBORI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:17:08 -0400
In-Reply-To: <20050902134807.GB12617@yakov.inr.ac.ru>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com> <2d02c76a84655d212634a91002b3eccd@psc.edu> <20050902134807.GB12617@yakov.inr.ac.ru>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4629cfbdf1af310d5c6cffd7178cff5b@psc.edu>
Content-Transfer-Encoding: 7bit
Cc: Ion Badulescu <lists@limebrokerage.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
From: John Heffner <jheffner@psc.edu>
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Date: Fri, 2 Sep 2005 10:16:57 -0400
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 9:48 AM, Alexey Kuznetsov wrote:

> Hello!
>
>> If you overflow the socket's memory bound, it ends up calling
>> tcp_clamp_window().  (I'm not sure this is really the right thing to 
>> do
>> here before trying to collapse the queue.)
>
> Collapsing is too expensive procedure, it is rather an emergency 
> measure.
> So, tcp collapses queue, when it is necessary, but it must reduce 
> window
> as well.

Right.

I wonder if clamping the window though is too harsh.  Maybe just 
setting the rcv_ssthresh down is better?  Why the distinction between 
in-order and out-of-order data?  Because you expect in-order data to be 
a persistent case?

   -John

