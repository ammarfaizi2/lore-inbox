Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTHWRAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTHWQ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:57:33 -0400
Received: from dp.samba.org ([66.70.73.150]:26762 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263348AbTHWPGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:06:23 -0400
Date: Sun, 24 Aug 2003 01:04:13 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling
Message-ID: <20030823150413.GA32537@krispykreme>
References: <20030823025448.GA32547@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823025448.GA32547@atj.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>  Adding smp_mb__after_test_and_set_bit() at the end of
> tasklet_trylock() should remedy the situation.  As
> smp_mb__{before|after}_test_and_set_bit() don't exist yet, I'm
> attaching a patch which adds smp_mb__after_clear_bit().  The patch is
> against 2.4.21.

No, the atomic and bitop operations that return values (like
test_and_set_bit) must have barriers. Is x86 missing these?

> P.S. Please comment on the addition of
> smp_mb__{before|after}_test_and_set_bit().

Only the atomic and bitops that dont return values (set_bit, atomic_inc
etc) might require ordering depending on use.

Anton
