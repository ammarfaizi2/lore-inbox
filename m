Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWAGXaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWAGXaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWAGXaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:30:22 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48534 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161053AbWAGXaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:30:21 -0500
From: Junio C Hamano <junkio@cox.net>
To: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [KERNEL 2.6.15]  All files have -rw-rw-rw- permission.
References: <20060105191736.1ac95e4b.rdunlap@xenotime.net>
	<1986219.1136463311449.komurojun-mbn@nifty.com>
	<3378320.1136549095236.komurojun-mbn@nifty.com>
cc: linux-kernel@vger.kernel.org
Date: Sat, 07 Jan 2006 15:30:18 -0800
Message-ID: <7vmzi78vlh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Komuro <komurojun-mbn@nifty.com> writes:

> But, is there any reason to set -----w--w- bit
> by default?

Yes.

Please do not extract the kernel tarball as the root user,
especially if you do not know how tar command works for root
user by default (hint: --no-same-permissions).

Setting g-w in the archive forces arbitrary policy on people who
work with umask 002 as a non-root user.  We can let that policy
to be controlled by user's umask by being lenient in the
tarball.  For the same reason, if somebody has umask 0, there is
no reason for us (as tarball creator) to impose o-w as a policy
on him either, hence git-tar-tree output has 0666 or 0777 modes.




