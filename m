Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUFRLXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUFRLXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUFRLXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:23:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265115AbUFRLWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:22:48 -0400
Date: Fri, 18 Jun 2004 07:22:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll
In-Reply-To: <40D25247.3050509@candelatech.com>
Message-ID: <Pine.LNX.4.53.0406180715200.4952@chaos>
References: <Pine.LNX.4.53.0406170954190.702@chaos> <40D21C8E.4040500@candelatech.com>
 <Pine.LNX.4.53.0406171958570.3414@chaos> <40D25247.3050509@candelatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Ben Greear wrote:

> Richard B. Johnson wrote:
> > On Thu, 17 Jun 2004, Ben Greear wrote:
> >
> >
> >>Richard B. Johnson wrote:
> >>
> >>>Hello,
> >>>Is it okay to use the 'extra' bits in the poll return value for
> >>>something? In other words, is the kernel going to allow a user-space
> >>>program to define some poll-bits that it waits for, these bits
> >>>having been used in the driver?
> >>
> >>Can't you just do a read and determine from the results of the read
> >>what you actually got?  If not, add framing to your message so that
> >>you *CAN* determine one message type from another...
> >>
> >>Ben
> >>
> >
> >
> > The mailbox read(s) is/are 32-bit int(s). There is no way to identify
> > it as being "new" or something that was written two weeks ago.
> > That's why we use poll. Poll says 'I got something new for you'.
>
> Then use 3 different file descriptors to poll/read.  That seems more
> efficient anyway as it doesn't wake the folks who don't care.
>
> Ben

Huh??  The driver has no clue what open file-descriptor needs
whatever special handling. When a polled-for event occurs, a
bit is put into what will be the poll return value in the driver
and any process sleeping in poll ** that is waiting for that bit **
gets awakened. That's why I need to use some of the "spare" bits.
Only the task that's waiting for its specific bit gets awakened
in user-mode.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


