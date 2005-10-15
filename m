Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVJOHqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVJOHqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVJOHqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:46:36 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:59888 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751116AbVJOHqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:46:36 -0400
Date: Sat, 15 Oct 2005 00:58:51 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: li nux <lnxluv@yahoo.com>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, linux <linux-kernel@vger.kernel.org>
Subject: Re: lock_kernel twice possible ?
Message-ID: <20051015075851.GA10778@gaz.sfgoth.com>
References: <2cd57c900510150033o7bd44608vdc57cb32e335b933@mail.gmail.com> <20051015073803.26937.qmail@web33311.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015073803.26937.qmail@web33311.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sat, 15 Oct 2005 00:58:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

li nux wrote:
> Sorry, couldn't get what you want to say.
> Can you please elaborate.

A "recursive lock" is one that can be taken multiple times by the same
owner.  So:

	lock_kernel();
	lock_kernel();
	unlock_kernel();
	unlock_kernel();

is perfectly ok.  The lock_kernel() code detects that the calling thread
already owns the lock and just increments current->lock_depth.

Under linux locks are non-recursive EXCEPT for lock_kernel() (aka the BLK
or "big kernel lock")

See lib/kernel_lock.c for more details.

-Mitch
