Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVHCEKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVHCEKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 00:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVHCEKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 00:10:51 -0400
Received: from smtpout.mac.com ([17.250.248.45]:14292 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262040AbVHCEJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 00:09:46 -0400
In-Reply-To: <42F01712.2030105@namesys.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0508021655580.4138@yvahk01.tjqt.qr> <1122994972.3247.31.camel@laptopd505.fenrus.org> <42F01712.2030105@namesys.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4CBCB111-36B9-4F8C-9A3F-A9126ADE1CA2@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 00/14] GFS
Date: Wed, 3 Aug 2005 00:07:38 -0400
To: Hans Reiser <reiser@namesys.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 2, 2005, at 21:00:02, Hans Reiser wrote:
> Arjan van de Ven wrote:
>> because reiser got merged before jbd. Next question.
> That is the wrong reason.  We use our own journaling layer for the
> reason that Vivaldi used his own melody.
>
> I don't know anything about GFS, but expecting a filesystem author to
> use a journaling layer he does not want to is a bit arrogant.  Now, if
> you got into details, and said jbd does X, Y and Z, and GFS does the
> same X and Y, and does not do Z as well as jbd, that would be a more
> serious comment.  He might want to look at how reiser4 does wandering
> logs instead of using jbd..... but I would never claim that for sure
> some other author should be expected to use it.....  and something  
> like
> changing one's journaling system is not something to do just before a
> merge.....

I don't want to start another big reiser4 flamewar, but...

"I don't know anything about Reiser4, but expecting a filesystem author
to use a VFS layer he does not want to is a bit arrogant.  Now, if you
got into details, and said the linux VFS does X, Y, and Z, and Reiser4
does..."

Do you see my point here?  If every person who added new kernel code
just wrote their own thing without checking to see if it had already
been done before, then there would be a lot of poorly maintained code
in the kernel.  If a journalling layer already exists, _new_ journaled
filesystems should either (A) use the layer as is, or (B) fix the layer
so it has sufficient functionality for them to use, and submit patches.
That way if somebody later says, "Ah, crap, there's a bug in the kernel
journalling layer", and fixes it, there are not eight other filesystems
with their own open-coded layers that need to be audited for similar
mistakes.

This is similar to why some kernel developers did not like the Reiser4
code, because it implemented some private layers that looked kinda like
stuff the VFS should be doing  (Again, I don't want to get into that
argument again, I'm just bringing up the similarities to clarify _this_
particular point, as that one has been beaten to death enough already).

>> Now the question for GFS is still a valid one; there might be  
>> reasons to
>> not use it (which is fair enough) but if there's no real reason then
>> using jdb sounds a lot better given it's maturity (and it is used  
>> by 2
>> filesystems in -mm already).

Personally, I am of the opinion that if GFS cannot use jdb, the  
developers
ought to clarify why it isn't useable, and possibly submit fixes to make
it useful, so that others can share the benefits.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at
people who weren't supposed to be in your machine room.
   -- Anthony de Boer


