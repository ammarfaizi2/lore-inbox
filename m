Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280081AbRJaFiB>; Wed, 31 Oct 2001 00:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280083AbRJaFhv>; Wed, 31 Oct 2001 00:37:51 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:31108 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S280081AbRJaFhk>;
	Wed, 31 Oct 2001 00:37:40 -0500
Date: Tue, 30 Oct 2001 11:07:13 -0500
From: Theodore Tso <tytso@mit.edu>
To: Oliver Xymoron <oxymoron@waste.org>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011030110713.A583@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Oliver Xymoron <oxymoron@waste.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011029163920.F806@lynx.no> <Pine.LNX.4.30.0110291814100.30096-100000@waste.org> <20011029205005.L806@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011029205005.L806@lynx.no>; from adilger@turbolabs.com on Mon, Oct 29, 2001 at 08:50:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 08:50:05PM -0700, Andreas Dilger wrote:
> 
> Well, I just saw that the "in++" and "nwords * 4" patches went into -pre4.
> These are the only real non-cosmetic parts of what has been sent.  The
> other patches were not officially submitted to Linus yet (using bytes
> as parameters, and removing poolwords from the struct).  I have reverted
> those patches in my tree, and gone back to using words as units for
> add_entropy(), since it doesn't make sense to take bytes as a parameter
> and then require a multiple of 4 bytes for input sizes.

Oops, ouch.  Thanks for catching the in++ bug; I can't believe that
remained unnoticed for so long.  

Could you send me a pointer to the proposed change to remove poolwords
from the struct?  I'm not sure why that wwould be a good thing at all.

Also, the reason why add_entropy_words did stuff in multiple of 4
bytes was simply because it made the code much more efficient.
Zero-padding isn't a problem, since it's perfectly safe to mix in zero
bytes into the pool.  It is an issue for the entropy credit
calculation, but that's completely separate from add_entropy_words()....

						- Ted
