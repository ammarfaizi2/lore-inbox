Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbRCRQnc>; Sun, 18 Mar 2001 11:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbRCRQnX>; Sun, 18 Mar 2001 11:43:23 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22284 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131239AbRCRQnM>; Sun, 18 Mar 2001 11:43:12 -0500
Date: Sun, 18 Mar 2001 11:43:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: sct@conectiva.com.br, linux-kernel@conectiva.com.br
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <Pine.LNX.4.33.0103181407520.1426-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103181122480.13050-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Mike Galbraith wrote:

> > No, this was make -j30 bzImage.  (nscd was running though...)
> 
> I rebooted, shut down nscd prior to testing and did 5 builds in a row
> without a single gripe.  Started nscd for sixth run and instantly the
> kernel griped.  Yup.. threaded apps pushing swap.

OK, I'll write some code to prevent multiple threads from
stepping all over each other when they pagefault at the
same address.

What would be the preferred method of fixing this ?

- fixing do_swap_page and all ->nopage functions
- hacking handle_mm_fault to make sure no overlapping
  pagefaults will be served at the same time

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


