Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSGTKyH>; Sat, 20 Jul 2002 06:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGTKyH>; Sat, 20 Jul 2002 06:54:07 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:54661 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315406AbSGTKyG>;
	Sat, 20 Jul 2002 06:54:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code, v2
Date: Sat, 20 Jul 2002 12:58:42 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020719011300.548d72d5.arodland@noln.com> <20020719190213.2a2d51f8.arodland@noln.com>
In-Reply-To: <20020719190213.2a2d51f8.arodland@noln.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Vrwh-0000b5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice joke.  Unfortunately, this code is too useful to ignore.  I distinctly 
remember finding myself in the position of having completed the firmware of 
an embedded device without properly recording the correspondence of led blink 
patterns to error codes, the result being that if the firmware had ever failed
(luckily it never did) nobody would have been quite sure why.  How much more 
useful, satisfying and stylish to have encoded the failure messages in morse.

On Saturday 20 July 2002 01:02, Andrew Rodland wrote:
> Thanks a million to the unnamed linux<AT>horizon.com for some great
> suggestions/info. v2 of the morse-panic patch features better
> punctuation handling, proper morse-like timings, and something like 1/5
> the static data requirement, thanks to the varicode algo that I
> couldn't come up with myself. :)

Indeed, that one had me scratching my head, even with the code in front of 
me.  Let me describe the encoding method for the benefit of anybody not 
energetic or foolish enough to puzzle it out for themselves:

  - The sequence is encoded from low bit to high, zero=dit, one=dah

  - The sequence always terminates with a one=dah, which is dropped,
    followed by an infinite string of zeros.

The infinite string of zeros is shifted in from the top of the byte, hence 
the terminating condition morse <= 1, which prudently covers the impossible 
case of morse == 0.

This deserves a comment.

Note that there is a bug waiting to bite: you need to declare morse as 
unsigned char, otherwise you will be unable to make good on your claim that 
up to 7 morse bits can be encoded.

-- 
Daniel
