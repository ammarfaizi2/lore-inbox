Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTI0XuW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTI0XuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:50:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54169 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262288AbTI0XuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:50:19 -0400
Date: Sat, 27 Sep 2003 16:36:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: davidm@napali.hpl.hp.com, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030927163635.65a0088a.davem@redhat.com>
In-Reply-To: <m33ceij1q7.fsf@averell.firstfloor.org>
References: <A4gy.8wi.13@gated-at.bofh.it>
	<A4gy.8wi.15@gated-at.bofh.it>
	<A4gy.8wi.17@gated-at.bofh.it>
	<A4gy.8wi.11@gated-at.bofh.it>
	<A4Tv.Ud.37@gated-at.bofh.it>
	<AepM.5Zb.41@gated-at.bofh.it>
	<m33ceij1q7.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003 06:26:40 +0200
Andi Kleen <ak@muc.de> wrote:

> You handle misalignment->misalignment copies with zero or small cost -
> when both source and destination have the same misalignment. I guess
> you do that by just aligning the pointer at the beginning of the 
> function. That works as long as both source and destination have
> the same misalignment.

Nope, different alignments are fully optimized as well.

Sparc64 VIS has special instructions so that you can handle
all of these different src/dst alignment cases and still use
the 64-byte-at-a-time cache bypassing loads and stores.
