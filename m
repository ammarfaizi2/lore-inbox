Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268292AbRGXQ5W>; Tue, 24 Jul 2001 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbRGXQ5M>; Tue, 24 Jul 2001 12:57:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17158 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268290AbRGXQ4z>; Tue, 24 Jul 2001 12:56:55 -0400
Date: Tue, 24 Jul 2001 13:56:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <jlnance@intrex.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <20010724083809.A1374@bessie.localdomain>
Message-ID: <Pine.LNX.4.33L.0107241355090.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001 jlnance@intrex.net wrote:
> On Tue, Jul 24, 2001 at 05:47:30AM +0200, Daniel Phillips wrote:
>
> > So I decided to look for a new way of approaching the use-once problem
> > that would easily integrated with our current approach.   What I came
> > up with is pretty simple: instead of starting a newly allocated page on
> > the active ring, I start it on the inactive queue with an age of zero.
> > Then, any time generic_file_read or write references a page, if its
> > age is zero, set its age to START_AGE and mark it as unreferenced.
>
> This is wonderfully simple and ellegant.

It's a tad incorrect, though.

If a page gets 2 1-byte reads in a microsecond, with this
patch it would get promoted to the active list, even though
it's really only used once.

Preferably we'd want to have a "new" list of, say, 5% maximum
of RAM size, where all references to a page are ignored. Any
references made after the page falls off that list would be
counted for page replacement purposes.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

