Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUC3Vay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUC3Vay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:30:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26051 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261262AbUC3Vav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:30:51 -0500
Date: Tue, 30 Mar 2004 13:30:00 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: kuznet@ms2.inr.ac.ru, dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert.Olsson@data.slu.se, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-Id: <20040330133000.098761e2.davem@redhat.com>
In-Reply-To: <20040330211450.GI3808@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 23:14:50 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> > There are no hardirqs in the case under investigation, remember?
> 
> no hardirqs? there must be tons of hardirqs if ksoftirqd never runs.

NAPI should be kicking in for this workload, and I know for a fact it is
for Robert's case.  There should only be a few thousand hard irqs per
second.

Until the RX ring is depleted the device's hardirqs will not be re-
enabled.
