Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVGMNru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVGMNru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 09:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVGMNru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 09:47:50 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:57507 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262638AbVGMNre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 09:47:34 -0400
Date: Wed, 13 Jul 2005 15:47:30 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Vara Prasad <prasadav@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: Re: Merging relayfs?
In-Reply-To: <42D498AF.5070401@us.ibm.com>
Message-ID: <Pine.BSO.4.62.0507131440480.6919@rudy.mif.pg.gda.pl>
References: <17107.6290.734560.231978@tut.ibm.com>
 <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com>
 <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com>
 <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <42D498AF.5070401@us.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2053870955-1121262011=:6919"
Content-ID: <Pine.BSO.4.62.0507131540430.6919@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2053870955-1121262011=:6919
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0507131540431.6919@rudy.mif.pg.gda.pl>

On Tue, 12 Jul 2005, Vara Prasad wrote:
[..]
> O.K, Tomasz your point is we can do aggregation in the kernel and cut down 
> the amount of data that needs to be sent out from the kernel hence we don't 
> need an efficient, low overhead mechanism like relayfs to get the data out of 
> the kernel. Having relayfs doesn't prevent someone in aggregating the data in 
> the kernel, so it is not an argument for not including relayfs in the kernel 
> when it fills the need for those who needs raw data.

Of course you are right and (look again) this is what I told in first mail 
in this thread :)

> I am part of a team working on systemtap where we are are developing a tool
> similar to Dtrace that does some aggregation where appropriate but nothing 
> like fancy statistics etc. We use relayfs in our systemtap project and  based 
> on my reading of Dtrace paper they use exactly similar to relayfs buffering 
> mechanism as well.

If I can suggest something about order prepare some feactures:

1) prepare base infrastructure for counters,

this "tool" will take very small amount of data and can be performad
by very small pieces of binary codes. Even this will allow perform some
*very* interesting experinments on existing kernel code.
And after above:

2) prepare base infrastructure for association tables of couters (for
    collecting data for example about I/O operations or other two or more
    arguments operations),
3) prepare user space tool with some kind of language which will allow
    hanging ptrobes with aboove tho (simple counters and association tables
    of couters)
4) base functions for measure time (with KProbes overhead and without) and
    store them in couters and association tables,

All above base "tools" for above will take small or medium amount of data 
and can be performad small or medium pieces of binary codes. And after 
above:

5) prepare infrastrucrute for probes which will store data in diffrent
    containers depending on initiator process and/or thread (and maybe in
    next etap also will be good have something more common which will
    depend on stack path),
6) prepare base functions for tracing stack paths (counting them and store
    in association tables),
7) make some kind of study where is it will be good compute something
    more complicated like base "speculative probes" (lookin on
    working DTrace probably answer in this point will be "yes").

All to this moment will not require relayfs because amount of transfered
data will be _very low_.
Details of above will be probably different (I have only some very 
common knowledge about DTrace implementations details and some avarange 
about using dtrace tool) but I want count/pint *only* feactutres which 
will not require using relayfs.

And *after finish above* will be much easier perform some kind of study 
about "is relayfs is still neccessary ?" and *if* answer will be still 
"YES" try to integrate neccessary patches (or maybe something other .. 
maybe better adjusted to all non-above cases). Also add something like 
relayfs at this moment _will not require_ changes in existing code (if 
will require changes will be very small but maybe will ollow reduce 
existin now relayfs (?)).

But if you will build all infrastructure even for simple couters on 
relayfs fundament it will be (IMO) badly/incorrectly designed .. and using
even simple couters will introduce to high overhead for system.

*NOT using realyfs* if it is not neccessary for possibly big amout 
of feactures future KProbes IMO in this case is *fundamental*.

To time where this base not requiring relayfs feactures will not be
integrated in kernel code better IMO will be stop merging relayfs.

> There are tools like itrace and Intel has one (i forgot the name) they would 
> like to get the raw data into user space and do all kinds of  fancy 
> statistical analysis, visualization etc. Their value add is the analysis of 
> the data. I am sure you are not suggesting pushing capabilities of those 
> tools to the kernel, right.

I don't know any thing about this tool (can you sent URL?) but please ..
dont't be fool and do not try as first prepare something eye candy :)
Rest this area for other developers and focus on fundaments :)

regards

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-2053870955-1121262011=:6919--
