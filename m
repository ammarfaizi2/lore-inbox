Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSHETDc>; Mon, 5 Aug 2002 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318841AbSHETDc>; Mon, 5 Aug 2002 15:03:32 -0400
Received: from unthought.net ([212.97.129.24]:19895 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S318838AbSHETDb>;
	Mon, 5 Aug 2002 15:03:31 -0400
Date: Mon, 5 Aug 2002 21:07:06 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk (block) write strangeness
Message-ID: <20020805190706.GD2671@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20020805184921.GC2671@unthought.net> <1028578632.18156.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1028578632.18156.71.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 09:17:12PM +0100, Alan Cox wrote:
> On Mon, 2002-08-05 at 19:49, Jakob Oestergaard wrote:
> > *) Either the disk writes backwards  (no I don't believe that)
> > *) Or the kernel is writing 256 B blocks (AFAIK it can't)
> > *) The disk has some internal magic that cause a power-loss during
> >    a full block write to leave the first half of the block intact with
> >    old data, and update the second half of a block correctly with new
> >    data.  (And I don't believe that either).
> 
> You forgot to add
> 
> *) or the disk internal logic bears no resemblance to the antiquated API
> it fakes for the convenience of interface hardware and software

Fair enough - that seems like a reasonable explanation.

On a side note - what guarantees does one have ?  Any pointers to papers
or other material about this ?

For example, when updating a 3 to a 4 on the disk, could I end up with a
7 ?    (having 00000011 on platter, starting write of 00000100, but
after having written the one high power fails and I now have 00000111).

The above example is simple - I doubt that it would happen - but how
much can and cannot happen ?   I bet the Phase Tree (Tux2) people must
have thought about this at some point...  I haven't had much luck with
Google on this one...

> 
> Linux also won't neccessarily do write outs in order. 

But in this case, I wonder why ?

It's one huge sequential write, from the beginning of a device and 50 MB
onwards.  The write is submitted in one single write() every single
time.   Why start going semi-backwards and chopping things up ?

I'm *very* certain that Linux does this non-sequentially, because the
disk might be causing the half-block oddity which really surprised me,
but the disk is not caching 20 MB of data internally, for sure.

Is this an elevator deficiency in 2.4.18, or am I just moaning for no
reason at all ?    ;)

Thanks for the quick reply !

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
