Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRHZTbT>; Sun, 26 Aug 2001 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271498AbRHZTbJ>; Sun, 26 Aug 2001 15:31:09 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:42933 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S271486AbRHZTbB>;
	Sun, 26 Aug 2001 15:31:01 -0400
Date: Sun, 26 Aug 2001 21:31:16 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010826213116.E2994@cerebro.laendle>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010824201125Z16096-32383+1213@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva> <20010825012338.B547@cerebro.laendle> <20010826164818Z16191-32383+1474@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010826164818Z16191-32383+1474@humbolt.nl.linux.org>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 06:54:55PM +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:
> But it's a very interesting idea: instead of performing readahead in 
> generic_file_read the user thread would calculate the readahead window

More basic, less interesting but far more useful would be real aio, sicne
this would get rid of hundreds of threads that need manual killing when the
server crashes during development and keep the accept socket open ;)

(But it seems we will have sth. like that in 2.6, so I am generally happy
;)

> submit.  The user thread benefits by avoiding some stalls due to
> readahead->readpage, as well as avoiding thrashing due to excessive
> readahead.

In an ideal world, I would not need user buffers as well and could just
tell the kernel "copy from file to network", but that requires too much
kernel tinkery I believe (although, when there is generic aio in the
kernel there might some day be a aio_sendfile ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
