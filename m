Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272493AbTGaOpC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272494AbTGaOpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:45:02 -0400
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:44517 "EHLO
	skunk.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S272493AbTGaOo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:44:59 -0400
From: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Date: Thu, 31 Jul 2003 16:44:57 +0200
To: Charles Lepple <clepple@ghz.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
Message-ID: <20030731164457.A6993@skunk.physik.uni-erlangen.de>
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de> <17207.216.12.38.216.1059660771.squirrel@www.ghz.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <17207.216.12.38.216.1059660771.squirrel@www.ghz.cc>; from clepple@ghz.cc on Thu, Jul 31, 2003 at 10:12:51AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 31, 2003 at 10:12:51AM -0400, Charles Lepple wrote:
> about this (haven't instrumented it all the way), it also appears that
> pm_idle is not being called (for up to an hour, in some cases). Sometimes
> it takes only a few minutes, and other times, it appears to kick in after
> heavy CPU usage (kernel compiles, cpuburn, etc.).

Yes, exactly. Up to the first time need_resched() returns true and
the outer while(1){ } loop loops to update the idle-variable. Unfortunately
this never was the case on my system for a long time...

Probably the idle loop uses this local variable to be more cache-friendly,
but then any module updating pm_idle should probably set need_resched
to force an update of the idle function pointer?

	Chris

-- 
Read the OSI protocol specifications? I can't even *lift* them!
