Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbRGXWUg>; Tue, 24 Jul 2001 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGXWUZ>; Tue, 24 Jul 2001 18:20:25 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:7504 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266067AbRGXWUM>; Tue, 24 Jul 2001 18:20:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Patrick Dreker <patrick@dreker.de>
Organization: Chaos Inc.
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 00:16:10 +0200
X-Mailer: KMail [version 1.2.9]
Cc: Linus Torvalds <torvalds@transmeta.com>, <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241731400.20326-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107241731400.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15PATS-0000A5-00@wintermute>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Am Dienstag, 24. Juli 2001 22:32 schrieb Rik van Riel:
> On Tue, 24 Jul 2001, Patrick Dreker wrote:
>
> 	[snip program with mmap()]
>
> > I have tested this on my Athlon 600 with 128 Megs of RAM, and it
> > does not make any difference whether I use plain 2.4.7 or
> > 2.4.5-use-once.
>
> As expected. Only programs using generic_file_{read,write}()
> will be impacted at the moment.
D'oh... got some thing wrong there it seems :-(
Anyways, I still have some old routines in the program doing the same via 
read(). I have tried that (although the program is pretty silly, as it reads 
the 240megs in 4 byte chunks.... the call overhead probably is the bigger 
problem there...) and it improved the runtime by aproximately 20% using the 
use_once patch.

linux-2.4.7:
22.300u 135.310s 2:41.38 97.6%  0+0k 0+0io 110pf+0w

linux-2.4.5-use_once:
14.980u 108.870s 2:09.79 95.4%  0+0k 0+0io 200pf+0w

Both measurements taken after reboot and while running KDE2.2
As stated: I am still willing to do further experiments... (read()ing larger 
chunks at once?)

-- 
Patrick Dreker
