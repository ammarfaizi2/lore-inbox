Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284176AbRLAR6G>; Sat, 1 Dec 2001 12:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284179AbRLAR54>; Sat, 1 Dec 2001 12:57:56 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:44004 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284176AbRLAR5g>; Sat, 1 Dec 2001 12:57:36 -0500
Date: Sat, 1 Dec 2001 20:02:25 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: [PATCH] if (foo) kfree(foo) /fs cleanup + reverted JBD code path
 changes
In-Reply-To: <420365759.1007228406@[195.224.237.69]>
Message-ID: <Pine.LNX.4.33.0112011950070.14914-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You present some good arguments against the patch, i did it initially to
remove the double check and i would think the most common path would be a
kfree in any case (I can't back this up with proof) so its not that
expensive, so instead of;

if (foo) {
	kfree(foo);
	foo = NULL;
}
frob();

we can /* as whoever wrote kfree intended */

kfree(foo);
foo = NULL;
frob();

I would think in any case if we were looking at optimisation, the
assignment is roughly on par with the compare and saves you a bit on the
other case.

Alan Cox also suggested the BUG() trigger in there, with the
resultant breakage that would bring about. But i think its ok as long as
you don't call kfree with uninitialised variables or some such or forget
to set them to NULL at some point.

Thanks,
	Zwane Mwaikambo


