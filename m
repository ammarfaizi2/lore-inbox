Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbUCTHhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 02:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbUCTHhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 02:37:50 -0500
Received: from ns.suse.de ([195.135.220.2]:27551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263241AbUCTHht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 02:37:49 -0500
To: Roland Dreier <roland@digitalvampire.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fast 64-bit atomic writes (SSE?)
References: <874qskl5ca.fsf@love-shack.home.digitalvampire.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Mar 2004 08:37:47 +0100
In-Reply-To: <874qskl5ca.fsf@love-shack.home.digitalvampire.org.suse.lists.linux.kernel>
Message-ID: <p73znacvuic.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@digitalvampire.org> writes:
> 
> General question:
>   What's the best way to do this?

Definitely not how you do it ;-) You corrupt the user space FPU context.
Also you didn't do a CPUID check, so it would just crash on machines

The RAID code has some examples on how to use SSE2 in the kernel correctly.

Better is probably to use CMPXCHG8, which avoids all of this.  

-Andi
