Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVI1JgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVI1JgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVI1JgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:36:06 -0400
Received: from webmail-outgoing2.us4.outblaze.com ([205.158.62.67]:16604 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1030231AbVI1JgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:36:05 -0400
X-OB-Received: from unknown (205.158.62.51)
  by wfilter.us4.outblaze.com; 28 Sep 2005 09:36:02 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Sep 2005 04:36:02 -0500
Subject: Best Kernel Timers?
X-Originating-Ip: 193.195.77.146
X-Originating-Server: ws1-5.us4.outblaze.com
Message-Id: <20050928093602.DFA0B8401C@ws1-5.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wondered if anyone could provide information about where to look for
suitable kernel timers?

For a while I have been working on supporting the hardsid/catweasel
cards on Linux (and Windows).  Although undesirable the original
implementations required real usec delays in the OS
(this requirement being fixed in the very latest hardware).  I know
Linux is not realtime so the original drivers were designed to
queue hardware writes to a realtime thread that busy waited and
recovered as best it could from errors (on the whole this worked
pretty well).  Also another version of the code was written to use
rtlinux/rtai that was capable of non busy waiting.

More recently with the release of the new buffering hardware the
driver was redesigned from the realtime posix code.  Due to these
changes the busy waiting (for the old cards) can nolonger occur
and the delays have to happen asynchronusly notifing the realtime
thread when the delay has expired.  The code uses the posix
timer_set, etc calls with realtime clock with absolute delays and
flags a semaphore when the signal occurs (works great under
realtime systems).

Now as an alternative it is again desired that a version (although
wont perfectly work) be available to a vanilla 2.6 kernel (possibly
2.4) with similiar limitations as before.  Its a shame the posix
calls appear to not be supported in kernel for drivers so I have
wrapped the calls for semaphores/mutexs/threads to kernel
equivalents.

However I have no idea what to do for the timers.  Is there
something suitable inkernel that would provide an async callback
to pre-empt a realtime thread and provide better resolution than
HZ a far amount of the time?  Or do I have to run a seperate lower
priority busy waiting thread to wakeup the realtime one?

Advice appreciated.
Simon

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

