Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRIBRo7>; Sun, 2 Sep 2001 13:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRIBRot>; Sun, 2 Sep 2001 13:44:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:64786 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266559AbRIBRoi>; Sun, 2 Sep 2001 13:44:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Samium Gromoff <_deepfire@mail.ru>
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
Date: Sun, 2 Sep 2001 19:51:50 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109022146.f82LkS904034@-f>
In-Reply-To: <200109022146.f82LkS904034@-f>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902174454Z16091-32383+3013@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 11:46 pm, Samium Gromoff wrote:
> Daniel Phillips wrote:
> > > One thing that goes away with rmaps is the need to scan process page tables.
> > It's possible that this takes enough load off L1 cache to produce the effects
>
>     I feel like that. 
>     actually there was a fear that the overhead of reverse map maintenance
>  will overthrow the gain on low loads, but in my case this isnt an issue.

Rik's patch can be optimized a lot by using a direct pointer to the pte in the
nonshared case, and perhaps a null rmap pointer in the kernel-only case (e.g.,
page cache).  If the non-optimized version is already performing better than the
traditional approach it's a very good sign.  This needs careful confirmation.

Measurements where you force your system into continuous swapping would be very
interesting.

--
Daniel
