Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267172AbUFZO7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267172AbUFZO7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 10:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267174AbUFZO7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 10:59:24 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11180 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267172AbUFZO7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 10:59:22 -0400
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: george@galis.org, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1088253429.9831.1449.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Jun 2004 08:37:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Fri, 25 Jun 2004, George Georgalis wrote:

>> Could this be related to "Unknown HZ value! (91) Assume 100." which
>> started showing up with VIA motherboards on 2.5.x (I think) on top or ps
>> commands.  When I researched it before, It never caused ill, had been
>> identified as a "kernel bug" but benign. I know nothing more.
>
> No, that's just a pstools bug. It shouldn't try to guess HZ at all.

With an older kernel I'd say he's losing 9% of his clock ticks.
In this case though, incompatible /proc/stat changes are
at fault. No longer does idle CPU time include IO-wait CPU time.
This shouldn't have changed; user tools can subtract as needed.

I'm sorry to say that the HZ-guessing code is now only
used for the 2.2.xx kernels. Over the years it has found
many clock problems. Had the 2.4.xx kernels used a 64-bit
jiffies counter, the HZ-guessing code would still be used.

You never did come up with an alternative to HZ-guessing
that would work on those old 1200-HZ Alpha boxes, the ARM
boxes that ran at 64 HZ and so on. I suppose you can blame
the arch maintainers, but user-space has to deal with it.
So HZ-guessing is a workaround for a kernel bug, especially
because you claim that HZ (USER_HZ now) is part of the ABI.


