Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbWBNG6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWBNG6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWBNG6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:58:09 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:63620 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1030504AbWBNG6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:58:08 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Christoph Lameter <clameter@engr.sgi.com>
Date: Tue, 14 Feb 2006 07:57:21 +0100
MIME-Version: 1.0
Subject: Re: 2.6.15:kernel/time.c: The Nanosecond and code duplication
Cc: linux-kernel@vger.kernel.org
Message-ID: <43F18D63.23094.53018CA@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.62.0602131308280.3026@schroedinger.engr.sgi.com>
References: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118673@20060214.064404Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Feb 2006 at 13:11, Christoph Lameter wrote:

> On Mon, 13 Feb 2006, Ulrich Windl wrote:
> 
> > There's a hacked-on getnstimeofday() which, what I discovered doesn't actually 
> > pass along the nanosecond resolution of xtime. It does:
> 
> This is the fall back function for arches without nanosecond 
> resolution....

Like the i386 family? Having seen some more of the code, I found that the posix-
timers.c also has it's own family of time routines (plus routines that seem quite 
hard to use inside the kernel, so I added just another wrapper). I really think 
these are too many functions all dealing with getting the current time. I really 
think that nowadays all lower resolution clocks should be derived from the POSIX 
time routines (I'm talking about the concept, not a particular implementation).

> 
> > The proper solution most likely is to define POSIX compatible routines with 
> > nanosecond resolution, and then define the microsecond-resolution from those, and 
> > not the other way round.
> 
> Right.

;-)

Regards,
Ulrich

