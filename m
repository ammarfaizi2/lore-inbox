Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269817AbRHDHIO>; Sat, 4 Aug 2001 03:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269816AbRHDHHz>; Sat, 4 Aug 2001 03:07:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10502 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269817AbRHDHHv>; Sat, 4 Aug 2001 03:07:51 -0400
Date: Sat, 4 Aug 2001 02:38:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032330450.1193-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0108040222561.9719-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Linus Torvalds wrote:

> 
> On Sat, 4 Aug 2001, Ben LaHaise wrote:
> >
> > Within reason.  I'm actually heading to bed now, so it'll have to wait
> > until tomorrow, but it is fairly trivial to reproduce by dd'ing to an 8GB
> > non-sparse file.  Also, duplicating a huge file will show similar
> > breakdown under load.
> 
> Well, I've made a 2.4.8-pre4.
> 
> This one has marcelo's zone fixes, and my request suggestions. I'm writing
> email right now with the 8GB write in the background, and unpacked and
> patched a kernel. It's certainly not _fast_, but it's not too painful to
> use either.  The 8GB file took 7:25 to write (including the sync), which
> averages out to 18+MB/s. Which is, as far as I can tell, about the best I
> can get on this 5400RPM 80GB drive with the current IDE driver (the
> experimental IDE driver is supposed to do better, but that's not for
> 2.4.x)
> 
> An added advantage of doing the waiting in the request handling was that
> this way it automatically balances reads against writes - writes cannot
> cause reads to fail because they have separate request queue allocations.
> 
> Does it work reasonably under your loads?

Well, the freepages_high change needs more work.

Normal allocations are not going to easily "fall down" to lower zones
because the high zones will be kept at freepages.high most of the time.


