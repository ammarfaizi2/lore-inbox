Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275092AbRJNL3f>; Sun, 14 Oct 2001 07:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275087AbRJNL3Z>; Sun, 14 Oct 2001 07:29:25 -0400
Received: from colin.muc.de ([193.149.48.1]:38663 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S275082AbRJNL3M>;
	Sun, 14 Oct 2001 07:29:12 -0400
Message-ID: <20011014133004.34133@colin.muc.de>
Date: Sun, 14 Oct 2001 13:30:04 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20011014.023948.95894368.davem@redhat.com>; from David S. Miller on Sun, Oct 14, 2001 at 11:39:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 11:39:48AM +0200, David S. Miller wrote:
>    From: Andi Kleen <ak@muc.de>
>    Date: 14 Oct 2001 11:25:09 +0200
>    
>    but at least here is an counter example
>    now that may be a good case for a reconsider.
> 
> A buggy 2.2.x kernel is not a good case counter example.

I just checked and the 2.4 kernel doesn't have the PSH quickack check
anymore, so it cannot be the cause. The original poster didn't which 
kernel version he used, but he said "recent"; so I'll assume 2.4
The only special case for PSH in RX left I can is in rcv_mss estimation,
where is assumes that a packet with PSH set is not full sized.  On further
look the 2.4 tcp_measure_rcv_mss will never update rcv_mss for packets
which do have PSH set and in this case cause random ack behaviour depending
on the initial rcv_mss guess.
Not very nice; definitely violates the "be conservative what you accept"
rule. I'm not sure how to fix it, adding a fallback to every-two-packet-add
would pollute the fast path a bit.


-Andi

