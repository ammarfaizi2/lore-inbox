Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRGXWZ0>; Tue, 24 Jul 2001 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGXWZQ>; Tue, 24 Jul 2001 18:25:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60688 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266067AbRGXWZG>; Tue, 24 Jul 2001 18:25:06 -0400
Date: Tue, 24 Jul 2001 19:25:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Patrick Dreker <patrick@dreker.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <E15PATS-0000A5-00@wintermute>
Message-ID: <Pine.LNX.4.33L.0107241924040.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001, Patrick Dreker wrote:

> Anyways, I still have some old routines in the program doing the
> same via read(). I have tried that (although the program is
> pretty silly, as it reads the 240megs in 4 byte chunks.... the
> call overhead probably is the bigger problem there...) and it
> improved the runtime by aproximately 20% using the use_once
> patch.
>
> linux-2.4.7:
> 22.300u 135.310s 2:41.38 97.6%  0+0k 0+0io 110pf+0w
>
> linux-2.4.5-use_once:
> 14.980u 108.870s 2:09.79 95.4%  0+0k 0+0io 200pf+0w

COOL ....

> Both measurements taken after reboot and while running KDE2.2 As
> stated: I am still willing to do further experiments...
> (read()ing larger chunks at once?)

Could you try reading 4kB chunks at once ?

That way you should truly only touch each page once.

(using smaller chunks, or chunks which aren't a
multiple of 4kB should break the current code)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

