Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUGNDSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUGNDSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUGNDSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:18:12 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:10179 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267315AbUGNDRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:17:13 -0400
Date: Wed, 14 Jul 2004 05:17:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Zaitsev <peter@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040714031701.GT974@dualathlon.random>
References: <1089771823.15336.2461.camel@abyss.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089771823.15336.2461.camel@abyss.home>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Tue, Jul 13, 2004 at 07:23:44PM -0700, Peter Zaitsev wrote:
> Hi,
> 
> To be honest I was truly surprised seeing OOM killer killing MySQL
> without any good reason during highly IO intensive test:
> 
> Out of Memory: Killed process 19301 (mysqld).
> Out of Memory: Killed process 19302 (mysqld).
> Out of Memory: Killed process 19303 (mysqld).
> Out of Memory: Killed process 19304 (mysqld).
> Out of Memory: Killed process 19305 (mysqld).
> Out of Memory: Killed process 19306 (mysqld).
> Out of Memory: Killed process 19309 (mysqld).
> Out of Memory: Killed process 19310 (mysqld).
> Out of Memory: Killed process 19311 (mysqld).
> Out of Memory: Killed process 19312 (mysqld).
> Out of Memory: Killed process 19737 (mysqld).
> Out of Memory: Killed process 19739 (mysqld).
> Out of Memory: Killed process 19821 (mysqld).

this is a well known 2.6 oom-killer problem w/o swap. Not the worst one,
I mentioned the worst one here just a few weeks ago:
	
	http://groups.google.com/groups?q=g:thl1518647992d&dq=&hl=en&lr=&ie=UTF-8&selm=fa.i50b3kk.p0qsjs%40ifi.uio.no


the only fix at the moment is to use 2.4 with oom killer disabled (the
same issue could happen with 2.4 too). even if it would work better than
the above the oom killer will still get screwed by mlock and it simply
cannot know how much lowmem is freeable leading to deadlock instead of
-ENOMEM with syscalls if you fill the whole lowmem zone.

I fixed everything related to oom in 2.4 some year back, now need to
port to 2.6.

workaround is to add swap in 2.6, but in some condition it'll still
underpeform compared to 2.4 due the lack of the zone-reserve-ratio algo.
