Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbULRAkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbULRAkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbULRAjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:39:18 -0500
Received: from holomorphy.com ([207.189.100.168]:27610 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262488AbULRAil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:38:41 -0500
Date: Fri, 17 Dec 2004 16:38:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Oops on 2.4.x invalid procfs i_ino value
Message-ID: <20041218003835.GD771@holomorphy.com>
References: <Pine.SGI.4.61.0412171611120.27132@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.61.0412171611120.27132@kzerza.americas.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 04:49:44PM -0600, Brent Casavant wrote:
> Thus closing a proc entry for any task with a pid that is a multiple of
> 65536 will fail this check, skip proc_pid_delete_inode, and call
> __MOD_DEC_USE_COUNT, more than likely causing a panic on an invalid
> memory access, and minimally corrupting something in memory otherwise.
> I don't have a solution coded up (mostly because I'm a bit bleary
> eyed after looking at crash dumps all day) -- but are there any
> thoughts on how to go about addressing this one?  An obvious workaround
> is setting kernel.pid_max to 65535, but that's only a workaround, not
> a solution.
> On a related note, if it matters, on about half the crash dumps I've
> looked at, I see a pid of 0 has been assigned to a user process,
> tripping this same problem.  I suspect there's another bug somewhere
> that's allowing a pid of 0 to be chosen in the first place -- but I
> don't totally discount that this problem may lay in SGI's patches to
> this particular kernel -- I'll need to take a more thorough look.

That's rather ominous. I'll pore over pid.c and see what's going on.
Also, does the pid.c in your kernel version match 2.6.x-CURRENT?


-- wli
