Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUG0F43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUG0F43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUG0F43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:56:29 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:24243 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S265398AbUG0Fzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:55:52 -0400
From: Daniel Phillips <phillips@istop.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Tue, 27 Jul 2004 01:57:50 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, lmb@suse.de, arjanv@redhat.com,
       sdake@mvista.com, teigland@redhat.com, linux-kernel@vger.kernel.org
References: <1089501890.19787.33.camel@persist.az.mvista.com> <200407262331.44176.phillips@istop.com> <4105D511.9030207@yahoo.com.au>
In-Reply-To: <4105D511.9030207@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407270157.50378.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 00:07, Nick Piggin wrote:
> But a PF_MEMALLOC userspace task is still useful.

Absolutely.  This is the route I'm taking, and I just use an ioctl to flip the 
task bit as I mentioned (much) earlier.  It still needs to be beaten up in 
practice.  The cluster snapshot block device, which has a relatively complex 
userspace server, should be a nice test case.

> >The PF_MEMALLOC flag is inherited down a call chain, not across a pipe or
> >similar IPC to user space.
>
> This is no different in kernel of course.

I was talking about in-kernel.  Once we let the PF_MEMALLOC state escape to 
user space, things start looking brighter.  But you still have to invoke that 
userspace code somehow, and there is no direct way to do it, hence 
PF_MEMALLOC isn't inherited.  An easy solution is to have a userspace daemon 
that's always in PF_MEMALLOC state, as Andrew mentioned, which we can control 
via a pipe or similar.

> You would have to think about 
> which threads need the flag and which do not. Even better, you might
> aquire and drop the flag only when required.

Yes, that's what the ioctl is about.  However, this doesn't work for servicing 
writeout.

> I can't see any obvious problems you would run into.

;-)

Regards,

Daniel
