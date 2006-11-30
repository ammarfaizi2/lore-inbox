Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031490AbWK3UzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031490AbWK3UzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031487AbWK3UzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:55:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9413 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031458AbWK3UzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:55:07 -0500
Date: Thu, 30 Nov 2006 21:54:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, nickpiggin@yahoo.com.au, wenji@fnal.gov,
       akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130205428.GA21140@elte.hu>
References: <20061130103240.GA25733@elte.hu> <20061130.122258.68041055.davem@davemloft.net> <20061130203026.GD14696@elte.hu> <20061130.123853.10298783.davem@davemloft.net> <20061130204908.GA19393@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130204908.GA19393@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] Instead what i'd like to see is more TCP performance (and a 
> nicer over-the-wire behavior - no retransmits for example) /with the 
> same 10% CPU time used/. Are we in rough agreement?

put in another way: i'd like to see the "TCP bytes transferred per CPU 
time spent by the TCP stack" ratio to be maximized in a load-independent 
way (part of which is the sender host too: to not cause unnecessary 
retransmits is important as well). In a high-load scenario this means 
that any measure that purely improves TCP throughput by giving it more 
cycles is not a real improvement. So the focus should be on throttling 
intelligently and without causing extra work on the sender side either - 
not on trying to circumvent throttling measures.

	Ingo
