Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVGMP7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVGMP7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVGMP51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:57:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47780 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262983AbVGMP5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:57:00 -0400
Message-ID: <42D539BD.9060109@us.ibm.com>
Date: Wed, 13 Jul 2005 08:56:45 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com> <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com> <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl> <42D498AF.5070401@us.ibm.com> <Pine.BSO.4.62.0507131440480.6919@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0507131440480.6919@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:

> On Tue, 12 Jul 2005, Vara Prasad wrote:
> [..]
>
[..]

> If I can suggest something about order prepare some feactures:
>
> 1) prepare base infrastructure for counters,
>
> this "tool" will take very small amount of data and can be performad
> by very small pieces of binary codes. Even this will allow perform some
> *very* interesting experinments on existing kernel code.
> And after above:
>
> 2) prepare base infrastructure for association tables of couters (for
>    collecting data for example about I/O operations or other two or more
>    arguments operations),
> 3) prepare user space tool with some kind of language which will allow
>    hanging ptrobes with aboove tho (simple counters and association 
> tables
>    of couters)
> 4) base functions for measure time (with KProbes overhead and without) 
> and
>    store them in couters and association tables,
>
> All above base "tools" for above will take small or medium amount of 
> data and can be performad small or medium pieces of binary codes. And 
> after above:
>
> 5) prepare infrastrucrute for probes which will store data in diffrent
>    containers depending on initiator process and/or thread (and maybe in
>    next etap also will be good have something more common which will
>    depend on stack path),
> 6) prepare base functions for tracing stack paths (counting them and 
> store
>    in association tables),
> 7) make some kind of study where is it will be good compute something
>    more complicated like base "speculative probes" (lookin on
>    working DTrace probably answer in this point will be "yes").
>
Looks like you have not looked at systemtap project although Tom pointed 
about it to you in his previous postings.  The URL for systemtap is 
http://sourceware.org/systemtap/, i strongly suggest you to look at that 
project.  We are implementing most of the above what you are suggesting 
in the systemtap project. I don't agree with you that implementing the 
above features is trivial and takes small amount of code, can you submit 
patches to show the simple implementation you are talking about.

> All to this moment will not require relayfs because amount of transfered
> data will be _very low_.

I think you are forgetting the fact that relayfs has two different 
portions one is the buffering scheme another is the data transfer 
mechanism. Some of the above features you are talking of needs a 
buffering scheme.

> Details of above will be probably different (I have only some very 
> common knowledge about DTrace implementations details and some 
> avarange about using dtrace tool) but I want count/pint *only* 
> feactutres which will not require using relayfs.

I beg to differ, as i mentioned in my earlier postings Dtrace has a 
similar per-CPU buffering scheme according to their USENIX paper 
http://www.sun.com/bigadmin/content/dtrace/dtrace_usenix.pdf refer to 
section 3.3, can you explain why?

[...]

>
> But if you will build all infrastructure even for simple couters on 
> relayfs fundament it will be (IMO) badly/incorrectly designed .. and 
> using
> even simple couters will introduce to high overhead for system.

Do you have any performance data to justify your claim of high overhead?

[...]

>
>
> regards
>
> kloczek

bye,
Vara Prasad

