Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271467AbRHZTS4>; Sun, 26 Aug 2001 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271473AbRHZTSr>; Sun, 26 Aug 2001 15:18:47 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:37557 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271467AbRHZTSj>;
	Sun, 26 Aug 2001 15:18:39 -0400
Date: Sun, 26 Aug 2001 21:18:47 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826211847.B2994@cerebro.laendle>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva> <20010826013155Z16205-32383+1383@humbolt.nl.linux.org> <20010826044942.G29129@cerebro.laendle> <20010826172310Z16216-32383+1477@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010826172310Z16216-32383+1477@humbolt.nl.linux.org>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 07:29:43PM +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:
> Yes, this probably points at a bug in linus's tree.  This needs more digging.
> You're streaming the mp3's over the net or from your disk?

at home I just do the equivalent of "mpg123 <file>". I often copy around
100-300mb large video files, often many of them, and the linus' kernels
seem to have better throughput but that's not feasible if you have to wait
until the transfer ends (X often becomes unusable interactively).

> > if not I will test it at a later time. Now, a question: how does the
> > per-block-device read-ahead fit into this picture?  Is it being ignored? I 
> > fiddled with it (under 2.4.8pre4) but couldn't see any difference.
> 
> It should not be being ignored.  This needs to be looked into.

so the efefctive read-ahead is 2min(per-block-device, kernel-global)"? if
yes, then this would be ideal for my case, as usage patterns are strictly
seperated by disk in the machine, so I could get the best of all worlds.

> tree, otherwise changing the default MAX_READAHEAD requires a recompile.  

I like the proposed ideas of making it autotune ;) I think very large
readaheads make a lot of sense under normal loads with modern harddisks,
but not always.

> The reason for that is still unclear.  I realize you're testing this under 
> live load (you're a brave man)

Well, I don't get paid for the service and no company or individual
depends on it, so it's purely my personal desire to provide as good
service as possible to my users. It's also a great challange to make it
work at all ;)

Also, this whole thread was very fruitfull for that server:

   929 (929) connections
   4084385150 bytes written in the last 1044.23861896992 seconds
   (3911352.3 bytes/s)

which is almost twice as fast as with my old setup/config. Thanks to all
who analyzed it, sent patches and gave hints (thttpd gave about 700kb/s
on the same setup, with only 250 connections, but admittedly only 4k
read-requests).

I believe that, with some tweaking (more memory dedicated to buffers), I
could go to 4.5 and maybe 5mb/s, but certainly not much higher. And it's
no longer thrashing. And linux does the job nicely ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
