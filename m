Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289619AbSBERNT>; Tue, 5 Feb 2002 12:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289659AbSBERNJ>; Tue, 5 Feb 2002 12:13:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15942 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289619AbSBERMz>; Tue, 5 Feb 2002 12:12:55 -0500
Date: Tue, 5 Feb 2002 18:13:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] New Read-Copy Update patch
Message-ID: <20020205181354.M3135@athlon.random>
In-Reply-To: <20020205211826.B32506@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020205211826.B32506@in.ibm.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 09:18:26PM +0530, Dipankar Sarma wrote:
> Here is a "new" Read-Copy update patch that tries to address
> many of the concerns with the previous RCU patches. The
> details of RCU are documented as usual at
> http://lse.sourceforge.net/locking/rcupdate.html.
> 
> Main features of rcu-2.5.3.patch -
> 
> 1. Unlike my previous patch based on the old DYNIX/ptx algorithm
>    this does not have any code in arch-dependent directories. This
>    should make Andrea happy ;-)
> 2. No overhead in fastpath other than a per-cpu counter increment
>    during context switch.
> 3. RCU callbacks maintained in per-cpu lists, so global locking
>    needs to be used only once in every quiescent cycle, not
>    for queueing RCU callbacks.
> 4. No changes to scheduler code.
> 5. No RCU, no overhead other than the context switch counter increment.

I think you attached the wrong patch, the below one is based on the
kernel thread that we don't need with the scheduler counter.

BTW, I'd like to point out that the schedule counter is likely to be at
zero cacheline cost.

Andrea
