Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUJGOwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUJGOwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUJGOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:52:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266648AbUJGOvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:51:40 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: Paul Jakma <paul@clubi.ie>, Chris Friesen <cfriesen@nortelnetworks.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001c01c4ac76$fb9fd190$161b14ac@boromir>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	 <20041006080104.76f862e6.davem@davemloft.net>
	 <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
	 <20041006082145.7b765385.davem@davemloft.net>
	 <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>
	 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>
	 <4164EBF1.3000802@nortelnetworks.com>
	 <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org>
	 <001601c4ac72$19932760$161b14ac@boromir>
	 <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
	 <001c01c4ac76$fb9fd190$161b14ac@boromir>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097156929.31753.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 14:48:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 15:07, Martijn Sipkema wrote:
> > Much can change between the select() and recvmsg - things outside of 
> > kernel control too, and it's long been known.
> 
> There is no change; the current implementation just checks the validity of
> the data in the recvmsg() call and not during select().

The accept one is documented by Stevens and well known. In the UDP case
currently we could get precise behaviour - by halving performance of UDP
applications like video streaming. We probably don't want to  because we
can respond intelligently to OOM situations by freeing the queue if we
don't enforce such a silly rule.

