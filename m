Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUC3WX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUC3WX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:23:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25830 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261449AbUC3WXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:23:24 -0500
Date: Tue, 30 Mar 2004 14:22:10 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: kuznet@ms2.inr.ac.ru, dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert.Olsson@data.slu.se, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-Id: <20040330142210.080dbe38.davem@redhat.com>
In-Reply-To: <20040330213742.GL3808@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 23:37:42 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> that means nothing runs in ksoftirqd for Dipankar, so he cannot be using
> NAPI.
> 
> Either that or I'm misreading his numbers, or his stats results are wrong.

If these numbers are with your "if (ksoftirqd_pending()) return;" thing
at the top of do_softirq() then I must agree with you.

Otherwise, keep in mind what I said, and also as Robert mentioned every
single local_bh_enable() is going to call do_softirq() if the count falls
to zero.
