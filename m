Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbRGUAxF>; Fri, 20 Jul 2001 20:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbRGUAwz>; Fri, 20 Jul 2001 20:52:55 -0400
Received: from suntan.tandem.com ([192.216.221.8]:59824 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S267494AbRGUAwn>; Fri, 20 Jul 2001 20:52:43 -0400
Message-ID: <3B58CBA3.BD2C194@compaq.com>
Date: Fri, 20 Jul 2001 17:24:03 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>, Larry McVoy <lm@bitmover.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation
In-Reply-To: <01071815464209.12129@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips wrote:
> 
> On Wednesday 18 July 2001 03:34, Larry McVoy wrote:
> > We've got a fairly nice hash table interface in BitKeeper that we'd
> > be happy to provide under the GPL.  I've always thought it would be
> > cool to have it in the kernel, we use it everywhere.
> >
> > http://bitmover.com:8888//home/bk/bugfixes/src/src/mdbm

Thanks, Larry. Your hashing functions are much more sophisticated than
the simple modulo operator I've been using for hashing by inode
number.


> I think the original poster was thinking more along the lines of a
> generic insertion, deletion and lookup interface, which we are now
> doing in an almost-generic way in a few places.  Once place that is
> distinctly un-generic is the buffer hash, for no good reason that I
> can see.  This would be a good starting point for a demonstration.
> 

Daniel's correct. I'm hashing function agnostic, but would like some
common code to simplify the management of a hash table.

Richard Guenther sent the following link to his own common hashing
code, which makes nice use of pseudo-templates:

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/~checkout~/glame/glame/src/include/hash.h?rev=1.5&content-type=text/plain

A few things I would consider changing are:

  - ditching the pprev pointer
  - encapsulating the next pointer inside a struct hash_head_##FOOBAR
  - stripping out the hard-coded hashing function, and allowing the
    user to provide their own

All the backslashes offend my aesthetic sensibility, but the
preprocessor provides no alternative. ;)


-- 
Brian Watson                 | "The common people of England... so 
Linux Kernel Developer       |  jealous of their liberty, but like the 
Open SSI Clustering Project  |  common people of most other countries 
Compaq Computer Corp         |  never rightly considering wherein it 
Los Angeles, CA              |  consists..."
                             |      -Adam Smith, Wealth of Nations,
1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
