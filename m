Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUIJU4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUIJU4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIJU4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:56:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267810AbUIJUyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:54:38 -0400
Date: Fri, 10 Sep 2004 13:53:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: Brian Somers <brian.somers@sun.com>
Cc: Michael.Waychison@sun.com, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040910135357.393f7737.davem@redhat.com>
In-Reply-To: <41419F82.10109@sun.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
	<20040826123730.375ce5d2.davem@redhat.com>
	<41419F82.10109@sun.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 13:35:14 +0100
Brian Somers <brian.somers@sun.com> wrote:

> The problem seems to be that autoneg is disabled on the IBM switches.
> After disabling autoneg on the Sun shelf switches, I see the problem.
> This patch fixes things by reverting to sw autoneg which defaults to
> a 1000Mbps/full-duplex link but with no flow control when it fails
> (IBM should really have autoneg enabled!) - I'd appreciate it if
> someone could test this against an IBM blade.

Did you see the fix I posted the other day and have
already merged upstream?

The real problem was the MAC_STATUS register checking in
tg3_timer() that we use to determine if we should call
the PHY code.  Specifically, we were failing to test
MAC_STATUS_SIGNAL_DET being set, which when trying to
bring the link up means we should call tg3_setup_phy().

There are still some nagging problems with certain blades even
with my current code.  Brian, if you want to help I'd really
appreciate it if you worked with current tg3 sources as I rewrote
the 5704 hw autoneg support from scratch since it was missing
a hw bug workaround and had other issues as well.

Thanks.
