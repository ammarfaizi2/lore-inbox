Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbSLKU5i>; Wed, 11 Dec 2002 15:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbSLKU5i>; Wed, 11 Dec 2002 15:57:38 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:56972 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267287AbSLKU5h>; Wed, 11 Dec 2002 15:57:37 -0500
Message-ID: <3DF7A890.A688AF54@attbi.com>
Date: Wed, 11 Dec 2002 16:05:20 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Marco d'Itri" <md@Linux.IT>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 nanosleep fails
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco d'Itri wrote:
> nanosleep fails after being interrupted:
>
> [...]
> nanosleep({1, 0},
> [1]+  Stopped                 strace tail -f /var/log/uucp/Log
> md@wonderland:~$ fg
> strace tail -f /var/log/uucp/Log
>  <unfinished ...>
> --- SIGCONT (Continued) ---
> <... nanosleep resumed> 0)              = -1 ENOSYS (Function not implemented)>
>
> This can be reliably reproduced.                                              

Hi Marco, Everyone,

I was able to reproduce this issue.  It happens on all the
kernels I tried including a stock Redhat kernel.  This is just 
an idiosyncrasy of strace. In this case both the strace and
tail are sent a SIGTSTP when they are put into the background.
Its not suprising that this might confuse strace.

I also tried this with a program which just does a long
nanosleep.  Strace still shows a return of ENOSYS but the
program actually gets the correct EINTR.

Jim Houston - Concurrent Computer Corp.
