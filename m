Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130697AbRACQJl>; Wed, 3 Jan 2001 11:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRACQJb>; Wed, 3 Jan 2001 11:09:31 -0500
Received: from hermes.mixx.net ([212.84.196.2]:39950 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130697AbRACQJW>;
	Wed, 3 Jan 2001 11:09:22 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] drop-behind fix for generic_file_write
Date: Wed, 3 Jan 2001 16:21:17 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.21.0101031256040.1403-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0101031256040.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01010316360903.00713@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2001, Rik van Riel wrote:
> Hi Linus, Alan,
> 
> the following (trivial) patch fixes drop-behind behaviour
> in generic_file_write to only drop fully written pages.
> 
> This increases performance in dbench by about 8% (as
> measured by Daniel Phillips) and should get rid of the
> logfile bottleneck Ingo Molnar found with the drop-behind
> call in generic_file_write in TUX tests.

Rik, I detected the speedup in -pre5 but it disappeared in -pre7 (which
turned in a faster performance than pre5 or 6 anyway).  I don't have an
explanation for that.  The idea makes sense: treat a partial page as
'in play' until completely full, then deactivate it.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
