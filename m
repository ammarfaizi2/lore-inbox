Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSEYW5w>; Sat, 25 May 2002 18:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315443AbSEYW5v>; Sat, 25 May 2002 18:57:51 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:34769 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315442AbSEYW5u>;
	Sat, 25 May 2002 18:57:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc,patch] breaking up sched.h
Date: Sun, 26 May 2002 00:57:34 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0205242219001.30843-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BkTf-0003p3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 May 2002 22:34, Tim Schmielau wrote:
> While it's quite common to do "current->foo", every file doing
> so needs to #include <linux/sched.h> for the declaration of
> task_struct.
> In order to reduce the number of #include <linux/sched.h>, I'd propose to
> move task_struct to a separate header file (patch below), and include it
> from <asm/current.h>.

Such separation of data vs function declarations is a good thing.  This
results in a source tree which is easier to work with and contains fewer
strange hacks to get around include order problems.  Possibly, the kernel
may end up compiling faster as well, if some of the includes aimed merely
at obtaining the data definitions don't have to pick up the (much
bulkier) operation definitions as well.

This is the same technique I used in my 'early_page' patch set, which 
gave me the ability to rewrite all the address operations in the page.h
and pgtable.h headers as inline functions instead of macros.

-- 
Daniel
