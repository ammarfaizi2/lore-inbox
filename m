Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVERXmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVERXmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVERXmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:42:37 -0400
Received: from one.firstfloor.org ([213.235.205.2]:18309 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262405AbVERXm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:42:29 -0400
To: "Gilbert, John" <JGG@dolby.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
From: Andi Kleen <ak@muc.de>
Date: Thu, 19 May 2005 01:42:28 +0200
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net> (John
 Gilbert's message of "Wed, 18 May 2005 12:07:29 -0700")
Message-ID: <m1ll6cyucb.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gilbert, John" <JGG@dolby.com> writes:
>
> I think it's been in there a while, but only really blows up when built
>
> under recent kernels.
>
> I agree, it's probably not the right way to go.

It's quite dangerous. I suppose it uses this for atomic.h, but it
means that a mysql compiled under a uniprocessor kernel (or rather
with a autoconf.h of a uniprocessor kernel, it can even be SMP) will
have subtle races when run on a SMP system because the atomic
instructions will miss lock prefixes. Sounds like an open
deathtrap to me.

I would suggest changing MySQL to keep its own copies of atomic.h
for the different architectures. Then they can drop the asm/system.h
includes too.

-Andi

