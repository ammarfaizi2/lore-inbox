Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUASLAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUASLAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:00:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:16056 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264538AbUASLAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:00:48 -0500
Message-Id: <200401191058.i0JAw2S14446@owlet.beaverton.ibm.com>
To: Jean-Luc Fontaine <jfontain@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.1: erroneous statistics in /proc/diskstats? 
In-reply-to: Your message of "Sun, 18 Jan 2004 18:11:55 +0100."
             <400ABE5B.6090701@free.fr> 
Date: Mon, 19 Jan 2004 02:58:02 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I would like to make sure /proc/diskstats is reliable or if I am totally
    misunderstanding the significance of the milliseconds spent reading or
    writing figures.

So far as I know, they are reliable but there always could be a bug.
Note that it is legitimate for field 8 to be greater than the time
elapsed, since it is the *total* time spent in *all* writes.  If two write
requests were issued simultaneously and each fulfilled simultaneously,
taking exactly 10ms, you'd account for 20ms of "write I/O" even though
only 10ms of time has passed.

So, a few more details ...

How big was it?
How did you copy it (what command)?
Were you going through a file system or direct to disk?

One thing I notice is that your hdc shows 100+ "io's in progress" both
at start and completion.  It may be as simple as that counter is off.
If there are IO's in progress when you start and they haven't finished
by the time you end, then they will certainly add about 6 seconds of
"write time" for each outstanding, apparently unfulfilled request.
This alone could account for your extra time.  Any theories on why that
number is so large for hdc but quite small for hdb?

Rick
