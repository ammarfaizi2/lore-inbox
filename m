Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136238AbREGPyz>; Mon, 7 May 2001 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136240AbREGPyp>; Mon, 7 May 2001 11:54:45 -0400
Received: from mail.valinux.com ([198.186.202.175]:51466 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S136238AbREGPya>;
	Mon, 7 May 2001 11:54:30 -0400
Date: Mon, 7 May 2001 09:54:15 -0600
From: Don Dugger <n0ano@valinux.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Don Dugger <n0ano@valinux.com>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Thread core dumps for 2.4.4
Message-ID: <20010507095415.A3716@tlaloc.n0ano.com>
In-Reply-To: <20010503085418.A12123@tlaloc.n0ano.com> <Pine.LNX.4.30.0105061833220.16238-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0105061833220.16238-100000@fs131-224.f-secure.com>; from szaka@f-secure.com on Sun, May 06, 2001 at 06:47:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szaka-

I would considier what you're suggesting to be a refinement on this
patch.  The first problem is to generate valid core dumps for all
threads.  Adding in policy decisions about which threads actually
generate core files can be done later.

Adam ? (I'm sorry, I've lost the mail with his full name) actually
posted a patch a while back that only dumped core for the first
faulting thread.  The problem with this patch is that it didn't
deal with the potential races between threads modifying the memory
maps while the core dump was being generated.  Also, this patch used
a single system wide variable to make its policy decisions, this
really needs to be a per-process decision.

What I'd really like to see is some sort of rondezous capability where,
when a fatal exception occurs, all the threads are halted, appropriate
core dumps are generated, and then all the threads are resumed (to
terminate or continue as appropriate).  This is a bigger project that
will require a little thought.

On Sun, May 06, 2001 at 06:47:28PM +0200, Szabolcs Szakacsits wrote:
> 
> On Thu, 3 May 2001, Don Dugger wrote:
> 
> > The attached patch allows core dumps from thread processes in the 2.4.4
> > kernel.  This patch is the same as the last one I sent out except it fixes
> > the same bug that `kernel/fork.c' had with duplicate info in the `mm'
> > structure, plus this patch has had more extensive testing.
> 
> AFAIK Linux can't dump the threads to the same file as others but doing
> it to different files looks a bit scary. How the system behaves when you
> dump a heavy threaded app with a decent VM [i.e just think about a
> bloatware instead of malicious code]? How will the developer know which
> thread caused the fault? I've found dumping just the faulting thread is
> enough about 100% of the cases especially because [on SMP] others can
> run on and the dump is much more close to "garbage" then usuful info
> from a debug point of view.
> 
> 	Szaka

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
