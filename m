Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVLPSDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVLPSDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVLPSDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:03:25 -0500
Received: from science.horizon.com ([192.35.100.1]:52297 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751329AbVLPSDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:03:25 -0500
Date: 16 Dec 2005 13:03:23 -0500
Message-ID: <20051216180323.8637.qmail@science.horizon.com>
From: linux@horizon.com
To: dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <19559.1134746682@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which would be totally pointless.
> 
> If you have LL/SC, then the odds are you _don't_ have CMPXCHG, and that
> CMPXCHG is implemented using LL/SC, so what you end up with is:

Ah, you're not quite understanding what I wrote, but I see the confusion.

I took "turned into" to mean "ported to an architecture with the
other primitive", and intended it that when I said "turned back".
That's obviously pointless if you're emulating one with the other.

The point I was making is that, for any LL/SC sequence, there is an
exactly analagous LD/CMPXCHG version, so you never have to have more
CMPXCHGs than SCs.

This was an attempt to disprove your claim that LL/SC was better by more
than a very small factor.

It it possible to optimize for the contention-free case and do away
with the initial load, at the expense of an additional CMPXCHG in the
failure case.
