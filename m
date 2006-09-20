Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWITJyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWITJyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 05:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWITJyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 05:54:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:56709 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750886AbWITJyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 05:54:51 -0400
To: "Stuart MacDonald" <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP stack behaviour question
References: <87wt802hd9.fsf@willow.rfc1149.net>
	<006301c6dbf4$035a71c0$294b82ce@stuartm>
From: Andi Kleen <ak@suse.de>
Date: 20 Sep 2006 11:54:44 +0200
In-Reply-To: <006301c6dbf4$035a71c0$294b82ce@stuartm>
Message-ID: <p73eju6kgm3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stuart MacDonald" <stuartm@connecttech.com> writes:
> 
> 
> *** I found arp(7) and read up on it while I was typing. And now I see
> something interesting in the tcpdump; my app is actually talking on
> two TCP connections at the same time. Both are in retransmit phase,
> and the first arp is 5 seconds (delay_first_probe_time) after an
> _aggregate total_ of 15 retransmits (being the two original unanswered
> packets and 7 and 6 retransmits of each).
> 
> My reading of tcp(7)'s documentation of tcp_retries2 is that
> tcp_retries2 is a per-TCP packet count. My tcpdump seems to show that
> it is in fact a global count. Which is correct?

The ARP layer keeps track of what neighbours are reachable and doesn't
transmit packets to unreachable ones before they answer unicast or 
broadcast ARP. This is a state machine borrowed from IPv6.

There is nothing global.

-Andi
