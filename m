Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbRATRqB>; Sat, 20 Jan 2001 12:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131094AbRATRpq>; Sat, 20 Jan 2001 12:45:46 -0500
Received: from ns.caldera.de ([212.34.180.1]:46854 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129901AbRATRp0>;
	Sat, 20 Jan 2001 12:45:26 -0500
Date: Sat, 20 Jan 2001 18:45:06 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic IO write clustering
Message-ID: <20010120184506.A21943@caldera.de>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rajagopal Ananthanarayanan <ananth@sgi.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200101201557.QAA14088@ns.caldera.de> <Pine.LNX.4.21.0101201301050.6579-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0101201301050.6579-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Jan 20, 2001 at 01:24:40PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 01:24:40PM -0200, Marcelo Tosatti wrote:
> In case the metadata was not already cached before ->cluster() (in this
> case there is no disk IO at all), ->cluster() will cache it avoiding
> further disk accesses by writepage (or writepages()).

True.  But you have to go through ext2_get_branch (under the big kernel
lock) - if we can do only one logical->physical block translations,
why doing it multiple times?

> > Another thing I dislike is that the flushing gets more complicated with
> > yout VM-level clustering.  Now (and with my appropeach I'll describe
> > below) flushing is write it out now and do whatever you else want,
> > with you design it is 'find out pages beside this page in write out
> > a bunch of them' - much more complicated.  I'd like it abstracted out.
> 
> I dont see your point here. What I'm missing?

It's just a matter of taste.
(I thought it was clear enough that there is no technical advantage...)

> [...] 
>
> IMHO replicating the code is the worst thing. 

This does not replicated the code.  The 'normal' filesystems share the
code, and the special filesystems want to their own clustering anyway.
(See the discussion on xfs-devel yesterday).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
