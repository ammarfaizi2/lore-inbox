Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131560AbQKYSvK>; Sat, 25 Nov 2000 13:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131599AbQKYSvA>; Sat, 25 Nov 2000 13:51:00 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:10804 "EHLO kweetal.tue.nl")
        by vger.kernel.org with ESMTP id <S131560AbQKYSuo>;
        Sat, 25 Nov 2000 13:50:44 -0500
Message-ID: <20001125192030.A7152@win.tue.nl>
Date: Sat, 25 Nov 2000 19:20:30 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Keith Owens <kaos@ocs.com.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: silly [< >]
In-Reply-To: <200011251026.eAPAQKG210983@saturn.cs.uml.edu> <6551.975150464@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <6551.975150464@ocs3.ocs-net>; from Keith Owens on Sat, Nov 25, 2000 at 10:07:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 10:07:44PM +1100, Keith Owens wrote:

> If anybody really worries about the ix86 call trace going past column
> 80, just patch your kernel to print 5 fields per line instead of 8.  Do
> not change the format.  But hand copying an oops from an 80x24 screen
> is not going to work in the long term, see above.  Fiddling with the
> output format is a waste of time, instead work out how to capture the
> oops without relying on hand copying or a limited screen size.  Fix the
> problem, not the symptom.

Maybe you do not understand. This is a step towards capturing an oops.
People do different things - invent schemes to write an oops to swap space,
or to a floppy, or put it in memory in a place that might survive a reboot,
or log it over the ethernet, or attach a serial line to some terminal or
logging computer, they even use a high speed camera to capture an oops
as it is flying by.

These are all useful. Not every computer has a floppy drive, not every
computer has a hard disk, not every computer has a monitor screen,
not every computer can feasibly be connected to something else,
so more than a single scheme is needed. The scheme: write info to the screen
is very simple and is useful in a large number of cases. 
This screen has a very finite capacity (known to the kernel) so it is
important not to waste this capacity.

At present we waste a lot of space inserting meaningless parentheses.
The place of these parentheses is syntactically predictable, so
ksymoops can insert them just as well as the kernel can.
(I am talking about i386 here, have not looked at other architectures.)

And what is reality? I work under X and the system crashes. Boom. Dead.
No reaction to anything, no log, zero information. Ach.
Six weeks later, I work under X and the system crashes. Boom. Dead.
Nothing to do, zero information.
Four weeks later, I am on the console and the system crashes. A panic!
The message scrolls over the screen but the call trace is too long
and wastes 50% of the space so that only the end is visible - but that
is the part with the most worthless information. I do not want EIP to scroll
off-screen, I want the first few items of the Call Trace, not the last few.
Again the system is dead, and no useful information was obtained.

So, each time I miss important information because of these stupid
parentheses, I patch that kernel. And it regularly happens that I am
rewarded with a complete message that would otherwise have missed
the most important part. I think this change is useful for everybody,
not just for me.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
