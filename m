Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283434AbRLCXqU>; Mon, 3 Dec 2001 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282236AbRLCXkk>; Mon, 3 Dec 2001 18:40:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36105 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S284774AbRLCQhR>; Mon, 3 Dec 2001 11:37:17 -0500
Date: Mon, 3 Dec 2001 11:30:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
In-Reply-To: <UTC200112011147.LAA114060.aeb@cwi.nl>
Message-ID: <Pine.LNX.3.96.1011203111501.21357B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001 Andries.Brouwer@cwi.nl wrote:

> The present /proc/partitions has minimal content.
> Its only function is to report to user space which block devices
> are known to the kernel. User space is unable to figure that out
> on its own without an unreasonable amount of probing.
> 
> But once you know what devices exist, it is very easy for user space
> to report all desired properties of these devices.
> Do you want starting sector and size of /dev/hde4?
> 
> # hdparm -g /dev/hde4
> 
> /dev/hde4:
>  geometry     = 70780/16/63, sectors = 1670760, start = 69673905

Really? Do you run hdparm setuid root or allow read access of hde? In any
case, allowing easy access from user space via hdparm trickes me as a
major security issue. The geometry is in /proc/ide/hd?/geometry, but the
other info is not readily available to other than root user in most
systems. I think his intention was to make it more generally available. I
don't see any reason to require root to see this information, and I think
reducing the need for root is a good thing for security.

It would be highly desirable to define new proc data as subject to
addition of more information per line at any time, and as long as the
fields are added at the end of the line a parser can easily be written not
to break. As you note, changing existing information presents other
problems and will break things, since /proc/partitions was not defines as
extensible.

I personally would have no problem adding this to 2.5, lots of things will
change, but I agree that a change to 2.4 is not practical as a retrofit.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

