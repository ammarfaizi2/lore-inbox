Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTA0X2w>; Mon, 27 Jan 2003 18:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTA0X2w>; Mon, 27 Jan 2003 18:28:52 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:49873 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S264631AbTA0X2t>; Mon, 27 Jan 2003 18:28:49 -0500
Date: Mon, 27 Jan 2003 15:37:54 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127233754.GR20972@ca-server1.us.oracle.com>
References: <20030127221523.GP20972@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301271648360.18686-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301271648360.18686-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 05:08:50PM -0600, Kai Germaschewski wrote:
> Well, I suppose arguing about that without a concrete example is kinda 
> pointless.

	Fair enough.
 
> You ignored the fact that I said you will be able to use separate
> src/objdir, which means you can have your source read-only.

	Yes.  That still doesn't change the fact that in 2.4 I need the
headers.  In 2.5 I need all 200MB of source + 60MB per different .config
of built tree.  And that's per user using that source.

> Yes, all you really need is the checksums. Then again, you also want a way 
> to verify a way that the checksums match the ABI as determined by the 
> current .config. I mean, just using the previously recorded checksums 
> without verifying is kinda pointless, they'll just always match and not 
> fulfill their function.

	You'd obviously have to have a way in the readonly /usr/src bits
to make sure that autoconf.h and the checksums match.  That would have
to be enforced (as Red Hat does now with their method).

> Yup, I now looked into what Redhat does. It's an obvious sign that there
> is work to be done, in particular making the build system work in a way
> that vendors don't need to kludge around it would definitely be nice.

	Maybe a way to track the differnet builds.  I'm not sure.  But
say you had a way of keeping multiple autoconf.h files in a tree.  If
the kernel sources could be smart enough to figure out the version.h and
modversions locations from that path, then you could have an external
module create a kbuild makefile for itself and run something like:

make KERN_CONF=/usr/src/linux-2.6.1/include/autoconf/build-smp/autoconf.h modules

where kbuild figures out from KERN_CONF that modversions stuff is in
autoconf/buid-smp/modversions/ and version.h is in
autoconf/build-smp/version.h, etc.  Something like that (I can beef with
this example, so no one tell me exactly why this specific example is bad
:-)

> which needs serious thinking and improvement. However, I think I need to
> finish the current work first, i.e. make sure the module versions actually
> work and then the separate obj / src dir stuff.

	Yes, I understand that there are priorities.
 
Joel

-- 

"The cynics are right nine times out of ten."  
        - H. L. Mencken

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
