Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754881AbWKUXNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbWKUXNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbWKUXNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:13:09 -0500
Received: from gw.goop.org ([64.81.55.164]:24786 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1754881AbWKUXNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:13:08 -0500
Message-ID: <456387F9.3010000@goop.org>
Date: Tue, 21 Nov 2006 15:12:57 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151824.36198.ak@suse.de> <200611151846.31109.dada1@cosmosbay.com> <200611211238.20419.dada1@cosmosbay.com> <456372AD.5080807@goop.org> <4563766E.8070408@cosmosbay.com>
In-Reply-To: <4563766E.8070408@cosmosbay.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> for umask/getppid(), its a basic loop with 100.000.000 iterations

Ah, OK, so there's about 2.5-3.5ns difference due to the instructions
you removed.  That's very much in line with that I saw in my measurements.

> for read/write(), loop with 10.000.000 iterations

2 syscalls/iteration?  It's interesting you measured about the same
absolute time difference (.42s) even though you're doing 1/5th the
number of syscalls.

> elapsed time (/usr/bin/time ./prog)
> 10 runs, and the minimum time is taken.

Hm, but "time" measures user, system and real time.  You used real time?

> Hum... Do you mean a cache miss every time we do a syscall ? What
> could invalidate this cache exactly ?

Well, there might be a miss simply because the line got evicted.  But as
Andi pointed out, a hot benchmark like this is very unlikely to get any
cache misses unless there's something very unfortunate happening.

    J
