Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTEOKDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 06:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTEOKDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 06:03:36 -0400
Received: from corky.net ([212.150.53.130]:57009 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263943AbTEOKDf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 06:03:35 -0400
Date: Thu, 15 May 2003 13:16:17 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <20030515072425.GA7638@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0305151256210.26657-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> s/currently running/running now or in the future/

Hopefully near future only, assuming you have a proper log/alert system
that sends logs to another machine.
(and if you don't and your box stays owned, you have bigger problems
than the swap sniffing).

>
> But apart from that, it does really reduce the window, agreed.
>
> An alternative approach would simply zero all freed memory in the
> system, with almost identical effects. Almost means you are missing
> memory (that isn't cleared on reboot on all systems, ...) and this is
> missing hard disk recovery that can read data already overwritten.
>
> Arguments against this simpler approach?

The performance impact for one.  My systems often has processes taking
hundreds of megabytes in swap.  If we'd have to wipe all this space on the
disk whenever such process dies, the system would be unusable.

Second, see previous posts on this thread re hardware issues when writing
zero blocks to some disks.  In short, you're never sure its really clean.

Third, in case of crash (i.e. when someone pulls the plug and steals the
server), the system had no chance to clean the swap.

Encrypted swap solves all that.

>
> Jörn
>
> --
> Rules of Optimization:
> Rule 1: Don't do it.
> Rule 2 (for experts only): Don't do it yet.
> -- M.A. Jackson
>

