Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272291AbRHXSdi>; Fri, 24 Aug 2001 14:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272293AbRHXSda>; Fri, 24 Aug 2001 14:33:30 -0400
Received: from maila.telia.com ([194.22.194.231]:61437 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S272291AbRHXSdW>;
	Fri, 24 Aug 2001 14:33:22 -0400
Message-Id: <200108241833.f7OIX1Q26223@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Fri, 24 Aug 2001 20:28:37 +0200
X-Mailer: KMail [version 1.3]
Cc: "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108241433130.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108241433130.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday den 24 August 2001 19:43, Rik van Riel wrote:
> On Fri, 24 Aug 2001, Roger Larsson wrote:
> > I earlier questioned this too...
> > And I found out that read ahead was too short for modern disks.
> > This is a patch I did it does also enable the profiling, the only needed
> > line is the
> > -#define MAX_READAHEAD  31
> > +#define MAX_READAHEAD  511
> > I have not tried to push it further up since this resulted in virtually
> > equal total throughput for read two files than for read one.
>
> Note that this can have HORRIBLE effects if the total
> size of all the readahead windows combined doesn't fit
> in your memory.
>
> If you have 100 IO streams going on and you have space
> for 50 of them, you'll find yourself with 100 threads
> continuously pushing each other's read-ahead data out
> of RAM.

Not having the patch gives you another effect - disk arm is
moving from track to track in a furiously tempo...
The time it takes to move is longer than the time it is allowed
to read - this is not effective! That would limit throughput
to half the possible. If less than 511 - 31 pages are thrown
away you probably gain anyway...

One optimization to do would be to stop readahead at file
fragments.

But READA pages are special since they might be read never!
Streaming puts interesting kinds of pressure on VM...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
