Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269975AbRHZNWU>; Sun, 26 Aug 2001 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271007AbRHZNWK>; Sun, 26 Aug 2001 09:22:10 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:436 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S269975AbRHZNV4>;
	Sun, 26 Aug 2001 09:21:56 -0400
Date: Sun, 26 Aug 2001 15:22:04 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826152204.B22677@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010826013155Z16205-32383+1383@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108260030390.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108260030390.5646-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 12:32:09AM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> Reality check time indeed.  If you propose that disabling
> readahead should improve read performance something fishy
> is going on ;)

Actually, I also believe that. If you have no memory to store read-ahead
data then your only chance is what I try to do: massively parallelize
reads so the elevator can optimize what's possible and do no read-ahead
whatsoever.

Of course, in general, read-ahead is a must. Using 256k socket buffer
+ 128k userspace bounce buffer is, effectively, a 384k read-ahead per
connenction (the average connection speed is about 8k/s btw, so thats
about one read every 16 seconds. 16 seconds is also about the time between
sending out the response headers and the beginning of the data transfer,
which is ok in my case). The problem is that read-ahead (seems to) go
completely havoc when read()'s are issued in many threads at the same time.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
