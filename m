Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSHMQfc>; Tue, 13 Aug 2002 12:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHMQfc>; Tue, 13 Aug 2002 12:35:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33287 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318224AbSHMQfa>; Tue, 13 Aug 2002 12:35:30 -0400
Date: Tue, 13 Aug 2002 09:41:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <1993130000.1029255222@flay>
Message-ID: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Martin J. Bligh wrote:
:
> This patch is from Matt Dobson. It disables irq_balance for the NUMA-Q
> and makes it a config option for everyone else.

Please don't use negative config options.

I'd much rather have

	bool 'IRQ balancing support' CONFIG_IRQ_BALANCE

than some "Disable IRQ balancing?" question.

Also, the explanation should probably explain that a P4 needs manual IRQ 
balancing since the P4 broke the Intel-documented round-robin behaviour.

Finally, exactly since IRQ balancing is practically required on P4-SMP, I
really don't think a CONFIG option works. It needs to be configured in on
any kernel that expects to use P4's in an SMP configuration.

In other words, I think this needs to do a dynamic disable (with the 
possible exception of a NUMA-Q machine, since that one is already a static 
config option and won't have P4's in it).

		Linus

