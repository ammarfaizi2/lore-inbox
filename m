Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967772AbWK3BFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967772AbWK3BFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967776AbWK3BFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:05:20 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:33031 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S967772AbWK3BFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:05:18 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Wed, 29 Nov 2006 17:04:28 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEGKAAAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20061128.200453.104036587.davem@davemloft.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 29 Nov 2006 18:07:39 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 29 Nov 2006 18:07:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ask yourself this question: Can an assignment to a non-volatile variable be
optimized out? Then ask yourself this question: Does casting away volatile
make it not volatile any more?

> The volatile'ness does not simply disappear the moment you
> assign the result to some local variable which is not volatile.

Yes, it does. That's what a cast does, it tells the compiler to, in all
respects, pretend that a variable is of a different type than it 'actually
is', such that it actually isn't anymore.

> Half of our drivers would break if this were true.

On the contrary, they'd break if it was true. If casting away volatile
didn't make it go away, then casting in volatile wouldn't have to make it
appear. A cast causes the compiler to act as if a variable really was the
type you cast it to. If you cast volatile away, that has the reverse of the
same affect casting to volatile has.

The 'readl' function should actually assign the value to a volatile
variable. Assignments to volatiles cannot be cast away, but casts can and
assignments to non-volatile variables can be optimized out.

DS


