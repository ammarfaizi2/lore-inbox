Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVISSvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVISSvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVISSvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:51:06 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:23551 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932568AbVISSvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:51:05 -0400
Message-ID: <432F0890.7060802@namesys.com>
Date: Mon, 19 Sep 2005 11:50:56 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com>	 <200509171415.50454.vda@ilport.com.ua>	 <200509180934.50789.chriswhite@gentoo.org>	 <200509181321.23211.vda@ilport.com.ua>	 <20050918102658.GB22210@infradead.org>	 <b14e81f0050918102254146224@mail.gmail.com>	 <1127079524.8932.21.camel@localhost.localdomain>	 <432E4786.7010001@namesys.com> <1127126616.22124.7.camel@localhost.localdomain>
In-Reply-To: <1127126616.22124.7.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sul, 2005-09-18 at 22:07 -0700, Hans Reiser wrote:
>  
>
>>>the ability to fix some of those bugs fast, but we also all remember
>>>what happened with reiser3 later on despite early fast fixing.
>>> 
>>>
>>>      
>>>
>>What was that?
>>    
>>
>
>Jeff Mahoney added file attributes to reiserfs3, you whined and pointed
>people at the yet to be released reiserfs4.
>
If you benchmarked that code, you might understand why I "whined."  You
can't just create a file per directory and stuff the attributes in it
and expect good performance.  Let's not forget that there was no
documentation, no design document, no design review, no QA process.

It is always a judgment call to decide what should be deferred to the
next major release and what should go into a stable branch.  File
attributes are a significant portion of the bugs that V3 has had.  File
attributes got added so that a marketer would have a bullet point added,
which can be very important and I am genuinely eager to work hard to
make marketers happy, but to the extent I get to decide, it will never
happen at the cost of coding it the wrong way.

Jeff is a great guy, and his bitmap related code is great stuff with
good design and solid empirical work behind it.  You have to really
understand the difference between V3 and V4 to appreciate that it was
not feasible for him to code xattrs for V3 the right way, because it
would be a disk format change and a nightmare to do it.  The code was
doomed by V3's lack of plugins before it was even written.  There is a
reason why V4 came into being....

If added to V4, xattrs would be higher performance and cleaner to
implement.  It would be far better to have spent the programming effort
on adding them to V4 and getting V4 out a little sooner.

I won't convince you of this one but it is also my reason: They are
inelegant semantics.

I don't remember the details of the 4k stack and journaling issues you
describe, so I will say nothing.

