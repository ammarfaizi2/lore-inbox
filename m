Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265220AbRFUUyc>; Thu, 21 Jun 2001 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265219AbRFUUyW>; Thu, 21 Jun 2001 16:54:22 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:52235 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265218AbRFUUyO>;
	Thu, 21 Jun 2001 16:54:14 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106212053.f5LKrv6469312@saturn.cs.uml.edu>
Subject: Re: [RFC][PATCH] cutting up struct kernel_stat into cpu_stat
To: zab@osdlab.org (Zach Brown)
Date: Thu, 21 Jun 2001 16:53:57 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010621113107.A16934@osdlab.org> from "Zach Brown" at Jun 21, 2001 11:31:07 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown writes:

> The attached patch-in-progress removes the per-cpu statistics from
> struct kernel_stat and puts them in a cpu_stat structure, one per cpu,
> cacheline padded.  The data is still coolated and presented through
> /proc/stat, but another file /proc/cpustat is also added.  The locking
> is as nonexistant as it was with kernel_stat, but who cares, they're
> just fuzzy stats to be eyeballed by system tuners :).

Hey! The lack of atomicity causes "top" to do one of 3 things
for the idle time report, depending on the version:

1. negative numbers
2. wrap-around (42000000.00% idle)
3. truncate to zero (the numbers don't add up)

This is because top sees the idle time run backwards for a moment.
