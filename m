Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262135AbRENNIM>; Mon, 14 May 2001 09:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbRENNID>; Mon, 14 May 2001 09:08:03 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:63436 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262108AbRENNHs>; Mon, 14 May 2001 09:07:48 -0400
Message-ID: <3AFFD7D9.67D6622A@uow.edu.au>
Date: Mon, 14 May 2001 23:04:25 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcell GAL <cell@sch.bme.hu>
CC: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michal Ostrowski <mostrows@styx.uwaterloo.ca>
Subject: Re: Scheduling in interrupt BUG.
In-Reply-To: <3AFFBF14.7D7BAB01@sch.bme.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcell GAL wrote:
> 
> int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> {
>         lock_sock(sk);
>         pppoe_rcv_core(sk, skb);
>         release_sock(sk);
>         return 0;
> }
> 

The backlog_rcv() method is called inside local_bh_disable()
and so cannot call lock_sock().   Definitely a bug in pppoe.

It looks like pppoe_backlog_rcv() should be using bh_lock_sock().
