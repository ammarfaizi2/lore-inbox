Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUGFWwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUGFWwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUGFWwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:52:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264650AbUGFWv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:51:59 -0400
Date: Tue, 6 Jul 2004 15:49:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: bert hubert <ahu@ds9a.nl>
Cc: jamie@shareable.org, shemminger@osdl.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706154907.422a6b73.davem@redhat.com>
In-Reply-To: <20040706224453.GA6694@outpost.ds9a.nl>
References: <20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<20040706194034.GA11021@mail.shareable.org>
	<20040706131235.10b5afa8.davem@redhat.com>
	<20040706224453.GA6694@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004 00:44:53 +0200
bert hubert <ahu@ds9a.nl> wrote:

> Not true - the outgoing SYN packet had window scale 7, when it was sent. The
> SYN|ACK had window scale 0, when received by the initiating system.
> 
> Also - even if the remote were to assume a 47 byte window size, would it not
> be able to send small packets? Or does the window size also include
> packet haders?

SWS avoidance makes us not send packets.  See this quote in an email
from John Heffner the other week:

================================
To elaborate on my earlier mail. my hypothesis is that somehow the web
server beleives that we sent a winscale of 0.  In such a case, when we try
to advertise our initial 4*MSS (5840 bytes) of window, with a window scale
of 3 we use a value of 730 in the window field.  All sender SWS avoidance
(RFC1122) tests will fail, most notably 1 (because we already advertised
5840 bytes and 730 < 5840/2) and 3 (because 730 < 1460).  With a winscale
of 2, we will use a value of 1460 in the window field, so both tests will
succeed.
================================
