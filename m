Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271761AbRH0P6G>; Mon, 27 Aug 2001 11:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271764AbRH0P55>; Mon, 27 Aug 2001 11:57:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:3337 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271761AbRH0P5v>; Mon, 27 Aug 2001 11:57:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 18:04:42 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827155800Z16272-32383+1657@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 05:14 pm, Rik van Riel wrote:
> On Mon, 27 Aug 2001, Alex Bligh - linux-kernel wrote:
> 
> > A nit: I think it's a MRU list you want.
> 
> Absolutely, however ...
> 
> > If you are reading
> > ahead (let's have caps for a page that has been used for reading,
> > as well as read from the disk, and lowercase for read-ahead that
> > has not been used):
> > 	ABCDefghijklmnopq
> >              |            |
> >             read         disk
> > 	   ptr          head
> > and you want to reclaim memory, you want to drop (say) 'pq'
> > to get
> > 	ABCDefghijklmno
> > for two reasons: firstly because 'efg' etc. are most likely
> > to be used NEXT, and secondly because the diskhead is nearer
> > 'pq' when you (inevitably) have to read it again.
> 
> This is NOT MRU, since p and q have not been used yet.
> In this example you really want to drop D and C instead.

What we mean by "drop" is "deactivate".

--
Daniel
