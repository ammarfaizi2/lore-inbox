Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTJQCt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTJQCt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:49:58 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:57323 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263295AbTJQCtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:49:52 -0400
Subject: decaying average for %CPU
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066358155.15931.145.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Oct 2003 22:35:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UNIX standard requires that Linux provide
some measure of a process's "recent" CPU usage.
Right now, it isn't provided. You might run a
CPU hog for a year, stop it ("kill -STOP 42")
for a few hours, and see that "ps" is still
reporting 99.9% CPU usage. This is because the
kernel does not provide a decaying average.

Another OS uses a fixed-point decaying average,
with this sort of representation:
0x8000 is 100%
0x2000 is 25%
0x0000 is 0%

Anybody have a version of the algorithm that...

* works with traditional 100 HZ ticks
* works with exact (TSC-based) accounting
* lets a thread-group sum to well over 100%
* doesn't require updates to idle processes

???

I'm thinking it would be nice to have the
binary point be between a pair of 32-bit ints.
That might allow for great range w/o doing
lots of "long long" operations, but I haven't
worked out the details.


