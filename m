Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271247AbRHZC5q>; Sat, 25 Aug 2001 22:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271252AbRHZC5g>; Sat, 25 Aug 2001 22:57:36 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:56754 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271247AbRHZC5c>;
	Sat, 25 Aug 2001 22:57:32 -0400
Date: Sun, 26 Aug 2001 04:57:46 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826045746.H29129@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010826013442.C29129@cerebro.laendle> <Pine.LNX.4.33L.0108252301180.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108252301180.5646-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 11:02:25PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> This is because the readahead windows are too large so the
> kernel ends up evicting data before its needed and has to
> re-read the data.
> 
> Also see http://linux-mm.org/wiki/moin.cgi/StreamingIo
> in the Linux-MM wiki.

O_STREAMING is an interesting idea (I talked with stefan traby about
the problem and we came to a similar conclusion - fadvise instead of
madvise, and per-file characteristics as opposed to blockdevices or global
settings).

Anyway, so far it really looks as if this is the case - there is some
limit (around 700 conns) where the available memory doesn't suffice for
read-ahead.

> This problem should be relatively easy to fix for 2.4.

Nice ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
