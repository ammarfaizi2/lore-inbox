Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTKRNoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTKRNm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:56 -0500
Received: from ns.suse.de ([195.135.220.2]:7890 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262765AbTKRNmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:22 -0500
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz,
       davem@redhat.com
Subject: Re: possible bug in tcp_input.c
References: <20031024162959.GB11154@louise.pinerecords.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Oct 2003 19:57:24 +0200
In-Reply-To: <20031024162959.GB11154@louise.pinerecords.com.suse.lists.linux.kernel>
Message-ID: <p73ptgma58b.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> writes:

> /* tcp_input.c, line 1138 */
> static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
> {
>   return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
> }

tp->packets_out > 0 implies that there is at least one packet in the write 
queue (it counts the number of unacked packets in flight, which are kept
in the write queue). When that's not the case something else is wrong.

-Andi

