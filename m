Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTGBQpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTGBQpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:45:05 -0400
Received: from [213.39.233.138] ([213.39.233.138]:36267 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264156AbTGBQow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:44:52 -0400
Date: Wed, 2 Jul 2003 18:59:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: linux-kernel@vger.kernel.org, Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH RFC] 2.5.73 zlib #2 codefold
Message-ID: <20030702165900.GB12520@wohnheim.fh-wedel.de>
References: <20030701161637.GC25363@wohnheim.fh-wedel.de> <IGEFJKJNHJDCBKALBJLLIEODFNAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IGEFJKJNHJDCBKALBJLLIEODFNAA.joakim.tjernlund@lumentis.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 July 2003 10:46:05 +0200, Joakim Tjernlund wrote:
> 
> > This patch folds three calls to memmove_update into one.  This is the
> > same structure that was in the 1.1.3 version of the zlib as well.  The
> > change towards 1.1.4 was mixed with a real bugfix, so it slipped
> > through my brain.
> >
> [SNIP]
> 
> Looks fine to me.
> 
> Here is another one in gen_bitlen():
> Replace:
>   for (bits = 0; bits <= MAX_BITS; bits++) s->bl_count[bits] = 0;
> with:
>   memset(&s->bl_count[0], 0, MAX_BITS * sizeof(s->bl_count[0]));
> 
> Also the following could should be replaced(in defutil.h):
> /* ===========================================================================
>  * Reverse the first len bits of a code, using straightforward code (a faster
>  * method would use a table)
>  * IN assertion: 1 <= len <= 15
>  */
> static inline unsigned bi_reverse(unsigned code, /* the value to invert */
> 				  int len)       /* its bit length */
> {
>     register unsigned res = 0;
>     do {
>         res |= code & 1;
>         code >>= 1, res <<= 1;
>     } while (--len > 0);
>     return res >> 1;
> }
> 
> Anybody have a table version handy?

Onto my unwritten todo list with them.  The next lazy afternoon will
come for sure.

Etiennes code sounds promising as well.  Will have a closer look one
of those afternoons.  If it does fit the description, it might be a
good alternative for those platforms it happens to run on.

On a whole, I think it is better to leave most changes out of
mainline until 2.7 is opened.  At least, unless someone comes up with
an extensive test suite for correctness, throughput and interactivity.
Volunteers? ;)

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
