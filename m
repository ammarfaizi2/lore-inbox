Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVIBOsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVIBOsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVIBOsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:48:09 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:3551 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S1751224AbVIBOsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:48:08 -0400
In-Reply-To: <Pine.LNX.4.61.0509021022230.6083@guppy.limebrokerage.com>
References: <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com> <2d02c76a84655d212634a91002b3eccd@psc.edu> <20050901.232823.123760177.davem@davemloft.net> <Pine.LNX.4.61.0509020948350.6083@guppy.limebrokerage.com> <6064b8272aa4562242eb60eb75c7cdae@psc.edu> <Pine.LNX.4.61.0509021022230.6083@guppy.limebrokerage.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <002cb4586f9d008438e81da96e5cecd0@psc.edu>
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
From: John Heffner <jheffner@psc.edu>
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Date: Fri, 2 Sep 2005 10:48:01 -0400
To: lists@limebrokerage.com
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 10:33 AM, lists@limebrokerage.com wrote:

> On Fri, 2 Sep 2005, John Heffner wrote:
>
>> Have you tried increasing the size of the receive buffer yet?
>
> Actually, I just did. I changed rmem_max and rmem_default to 4MB and 
> tcp_rmem to "64k 4MB 4MB". It did seem to help, but I'm wondering if 
> that's simply because it has a _lot_ of memory now to leak before it 
> starts eating up into the window size.

If it is window clamping, then you should be asymptotically approaching 
a ratio between receive buffer and window that corresponds (with a 
fudge factor) to the ratio between TCP segment data size and allocated 
packet size.  If you make the receive buffer large enough, then the 
clamped window should still end up big enough.  Also, since you have 
"real time" data, a larger receive buffer should probably be adequate 
to eliminate this problem, since it only occurs when the receiving 
application falls behind for a while, and a bigger receive buffer 
allows it to fall behind more without triggering the window clamping.

   -John

