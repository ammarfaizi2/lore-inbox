Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUCWC3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUCWC3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:29:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262125AbUCWC3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:29:09 -0500
Date: Mon, 22 Mar 2004 18:28:58 -0800
From: "David S. Miller" <davem@redhat.com>
To: "m k" <mk_26@hotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux TCP implementation
Message-Id: <20040322182858.50e49a9e.davem@redhat.com>
In-Reply-To: <BAY15-F28psNhnM7kl300089ffe@hotmail.com>
References: <BAY15-F28psNhnM7kl300089ffe@hotmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Post stuff like this to netdev@oss.sgi.com or linux-net@vger.kernel.org,
  most net developers do not read linux-kernel, thanks. ]

On Mon, 22 Mar 2004 20:58:46 +0000
"m k" <mk_26@hotmail.com> wrote:

> 	Also, if the snd_cwnd is maintained in terms of packets and snd_ssthresh 
> and
> snd_cwnd_clamp is maintained in terms of bytes, how come the comparison 
> between them.

All of the congestion variables are maintained in terms of packets.

The function you quote, tcp_cong_avoid(), determines if we increase
the congestion window exponentially (when snd_cwnd is less than or
equal to snd_ssthresh) or linearlly (when snd_cwnd is more than
snd_ssthresh).

This is bog-standard Van Jacobson congestion avoidance, nothing fancy.
