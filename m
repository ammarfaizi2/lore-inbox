Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbULTWfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbULTWfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULTWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:35:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35755 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261672AbULTWfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:35:24 -0500
Date: Mon, 20 Dec 2004 16:35:18 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Oops on 2.4.x invalid procfs i_ino value
In-Reply-To: <20041218004703.GE771@holomorphy.com>
Message-ID: <Pine.SGI.4.61.0412201624340.46534@kzerza.americas.sgi.com>
References: <Pine.SGI.4.61.0412171611120.27132@kzerza.americas.sgi.com>
 <20041218003835.GD771@holomorphy.com> <20041218004703.GE771@holomorphy.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, William Lee Irwin III wrote:

> On Fri, Dec 17, 2004 at 04:49:44PM -0600, Brent Casavant wrote:
> >> On a related note, if it matters, on about half the crash dumps I've
> >> looked at, I see a pid of 0 has been assigned to a user process,
> >> tripping this same problem.  I suspect there's another bug somewhere
> >> that's allowing a pid of 0 to be chosen in the first place -- but I
> >> don't totally discount that this problem may lay in SGI's patches to
> >> this particular kernel -- I'll need to take a more thorough look.
> 
> On Fri, Dec 17, 2004 at 04:38:35PM -0800, William Lee Irwin III wrote:
> > That's rather ominous. I'll pore over pid.c and see what's going on.
> > Also, does the pid.c in your kernel version match 2.6.x-CURRENT?
> 
> Ouch, 2.4.21; this will be trouble. So next, what patches atop 2.4.21?

I wouldn't worry about the pid=0 issue -- I think it's most likely
due to the PAGG patches (http://oss.sgi.com/projects/pagg) causing
some sort of problem at process teardown (all the pid=0 processes are
in the process of exiting).

I'm more concerned about the (0 == pid & 0xffff) bug, which is present
in the unpatched mainline 2.4.x kernel.  It seems that the easiest fix
is marking such pids as in-use at pidmap allocation, so that they are
never assigned to real tasks.  I've got the code almost done, but need
to port it to top-of-tree before submitting a patch.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
