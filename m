Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275094AbRJNLuK>; Sun, 14 Oct 2001 07:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275096AbRJNLtu>; Sun, 14 Oct 2001 07:49:50 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:6528 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S275094AbRJNLtj>; Sun, 14 Oct 2001 07:49:39 -0400
Message-ID: <3BC97BC5.9F341ACE@welho.com>
Date: Sun, 14 Oct 2001 14:49:25 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com> <20011014133004.34133@colin.muc.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The only special case for PSH in RX left I can is in rcv_mss estimation,
> where is assumes that a packet with PSH set is not full sized.

A packet without PSH should be full size. Assuming the sender implemets
SWS avoidance correctly, this should be a safe enough assumption.

> On further
> look the 2.4 tcp_measure_rcv_mss will never update rcv_mss for packets
> which do have PSH set and in this case cause random ack behaviour depending
> on the initial rcv_mss guess.
> Not very nice; definitely violates the "be conservative what you accept"
> rule. I'm not sure how to fix it, adding a fallback to every-two-packet-add
> would pollute the fast path a bit.

You're right. As far as I can see, it's not necessary to set the
TCP_ACK_PUSHED flag at all (except maybe for SYN-ACK). I'm just writing
a patch to clean this up.

> -Andi

Regards,

	MikaL
