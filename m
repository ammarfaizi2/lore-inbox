Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUGFUhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUGFUhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGFUh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:37:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55225 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264524AbUGFUgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:36:53 -0400
Date: Tue, 6 Jul 2004 13:33:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jbglaw@lug-owl.de, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706133343.111556a8.davem@redhat.com>
In-Reply-To: <20040706133146.7ed47c69@dell_ss3.pdx.osdl.net>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	<20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<20040706185856.GN18841@lug-owl.de>
	<20040706131731.540dd5fd.davem@redhat.com>
	<20040706133146.7ed47c69@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 13:31:46 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The default tcp_rmem[2] is 174760, so we only need a wscale of 2 to represent
> that. We were sending 7.

It's only going to paper over this problem, because a window scale
of 2 still gets edited by the firewalls yet doesn't cause the
kind of damage 7 does.

Also, using a value of 7 is very safe, because it handles even the
tinyest of MTU's in use today (512 byte SLIP connections, for example
can still advertise sub-MTU sized chunks in the window).  Since
a window scale of 7 allows a granularity of 128 octets.
