Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268178AbTBWMTL>; Sun, 23 Feb 2003 07:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbTBWMTL>; Sun, 23 Feb 2003 07:19:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30912 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S268178AbTBWMTK>; Sun, 23 Feb 2003 07:19:10 -0500
Date: Sun, 23 Feb 2003 12:31:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elapsed times wrap
In-Reply-To: <Pine.LNX.4.44.0302221600540.14516-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0302231215330.2386-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Kai Germaschewski wrote:
> On Sat, 22 Feb 2003, Hugh Dickins wrote:
> 
> > Userspace shows huge elapsed time across jiffies wrap: with USER_HZ
> > less then HZ, sys_times needs jiffies_64 to calculate its retval.
> 
> That makes me wonder, aren't all uses of jiffies_to_clock_t() broken then? 

I believe you're right, but it's less obvious to me that the
other uses really want fixing e.g. would we be happy to maintain
utime,stime,cutime,cstime as 64-bit on a 32-bit machine?

> Well, all which take an absolute time as an argument at least.

Yes, it's much more important to fix those where userspace habitually
takes the difference.  That certainly applies to the return value from
sys_times, but I don't see any other cases as clear (though userspace
may have good reason to take the difference of any of them).

Perhaps a procps expert can advise?

Hugh

