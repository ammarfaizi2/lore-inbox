Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTLBXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLBXmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:42:09 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:16383 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264449AbTLBXmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:42:03 -0500
Subject: Re: [OT] Rootkit queston
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: midian@ihme.org
Content-Type: text/plain
Organization: 
Message-Id: <1070400282.780.11.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Dec 2003 16:24:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been paranoid after I heard that the debian project
> got "rootkitted", I ran chkrootkit, and it said that
> it's possible that I have a LKM rootkit installed, but
> the website told me that it's possible that the LKM test
> gives wrong information with recent kernels (Running 2.4.22
> now).
>
> These processes "were hidden from ps command":
> root         0  0.0  0.0     0    0 ?        SWN  Oct28   0:01 [ksoftirqd CPU0]
> root         0  0.0  0.0     0    0 ?        SW   Oct28   4:27 [kswapd]
> root         0  0.0  0.0     0    0 ?        SW   Oct28   0:00 [bdflush]
> root         0  0.0  0.0     0    0 ?        SW   Oct28   0:01 [kupdated]
>
> They seem to have PID 0, is this normal?

Yes and no. This is a kernel bug that trips up libproc.

The first number in a /proc/*/stat file should match
the Tgid number in the /proc/*/status file it goes with.
This is the POSIX PID. (note: NOT the "Pid" value)

Early 2.4.xx kernels didn't try to report this in
the /proc/*/status files at all, so libproc would
use the /proc/*/stat data instead. Recent 2.4.xx
kernels report the data. It seems that the data is
left uninitialized for the built-in kernel tasks.

Though there will be a work-around in future libproc
code, the 2.4.xx kernel ought to get fixed anyway.

> Do my system have a rootkit installed?

I don't think so.

> If it does, how do I remove it?

Boot from CD-ROM and reinstall the OS.


