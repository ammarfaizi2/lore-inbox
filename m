Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUINFHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUINFHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUINFHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:07:05 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:30634
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268947AbUINFHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:07:02 -0400
Date: Mon, 13 Sep 2004 22:05:07 -0700
From: "David S. Miller" <davem@davemloft.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-Id: <20040913220507.1a269816.davem@davemloft.net>
In-Reply-To: <20040914044748.GZ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<20040914044748.GZ9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


William, any reason not to fully per-cpu the profile buffer
and then only traverse the array when the user attempts to
capture the counters?

Then we can undo the atomics altogether, as well as the cacheline
traffic, for the extremely common case.

Are there space concerns?
