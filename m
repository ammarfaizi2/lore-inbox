Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271665AbRIGKRQ>; Fri, 7 Sep 2001 06:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271673AbRIGKRG>; Fri, 7 Sep 2001 06:17:06 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16399 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271665AbRIGKQu>; Fri, 7 Sep 2001 06:16:50 -0400
Message-ID: <3B989E46.51C1E768@idb.hist.no>
Date: Fri, 07 Sep 2001 12:15:34 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: page pre-swapping + moving it on cache-list
In-Reply-To: <Pine.LNX.4.33L.0109061003320.31200-100000@imladris.rielhome.con ectiva>
	 <591984348.999786074@[10.132.112.53]> <p05100300b7bd3bf9bf7a@[10.128.7.49]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:

> The problem with thrashing, is it not, is that we're not making
> forward progress because we're waiting for swap--that is to say,
> thrashing *is* an idle state of sorts, and so might be an ideal
> opportunity for gc methods that require heavy CPU involvement. It's
> not as if there's anything better to do....

Note that trashing don't necessarily mean the cpu is free.
It can be very busy:
- deciding what to swap out next
- queuing stuff up for io, merging long elevator queues
- handling io operations, we don't all have busmastering devices

somehow I don't think garbage collection runs will be that fun
in a trashing situation.  Don't these algorithms look all over
your stack & heap for pointers?  That will surely cause lots
of io as all the apps memory is paged in so the gc algorithm
may look at it.  

Helge Hafting
