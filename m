Return-Path: <linux-kernel-owner+w=401wt.eu-S932949AbWLTFQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbWLTFQV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932960AbWLTFQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:16:20 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41114
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932949AbWLTFQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:16:20 -0500
Date: Tue, 19 Dec 2006 21:15:51 -0800 (PST)
Message-Id: <20061219.211551.112620476.davem@davemloft.net>
To: shemminger@osdl.org
Cc: herbert@gondor.apana.org.au, mingo@elte.hu, akpm@osdl.org, wenji@fnal.gov,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug 7596 - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061219211124.061b5c2d@localhost.localdomain>
References: <E1Gwokt-00050T-00@gondolin.me.apana.org.au>
	<20061219.185525.41636407.davem@davemloft.net>
	<20061219211124.061b5c2d@localhost.localdomain>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Tue, 19 Dec 2006 21:11:24 -0800

> It was the realtime/normal comments that piqued my interest.
> Perhaps we should either tweak process priority or remove
> the comments.

I mentioned that to Linus once and he said the entire
idea was bogus.

With the recent tcp_recvmsg() preemption issue thread,
I agree with his sentiments even more than I did previously.

What needs to happen is to liberate the locking so that
input packet processing can occur in parallel with
tcp_recvmsg(), instead of doing this bogus backlog thing
which can wedge TCP ACK processing for an entire quantum
if we take a kernel preemption while the process has the
socket lock held.
