Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSGJI0g>; Wed, 10 Jul 2002 04:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSGJI0g>; Wed, 10 Jul 2002 04:26:36 -0400
Received: from mail.zmailer.org ([62.240.94.4]:21977 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317498AbSGJI0f>;
	Wed, 10 Jul 2002 04:26:35 -0400
Date: Wed, 10 Jul 2002 11:29:16 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Hurwitz Justin W." <hurwitz@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How many copies to get from NIC RX to user read()?
Message-ID: <20020710112916.R28720@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0207091625460.2905-100000@alvie-mail.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207091625460.2905-100000@alvie-mail.lanl.gov>; from hurwitz@lanl.gov on Tue, Jul 09, 2002 at 04:29:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 04:29:35PM -0600, Hurwitz Justin W. wrote:
> Please Cc: me in your responses.
> 
> The story so far: 
> 
> I've been continuing to muck around with the stack, trying both to improve
> overall performance, and specifically to improve rx relative to tx
> performance, primarily in gig-and-beyond (e.g., Quadrics)  environments.
...
> The direct question:
> 
> How many times is data copied between the time that it is received at the
> NIC and when the user's call to read() returns the data?
 
> The reason for the question:
> 
> I could've sworn I heard the stack was single-copy on both the TX and RX
> sides. But, it doesn't look to me like it is. Rather, it looks like there
> is one copy in tcp_rcv_estabilshed() (via tcp_copy_to_iovec()), and a
> second copy in tcp_recvmsg() (which is called when the user calls read()).
> Both of these copies are, I believe, done by skb_copy_datagram_iovec().

  I suspect that in many cases there is third copy right in the network
  card driver to realign data so that TCP frame begins at a 32-bit boundary.
  Perhaps that is only for RISC CPU systems (e.g. Alpha, primarily.)

  Can the GigE cards do ethernet-frame reception pre-alignment so that
  after the 14 byte ethernet header, the TCP frame begins at 32-bit 
  boundary ?

...
> Cheers,
> --Gus

/Matti Aarnio
