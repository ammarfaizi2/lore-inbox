Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbSIRQ1p>; Wed, 18 Sep 2002 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267302AbSIRQ1p>; Wed, 18 Sep 2002 12:27:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7947 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267306AbSIRQ1m>; Wed, 18 Sep 2002 12:27:42 -0400
Date: Wed, 18 Sep 2002 13:32:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0209181330580.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Linus Torvalds wrote:

> I would suggest something like this:
>  - make pid_max start out at 32k or whatever, to make "ps" look nice if
>    nothing else.
>  - every time we have _any_ trouble at all with looking up a new pid, we
>    double pid_max.

> +		if (nr_threads > pid_max >> 4)
> +			pid_max <<= 1;

... but watch out for over/underflow.  ;)

It would also be nice if we had some known limit on pid_max (say 8
million, fits in 7 digits).

regards,

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

