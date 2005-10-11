Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVJKQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVJKQEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVJKQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:04:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751133AbVJKQEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:04:23 -0400
Date: Tue, 11 Oct 2005 09:03:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux@horizon.com,
       Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
In-Reply-To: <434BDB1C.60105@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
 <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
 <434BDB1C.60105@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Oct 2005, Eric Dumazet wrote:
>
> As NR_CPUS might be > 128, and every spining CPU decrements the lock, we need
> to use more than 8 bits for a spinlock. The current (i386/x86_64)
> implementations have a (theorical) bug in this area.

I don't think there are any x86 machines with > 128 CPU's right now.

The advantage of the byte lock is that a "movb $0" is three bytes shorter 
than a "movl $0". And that's the unlock sequence.

		Linus
