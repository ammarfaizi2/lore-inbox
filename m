Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSHBUqE>; Fri, 2 Aug 2002 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSHBUqE>; Fri, 2 Aug 2002 16:46:04 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:30219 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316935AbSHBUqD>;
	Fri, 2 Aug 2002 16:46:03 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208022049.g72KnHj453650@saturn.cs.uml.edu>
Subject: Re: 2.5.28 and partitions
To: miket@bluemug.com (Mike Touloumtzis)
Date: Fri, 2 Aug 2002 16:49:17 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       viro@math.psu.edu (Alexander Viro),
       thunder@ngforever.de (Thunder from the hill),
       peter@chubb.wattle.id.au (Peter Chubb), pavel@ucw.cz (Pavel Machek),
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020802194701.GB4528@bluemug.com> from "Mike Touloumtzis" at Aug 02, 2002 12:47:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Touloumtzis writes:
> On Thu, Aug 01, 2002 at 05:24:37PM -0400, Albert D. Cahalan wrote:

>> There's just that little overflow problem to worry about,
>
> Ummm:
>
> -- stuff ASCII digits into u64 (or u32, or whatever)
> -- if (still more digits)
>    -- printk("partition too big to mount!\n")
>    -- return error
>
> How hard is that?

I refer to overflowing the space allowed for your
partition table. Programs will generate the data,
then write it out. If the data gets too long, then
you overwrite part of your first filesystem.
Alternately, the partition table gets truncated
at the maximum size -- with or without a '\0'.

But sure, overflowing a u64 is also a problem.
This will not be checked for. Either the u64 will
get overflowed, or the parser will take what fits
and then mis-interpret the remaining digits as
a second number.

>> trailing garbage,
>
> Don't write garbage into your partition table.

I can see multiple ways for this to happen.
Take the length of the new data, with or without
the trailing '\0', and write it out. Write the
whole partition table, including uninitialized
data that happens to be in memory. (some other
program will of course not ignore trailing garbage)

>> encouragement of assumptions about the maximum size...
>> is that a %d or a %llu or what?
>
> See above.  Use leading '-' for negative numbers.  ASCII has no
> 2's complement ambiguity issues.

You've got to stuff it into something eventually,
unless you want to implement ASCII math. Will you
be using plain C, or C++ operator overloading?

Yeah, just what we need. The /proc mess expanding
into partition tables. That sounds like a great way
to increase filesystem destruction performance.


