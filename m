Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTHUHi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTHUHi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:38:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:52123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262482AbTHUHi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:38:26 -0400
Date: Thu, 21 Aug 2003 00:40:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Message-Id: <20030821004018.1fb79bbb.akpm@osdl.org>
In-Reply-To: <20030821092534.0eb08a89.martin.zwickel@technotrend.de>
References: <20030820171431.0211930e.martin.zwickel@technotrend.de>
	<20030820113625.6a75d699.akpm@osdl.org>
	<bi0grq$49r$1@build.pdx.osdl.net>
	<20030821083337.6fc701b9.martin.zwickel@technotrend.de>
	<20030820234119.33362f7a.akpm@osdl.org>
	<20030821092534.0eb08a89.martin.zwickel@technotrend.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>
> On Wed, 20 Aug 2003 23:41:19 -0700
> Andrew Morton <akpm@osdl.org> bubbled:
> 
> > Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> > >
> > > cutted-dmesg.txt  text/plain (15496 bytes)
> > 
> > Try `dmesg -s 1000000'.   The silly thing has too small a buffer.
> 
> too late.. :(
> rebooted and fscked.
> on reboot, my console did hang up while unmounting fs's and i got tons of
> strange errors about something on my fs(where the processes got stuck). can't
> remeber the outputs, was too much and too fast.
> only a sysrq-b helped.
> 
> on another fs i got some "Deleted inode ###### has zero dtime.  Fix<y>?".

Sigh.  Well the filesystem obviously shat itself, so the fsck errors aren't
that surprising.

My guess would be that something oopsed while holding a directory semaphore
and you missed the oops.  Maybe you were in X at the time?

If it happens again, please remember that dmesg needs the `-s 1000000'
option to prevent it from truncating output.

> ps.: 2.6.0-t3 scheduler performance is not that good...

It's pretty bad.  I'm running 2.6.0-test3-mm1 here which has Ingo/Con
goodies and it is significantly improved.

Once that code is working sufficiently well for everyone and there is
consensus that the general direction is correct and the possible
regressions with mixed database workloads are sorted out, we'll fix it up. 
So don't panic yet.

