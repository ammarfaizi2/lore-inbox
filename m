Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUA0RbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUA0RbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:31:06 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:45698 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S263173AbUA0RbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:31:04 -0500
Date: Tue, 27 Jan 2004 19:31:02 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: process start times by procps
Message-ID: <20040127173102.GA15052@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040123194714.GA22315@elektroni.ee.tut.fi> <20040125110847.GA10824@elektroni.ee.tut.fi> <20040127155254.GA1656@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127155254.GA1656@elektroni.ee.tut.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 05:52:54PM +0200, Petri Kaukasoina wrote:
> I made an experiment shown below. I know nothing about kernel programming,
> so this is probably not correct, but at least btime seemed to stay constant.
> (I don't believe this fixes procps, though. If HZ if off by 180 ppm then I
> guess ps can't possibly get its calculations involving HZ right. But at
> least the bootup time reported by procinfo stays constant.)

Yes, btime stays now constant. But to make ps work right, I replaced all uses of
variable Hertz in ps source (procps 2.0.18) with constant 100.0172.

After uptime 4 h 42 min, the error is already 3 seconds in the default ps,
and ./ps which is the "fixed" one, displays the right start time.

Tue Jan 27 19:17:57 EET 2004
kaukasoi 13388  0.0  0.1  2652  740 pts/5    R    19:17   0:00 ps uxw
kaukasoi 13392  0.0  0.1  2636  724 pts/5    R    19:17   0:00 ./ps uxw
Tue Jan 27 19:17:57 EET 2004
kaukasoi 13398  0.0  0.1  2652  740 pts/5    R    19:18   0:00 ps uxw
kaukasoi 13402  0.0  0.1  2636  724 pts/5    R    19:17   0:00 ./ps uxw
Tue Jan 27 19:17:57 EET 2004
...
Tue Jan 27 19:17:59 EET 2004
kaukasoi 13979  0.0  0.1  2652  740 pts/5    R    19:18   0:00 ps uxw
kaukasoi 13983  0.0  0.1  2636  724 pts/5    R    19:18   0:00 ./ps uxw
Tue Jan 27 19:18:00 EET 2004

So the problem is the inaccuracy of HZ.
