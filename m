Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270263AbRHMPxI>; Mon, 13 Aug 2001 11:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270264AbRHMPw7>; Mon, 13 Aug 2001 11:52:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59655 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270263AbRHMPws>;
	Mon, 13 Aug 2001 11:52:48 -0400
Date: Mon, 13 Aug 2001 12:52:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: VM working much better in 2.4.8 than before
In-Reply-To: <E15WH1s-0007Jw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0108131245200.6118-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Alan Cox wrote:

> > Yes, those would be the expected effects of use-once, in fact it was
> > "morning after updatedb" question that got me started on it.
>
> updatedb is also absolutely fine if you just work with the existing VM
> and up the inode pressure a little. I'm still very unconvinced by
> use-once.

Use-once has a number of theoretical disadvantages too:

1) newly read in pages are evicted earlier, this means
   readahead pages will either evict each other or the
   amount of readahead done might need to be shrunk
   -- the current readahead code is not prepared for this,
      use-once could lead to more disk seeks being done

2) since we add new pages to the inactive list, VM
   balancing is faced with a really strange situation ;)

Yes, these things are solvable, but not without redesigning
major parts of the VM balancing to do things which have never
been done before. I'm not sure 2.4 is the time to do that.

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

