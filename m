Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSG2UVN>; Mon, 29 Jul 2002 16:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSG2UVN>; Mon, 29 Jul 2002 16:21:13 -0400
Received: from [195.223.140.120] ([195.223.140.120]:26744 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316712AbSG2UVM>; Mon, 29 Jul 2002 16:21:12 -0400
Date: Mon, 29 Jul 2002 22:25:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Larson <plars@austin.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] Linux-2.5 fix for get_pid() hang
Message-ID: <20020729202535.GZ1201@dualathlon.random>
References: <1027972670.7699.210.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027972670.7699.210.camel@plars.austin.ibm.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 02:57:46PM -0500, Paul Larson wrote:
> This is a fix for the problem where get_pid will hang the machine if you
> request a new pid when all available pids are in use.  This also adds
> the appropriate checking for p->tgid in get_pid that was somehow
> overlooked before.  This patch has been in 2.4 since 2.4.19-pre9.

no please, this below patch is superior and it fixes as well fixes a
longstanding race condition in fork() (see the semaphore):

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa3/10_get_pid-no-deadlock-and-boosted-4

it may not apply cleanly but porting should be trivial.

Andrea
