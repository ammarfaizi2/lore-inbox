Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTKDUU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTKDUU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:20:57 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:24293 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261950AbTKDUUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:20:55 -0500
Date: Tue, 4 Nov 2003 15:20:37 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Venezia <pvenezia@jpj.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
Message-ID: <20031104202037.GB30612@ti19.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Linus Torvalds <torvalds@osdl.org>, Paul Venezia <pvenezia@jpj.net>,
	linux-kernel@vger.kernel.org
References: <1067973024.23788.24.camel@d8000> <Pine.LNX.4.44.0311041130480.20373-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311041130480.20373-100000@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 11:36:55AM -0800, Linus Torvalds wrote:
> > I've been running bonnie++ filesystems testing on an IBM x335 server
> > recently. This box uses the MPT RAID controller, but I've disabled the
> > RAID and am addressing the disks individually. I'm getting wildly
> > different results between 2.4.20-20-9 (RedHat mod), 2.4.22 (stock), and
> > 2.6.0-test9.
> 
> Interesting. The 2.4.22 sequential "per char" results are totally out of
> line with anything else.
> 
> The thing is, the overhead for the per-char stuff really should be almost 
> all in user space unless I'm mistaken. It's just using getch/putch, no?

Unless bonnie++ is using the _unlocked() variants, it might be an issue of
the mutex overhead from NPTL v. LinuxThreads.  Red Hat 9 has its share
of NPTL bugs.

It is probably worth rerunning the tests with LD_ASSUME_KERNEL=2.4.1 on
the Red Hat kernel.

Regards,
	
	Bill Rugolsky
