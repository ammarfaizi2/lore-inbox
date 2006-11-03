Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753393AbWKCRaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbWKCRaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbWKCRaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:30:09 -0500
Received: from pop-gadwall.atl.sa.earthlink.net ([207.69.195.61]:56279 "EHLO
	pop-gadwall.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1753393AbWKCRaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:30:08 -0500
Date: Fri, 3 Nov 2006 12:30:01 -0500 (EST)
From: Brent Baccala <cosine@freesoft.org>
X-X-Sender: baccala@debian.freesoft.org
To: Jens Axboe <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
In-Reply-To: <20061103160212.GK13555@kernel.dk>
Message-ID: <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org>
 <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org>
 <20061103160212.GK13555@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Jens Axboe wrote:

> Try to time it (visual output of the app is not very telling, and it's
> buffered) and then apply some profiling.

OK, a little more info.  I added gettimeofday() calls after each call
to io_submit(), put the timevals in an array, and after everything was
done computed the difference between each timeval and the program start
time, as well as the deltas.  I got this:

0: 0.080s
1: 0.086s  0.006s
2: 0.102s  0.016s
3: 0.111s  0.008s
4: 0.118s  0.007s
5: 0.134s  0.015s
6: 0.141s  0.006s
7: 0.148s  0.006s
8: 0.158s  0.009s
9: 0.164s  0.006s
...
96: 1.036s  0.007s
97: 1.044s  0.007s
98: 1.147s  0.102s
99: 1.155s  0.008s

98 appears to be an aberration.  Perhaps three of the times on an
average run are around a tenth of a second; all of the others are
pretty steady at 7 or 8 microseconds.  So, it's basically linear in
its time consumption.

Does 7 microseconds seem a bit excessive for an io_submit (and a
gettimeofday)?



 					-bwb

 					Brent Baccala
 					cosine@freesoft.org
