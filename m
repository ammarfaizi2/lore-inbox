Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUA1L6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUA1L6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:58:05 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:38378 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265914AbUA1L5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:57:48 -0500
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in interruptible_sleep_on in 2.6.2-rc2-mm1
References: <20040128110006.GA16553@rushmore>
From: Jes Sorensen <jes@wildopensource.com>
Date: 28 Jan 2004 06:57:22 -0500
In-Reply-To: <20040128110006.GA16553@rushmore>
Message-ID: <yq0znc8xp3x.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Randy" == rwhron  <rwhron@earthlink.net> writes:

Randy> Quad P3 Xeon boots with a series of these: Badness in
Randy> interruptible_sleep_on at kernel/sched.c:2239 Call Trace:

It's because XFS's pagebuf_daemon calls interruptible_sleep_on without
holding the big kernel lock. While what it's doing is pretty ugly,
it's in fact not dangerous in thise case. I am seeing the same on an
ia64, but it only shows up a couple of times and then quiets down and
it boots fine.

If you want, you can remove the SLEEP_ON_BKLCHECK in
kernel/sched.c:interruptible_sleep_on() until a proper fix comes out.
Or even better, rewrite the code in xfs/pagebuf/pagebuf.c to do the
right thing instead.

Cheers,
Jes
