Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031371AbWK3UOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031371AbWK3UOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031372AbWK3UOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:14:43 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41613
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031371AbWK3UOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:14:41 -0500
Date: Thu, 30 Nov 2006 12:14:43 -0800 (PST)
Message-Id: <20061130.121443.116355312.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, wenji@fnal.gov, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130102205.GA20654@2ka.mipt.ru>
References: <20061130095232.GA8990@2ka.mipt.ru>
	<456EAD6E.6040709@yahoo.com.au>
	<20061130102205.GA20654@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Thu, 30 Nov 2006 13:22:06 +0300

> It steals timeslices from other processes to complete tcp_recvmsg()
> task, and only when it does it for too long, it will be preempted.
> Processing backlog queue on behalf of need_resched() will break
> fairness too - processing itself can take a lot of time, so process
> can be scheduled away in that part too.

Yes, at this point I agree with this analysis.

Currently I am therefore advocating some way to allow
full input packet handling even amidst tcp_recvmsg()
processing.
