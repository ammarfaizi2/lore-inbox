Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268552AbTBOI7c>; Sat, 15 Feb 2003 03:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268554AbTBOI7b>; Sat, 15 Feb 2003 03:59:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:49301 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268552AbTBOI7a>;
	Sat, 15 Feb 2003 03:59:30 -0500
Date: Sat, 15 Feb 2003 01:09:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Subject: Re: problems with 2.5.61-mm1
Message-Id: <20030215010954.44153675.akpm@digeo.com>
In-Reply-To: <3E4E0153.3000008@us.ibm.com>
References: <3E4E0153.3000008@us.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2003 09:09:19.0601 (UTC) FILETIME=[EC35FE10:01C2D4D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> I've been beating on various versions of 2.5.59 all day long with no
> problems that I didn't cause.  I started testing 2.5.61-mm1 and rand
> into a couple problems right away.
> 
> The first I really doubt is -mm specific.  I gets _loads_ of these, and
> the e1000 isn't working:
> NETDEV WATCHDOG: eth0: transmit timed out
> e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
> 
> The e1000 driver hasn't been touched in weeks.

Don't know.

>  Here's my /proc/interrupts:
> http://www.sr71.net/linux/interrupts
> I'm pretty sure we can see the problem here.  Almost all interrupts are
> going to CPU0.  Is this a summit thing?

No, that's the new irq balancing code.  It only starts distributing
interrupts to other CPUs when the load gets higher.  See how it
spread the ethernet interrupts.  Apparently this is as-designed.
 
> The other looks a bit more insidious.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000003d

It might be best to test 2.5.61 first.

