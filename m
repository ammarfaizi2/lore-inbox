Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbSIRQ5N>; Wed, 18 Sep 2002 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268250AbSIRQ4T>; Wed, 18 Sep 2002 12:56:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57103 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268149AbSIRQzb>; Wed, 18 Sep 2002 12:55:31 -0400
Date: Wed, 18 Sep 2002 14:00:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180950010.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0209181358470.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Linus Torvalds wrote:
> On Wed, 18 Sep 2002, Rik van Riel wrote:
> >
> > On second thought ... yes there's a reason.  Suppose you have
> > 100000 threads on your box already, how long is it going to
> > take to walk them all to figure out the pid distribution ?

> The pid space is not a uniform distribution, which your made-up-example
> depends on. So you usually walk the 100000 threads _once_, and then you
> don't have to walk them again for quite a long time.

Agreed, you're right there.  On the other hand, walking the threads
_once_ will take 1.5 minutes on a 500 MHz PII (according to Ingo's
measurements).

That's about 18 times the timeout for the NMI oopser and will cause
people real trouble.

cheers,

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

