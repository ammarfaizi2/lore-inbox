Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbULHEce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbULHEce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 23:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbULHEcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 23:32:33 -0500
Received: from ozlabs.org ([203.10.76.45]:28839 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262019AbULHEcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 23:32:18 -0500
Subject: Re: [PATCH][1/2] fix unchecked returns from kmalloc() (in
	kernel/module.c)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com
In-Reply-To: <Pine.LNX.4.61.0412072203070.3320@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412072203070.3320@dragon.hygekrogen.localhost>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 12:57:54 +1100
Message-Id: <1102471074.20129.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 22:23 +0100, Jesper Juhl wrote:
> Problem reported by Katrina Tsipenyuk and the Fortify Software engineering 
> team in thread with subject "PROBLEM: unchecked returns from kmalloc() in 
> linux-2.6.10-rc2".

IMHO a better fix is to
(1) mark percpu_modinit() as __init.
(2) ignore unhandled failures in __init functions.

With some exceptions, I would prefer to see a not_on_init(cond) macro
inside kmalloc et. al. which barfs in a consistent way when allocations,
registrations, etc. fail on boot.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

