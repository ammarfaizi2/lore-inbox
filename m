Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUAYLIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 06:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUAYLIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 06:08:51 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:26284 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S263963AbUAYLIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 06:08:49 -0500
Date: Sun, 25 Jan 2004 13:08:47 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040125110847.GA10824@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040123194714.GA22315@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123194714.GA22315@elektroni.ee.tut.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:47:14PM +0200, I wrote:
> I'm very sorry if this is already reported. In 2.6.1 (and earlier) ps does
> not report the process start times correctly.
...
> For example, I started this bash process really at 21:24 (date showed 21:24
> then):
> 
> kaukasoi 22108  0.0  0.2  4452 1532 pts/4    R    21:28   0:00 /bin/bash

OK, I would like to make my bug report more accurate: the problem seems to
be that the value of btime in /proc/stat is not correct. procps uses that to
calculate the start time of a process.

date +%s ; cat /proc/uptime ; grep btime /proc/stat
1075028140
1393207.63 1379643.46
btime 1073634689

Time now (1075028140) minus uptime (1393207.63) is 1073634932 (the correct
bootup time). btime differs from that by 243 seconds, so that's the error of
four minutes in ps output. Just to check, a line from syslog:

Jan  9 09:55:41 elektroni kernel: Linux version 2.6.1 (kaukasoi@elektroni) (gcc version 2.95.3 20010315 (release)) #1 Fri Jan 9 09:54:37 EET 2004

and from that

date +%s --date='Jan  9 09:55:41'
1073634941

ok, syslogd seems to have started 9 seconds after bootup.

This is athlon tb 1400 and I run ntpd.
