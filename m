Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbTBFWst>; Thu, 6 Feb 2003 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbTBFWst>; Thu, 6 Feb 2003 17:48:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:49817 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267684AbTBFWsr>; Thu, 6 Feb 2003 17:48:47 -0500
Date: Thu, 06 Feb 2003 14:58:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc -O2 vs gcc -Os performance
Message-ID: <279800000.1044572300@[10.10.2.4]>
In-Reply-To: <b1uml3$2af$1@penguin.transmeta.com>
References: <336780000.1044313506@flay> <224770000.1044546145@[10.10.2.4]> <1044553691.10374.20.camel@irongate.swansea.linux.org.uk> <263740000.1044563891@[10.10.2.4]> <b1uml3$2af$1@penguin.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2901299 vmlinux.O2
>> 2667827 vmlinux.Os
> 
> Well, Os is certainly smaller.  

Yup. I have lots of RAM though, so unless I can see the perf increase
from cache effects, it's not desperately interesting to me personally.
If someone could do similar measurements with a puny-cache celeron chip, 
it would be interesting ... 

> So I suspect -Os tends to be more appropriate for user-mode code, and
> especially code with low repeat rates.  Possibly the "low repeat rate"
> thing ends up being true of certain kernel subsystems too.

Fair enough. I'm not desperately interested in user-land code at the
moment, personally, but gcc is admittedly more general. Maybe we should
compile gcc itself with -Os ;-) Andi (I think) also made the observation
that the garbage-collect size for gcc3.2 may be rather small.

The observation re low repeat rate is interesting ... might be amusing 
to do some really basic profile-guided optimisation on this grounds,
take readprofile / oprofile output, and compile the files that don't
get hammered at all with -Os rather than -O2. Given their low frequency
(by definition), I'm not sure that improving their icache footprint will
have a measureable effect though.

M.

