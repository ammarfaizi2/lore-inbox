Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbUKWFRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbUKWFRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKWFAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 00:00:54 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54458
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262212AbUKWE55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:57:57 -0500
Date: Mon, 22 Nov 2004 20:40:52 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Pradeep Anbumani <pradeepdreams@gmail.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ACK Flooding
Message-Id: <20041122204052.581ba69b.davem@davemloft.net>
In-Reply-To: <19f134cc04112220125461595d@mail.gmail.com>
References: <19f134cc04112220125461595d@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 09:42:18 +0530
Pradeep Anbumani <pradeepdreams@gmail.com> wrote:

> If anybody could tell me what changes had to be made to get the
> desired output..the desired output is TCP as per the conventional
> behaviour has to increase the transmission rate as it gets more
> duplicate acknowledgements....

If you send a 100 ACKs you won't get this behavior.
Once you give more ACKs than the other end has packets
to send (or more than the congestion window can fit)
the sender just waits for a timer based timeout before
it retransmits more data.

So what you code causes to happen is after the first data segment
is sent, you crazily spit out 100 ACKs, the send has a tiny
congestion window (now 2 segments) so at most it can send 2
packets back in response to all of those ACKs.
