Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271252AbRHZDc0>; Sat, 25 Aug 2001 23:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271267AbRHZDcQ>; Sat, 25 Aug 2001 23:32:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25618 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271252AbRHZDcG>;
	Sat, 25 Aug 2001 23:32:06 -0400
Date: Sun, 26 Aug 2001 00:30:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <stoffel@casc.com>, "Marc A. Lehmann" <pcg@goof.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <E15aoOZ-0008Ul-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0108260009570.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Alan Cox wrote:

> > Ummm... is this really more of an agreement that Daniel's used-once
> > patch is a good idea on a system.  Keep a page around if it's used
> > once, but drop it quickly if only used once?  But you seem to be
>
> Is there a reason aging alone cannot do most of the work instead.

Yes. We *REALLY* want MRU replacement for streaming IO, that is,
we want to replace the pages we just used with far more preference
than the pages we newly read in and have not used at all yet, but
are about to use.

Doing this by aging up the pages we're about to read would give
readahead pages far too much power to push out normal working set
pages, just aging down the pages behind us (instead of forcefully
deactivating them) looks to me like it wouldn't give them enough
bias over the not-yet-used newly read pages we are about to use.

OTOH, this is something worth experimenting with ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)



