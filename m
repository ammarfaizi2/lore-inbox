Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbUAFFtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUAFFtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:49:31 -0500
Received: from pD9E560BB.dip.t-dialin.net ([217.229.96.187]:46224 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S266068AbUAFFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:49:26 -0500
To: Libor Vanek <libor@conet.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
From: Andi Kleen <ak@muc.de>
Date: Tue, 06 Jan 2004 06:49:16 +0100
In-Reply-To: <1aQy3-2y1-7@gated-at.bofh.it> (Libor Vanek's message of "Tue,
 06 Jan 2004 05:00:15 +0100")
Message-ID: <m3znd139ur.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1aQy3-2y1-7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Vanek <libor@conet.cz> writes:
> ...
> asmlinkage long sys_open(const char __user * filename, int flags, int mode)
> {
>         char * tmp;
>         int fd, error;
> 	char tmp_path[PATH_MAX],tmp2_path[PATH_MAX];

PATH_MAX is 4096. The i386 stack is only 6k. You already overflowed it.
You're lucky if your machine only panics, much worse things can happen
with kernel stack overflows.

-Andi
