Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263127AbUKTRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUKTRAS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUKTQ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:59:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:58287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263118AbUKTQ6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:58:40 -0500
Date: Sat, 20 Nov 2004 08:58:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <20041120143755.E13550@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0411200853150.20993@ppc970.osdl.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Nov 2004, Russell King wrote:
> 
> Looks like expr->cond_true is NULL.  Line 566 of kernel/timer.c is:
> 
> int tickadj = 500/HZ ? : 1;             /* microsecs */
> 
> which makes it look like sparse doesn't understand such constructions.

Sparse does, but there were some changes in how it handles them, and they
were obviously buggy for the trivial compile-time-evaluation case. I
didn't see them because on all _my_ archiectures, 500/HZ evaluates to
false, so it doesn't look at the true case (which is a special case).

Trivial fix checked in and pushed out. Thanks,

		Linus
