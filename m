Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSGWWzw>; Tue, 23 Jul 2002 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSGWWzv>; Tue, 23 Jul 2002 18:55:51 -0400
Received: from pool-129-44-58-21.ny325.east.verizon.net ([129.44.58.21]:60680
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S318240AbSGWWzs>; Tue, 23 Jul 2002 18:55:48 -0400
Date: Tue, 23 Jul 2002 18:58:52 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
Message-ID: <20020723185852.A12295@arizona.localdomain>
References: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Tue, Jul 23, 2002 at 09:28:26PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:28:26PM +1000, Neil Brown wrote:
> However it doesn't do any type checking on the pointer, and you can 
> give it a pointer to something else... just as I did in line 850 of
> md/md.c :-(

Hi Neil,

I've experienced the same problem with some of my own code.  I came up with
the following macro to help solve the problem:

/* Given a pointer to a member of a struct, return a pointer to the struct
   itself. */
#define BackPtr(ptr, type, member) ({                                         \
        typeof( ((type *)0)->member ) *__mptr = (ptr);                        \
        ((type *)( (char *)__mptr - (unsigned long)(&((type *)0)->member) ));})

> So I thought I would add some type checking to list_entry so that
> you have to pass it a "struct list_head *", but I then discovered that
> lots of places are using list_entry to do creative casting on
> all sorts of other things like inodes embedded in bigger structures
> and so on.
> 
> So... I have created "generic_out_cast" which is like the old
> list_entry but with an extra type arguement.

I don't think this is necessary.  The compiler can get this information
from the type/member parameters and the typeof() call.

> Why "out_cast"???

Ugh..  I had a similar naming dilemma - I choose BackPtr (because the
macro causes a negative pointer offset).

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
