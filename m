Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269265AbSIRTO6>; Wed, 18 Sep 2002 15:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269269AbSIRTO6>; Wed, 18 Sep 2002 15:14:58 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:14534 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id <S269265AbSIRTO6>; Wed, 18 Sep 2002 15:14:58 -0400
Subject: Re: [PATCH] recognize MAP_LOCKED in mmap() call
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, owner-linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC0C42F8D.E1325D58-ON86256C38.00695CD8@hou.us.ray.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 18 Sep 2002 14:18:05 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 5.0.10 |March 22, 2002) at
 09/18/2002 02:18:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
>(SuS really only anticipates that mmap needs to look at prior mlocks
>in force against the address range.  It also says
>
>     Process memory locking does apply to shared memory regions,
>
>and we don't do that either.  I think we should; can't see why SuS
>requires this.)

Let me make sure I read what you said correctly. Does this mean that Linux
2.4 (or 2.5) kernels do not lock shared memory regions if a process uses
mlockall?

If not, that is *really bad* for our real time applications. We don't want
to take a page fault while running some 80hz task, just because some
non-real time application tried to use what little physical memory we allow
for the kernel and all other applications.

I asked a related question about a week ago on linux-mm and didn't get a
response. Basically, I was concerned that top did not show RSS == Size when
mlockall(MCL_CURRENT|MCL_FUTURE) was called. Could this explain the
difference or is there something else that I'm missing here?

Thanks.
--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>



