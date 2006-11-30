Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031446AbWK3UzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031446AbWK3UzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031487AbWK3UzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:55:08 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38634
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031446AbWK3UzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:55:05 -0500
Date: Thu, 30 Nov 2006 12:55:06 -0800 (PST)
Message-Id: <20061130.125506.99459321.davem@davemloft.net>
To: mingo@elte.hu
Cc: johnpol@2ka.mipt.ru, nickpiggin@yahoo.com.au, wenji@fnal.gov,
       akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130204908.GA19393@elte.hu>
References: <20061130203026.GD14696@elte.hu>
	<20061130.123853.10298783.davem@davemloft.net>
	<20061130204908.GA19393@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 30 Nov 2006 21:49:08 +0100

> So i dont support the scheme proposed here, the blatant bending of the 
> priority scale towards the TCP workload.

I don't support this scheme either ;-)

That's why my proposal is to find a way to allow input packet
processing even during tcp_recvmsg() work.  It is a solution that
would give the TCP task exactly it's time slice, no more, no less,
without the erroneous behavior of sleeping with packets held in the
socket backlog.
