Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264804AbSJVSAO>; Tue, 22 Oct 2002 14:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJVR75>; Tue, 22 Oct 2002 13:59:57 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:42132 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261784AbSJVR6X> convert rfc822-to-8bit; Tue, 22 Oct 2002 13:58:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Tim Hockin <thockin@sun.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Date: Tue, 22 Oct 2002 13:03:47 -0500
User-Agent: KMail/1.4.1
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <1035308740.31873.107.camel@irongate.swansea.linux.org.uk> <3DB58CBD.3030207@sun.com>
In-Reply-To: <3DB58CBD.3030207@sun.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210221303.47488.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 12:37 pm, Tim Hockin wrote:
> Alan Cox wrote:
> > On Tue, 2002-10-22 at 18:26, Tim Hockin wrote:
> >>Alan Cox wrote:
> >>>Ok sanity check time. Why do you need qsort and bsearch for this kind of
> >>>thing. Just how many groups do you plan to support ?
> >>
> >>Unlimited - we've tested with tens of thousands.
> >
> > Now how about the real world requirements ?
>
> Those were real world requirements - we got the number 10,000 from our
> product management, which (presumably) spoke with customers.  On the
> hosting systems, it is really possible to have thousands of virtual sites.
>
> Now, I don't much care if you want it to be a linear search, and I'll
> revert it, if needed, but qsort() is already in in XFS specific code,
> and bsearch is small.  It doesn't negatively impact any fast path, and
> provides better behavior for the crazies that really want 10,000 groups.
>
> Tim

Does it actually work with NFS???? or any networked file system?
Most of them limit ngroups to 16 to 32, and cannot send any data
if there is an overflow, since that overflow would replace all of the
data you try to send/recieve...

And I really doubt that anybody has 10000 unique groups (or even
close to that) running under any system. The center I'm at has
some of the largest UNIX systems ever made, and there are only
about 600 unique groups over the entire center. The largest number
of groups a user can be in is 32. And nobody even comes close.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
