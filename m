Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSLOMit>; Sun, 15 Dec 2002 07:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbSLOMis>; Sun, 15 Dec 2002 07:38:48 -0500
Received: from [81.2.122.30] ([81.2.122.30]:27397 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266460AbSLOMir>;
	Sun, 15 Dec 2002 07:38:47 -0500
From: John Bradford <john@bradfords.org.uk>
Message-Id: <200212151258.gBFCwEDZ000672@darkstar.example.net>
Subject: Re: Symlink indirection
To: andrew@walrond.org (Andrew Walrond)
Date: Sun, 15 Dec 2002 12:58:14 +0000 (GMT)
Cc: junkio@cox.net, linux-kernel@vger.kernel.org
In-Reply-To: <3DFC72E4.30400@walrond.org> from "Andrew Walrond" at Dec 15, 2002 12:17:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "AW" == Andrew Walrond <andrew@walrond.org> gives an example of
> > a/{x,y,z}, b/{y,z}, c/z mounted on d/. in that order, later
> > mounts covering the earlier ones.
> > 
> > AW> echo "d/w" > d/w would create a new file in directory a.

I disagree.  It should create it in directory d, even though that is
the mount point.

A union mount should include files from another directory, but writes
should go to the actual named directory.

> > Back to your example; what do you wish to happen when we do
> > this?
> > 
> >     $ mv d/z d/zz && test -f d/z && cat d/z
> > 
> > Here we rename d/z (which is really c/z) to zz.  Does this
> > reveal z that used to be hidden by that, namely b/z, and "cat
> > d/z" now shows "b/z"?
> 
> Yes - exactly

Union mounts should be read only.

If read-write union mounts are needed, I don't think that we should
implement them significantly differently to the way they work in BSD.

John.
