Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271580AbRHZVAl>; Sun, 26 Aug 2001 17:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271581AbRHZVAc>; Sun, 26 Aug 2001 17:00:32 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:524 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271580AbRHZVAR>; Sun, 26 Aug 2001 17:00:17 -0400
Content-Type: text/plain;
  charset="utf-8"
From: Daniel Phillips <phillips@bonn-fries.net>
To: pcg@goof.com
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 23:07:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva> <20010826172310Z16216-32383+1477@humbolt.nl.linux.org> <20010826211847.B2994@cerebro.laendle>
In-Reply-To: <20010826211847.B2994@cerebro.laendle>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010826210026Z16294-32383+1508@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 26, 2001 09:18 pm, pcg@goof.com ( Marc) (A.) (Lehmann ) wrote:
> On Sun, Aug 26, 2001 at 07:29:43PM +0200, Daniel Phillips wrote:

> > > Now, a question: how does the per-block-device read-ahead fit into
> > > this picture?  Is it being ignored? I fiddled with it (under
> > > 2.4.8pre4) but couldn't see any difference.
> > 
> > It should not be being ignored.  This needs to be looked into.
> 
> so the efefctive read-ahead is 2min(per-block-device, kernel-global)"? if
> yes, then this would be ideal for my case, as usage patterns are strictly
> seperated by disk in the machine, so I could get the best of all worlds.

Yes.

> > tree, otherwise changing the default MAX_READAHEAD requires a recompile.  
> 
> I like the proposed ideas of making it autotune ;) I think very large
> readaheads make a lot of sense under normal loads with modern harddisks,
> but not always.

Well, autotuning will require some r&d, plus a settling in period.  In the 
meantime it's quite safe and useful to use a user-set global as you showed, 
and also will be helpful during the development of the automagic version.

> [...]
> Also, this whole thread was very fruitfull for that server:
> 
>    929 (929) connections
>    4084385150 bytes written in the last 1044.23861896992 seconds
>    (3911352.3 bytes/s)
> 
> which is almost twice as fast as with my old setup/config. Thanks to all
> who analyzed it, sent patches and gave hints (thttpd gave about 700kb/s
> on the same setup, with only 250 connections, but admittedly only 4k
> read-requests).

To recap, you made these changes:

  - Changed to -ac
  - Set max-readahead through proc

Anything else?  Did you change MAX_SECTORS?

> I believe that, with some tweaking (more memory dedicated to buffers), I
> could go to 4.5 and maybe 5mb/s, but certainly not much higher. And it's
> no longer thrashing. And linux does the job nicely ;)

Good, but should we rest on our laurels now?

--
Daniel
