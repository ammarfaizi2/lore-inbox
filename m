Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266054AbUF2U7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUF2U7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUF2U7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:59:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29605 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266048AbUF2U7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:59:47 -0400
Date: Tue, 29 Jun 2004 13:59:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: debi.janos@freemail.hu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629135922.12384153.davem@redhat.com>
In-Reply-To: <20040629133501.3c2cd2a2@dell_ss3.pdx.osdl.net>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	<20040629112256.58828632@dell_ss3.pdx.osdl.net>
	<20040629124951.56de307d@dell_ss3.pdx.osdl.net>
	<20040629125401.4ca60aa7.davem@redhat.com>
	<20040629133501.3c2cd2a2@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 13:35:01 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> FYI - gentoo works for window scale 0..2 and appears to fail for >3.
> 
> Also, the socket ends up with:
> 
> State      Recv-Q Send-Q      Local Address:Port          Peer Address:Port
> ESTAB      0      0             172.20.1.73:34452       198.63.211.232:http
>          ts sack wscale:0,3 rto:332 rtt:66.375/50.5 cwnd:3

Yes, I've seen this declared in other reports too.

It probably means just that for window scales of 0..2 the misinterpretation
does not result in a too-small-to-send-data window.

But I'm still confused that the scaled window is being given to the
receiver, and this makes the connection freeze.  I wonder if there is
a queer box doing NAT or similar in front of the gentoo machine which
either:

1) Applies any window scaling to both directions
2) Applies window scaling to the wrong direction

and uses this to "help" with dropping of out-of-window TCP segments.
