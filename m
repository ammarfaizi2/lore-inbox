Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbTDXTWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTDXTWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:22:04 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:61312 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S263813AbTDXTWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:22:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Trammell Hudson <hudson@osresearch.net>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday running backwards on 2.4.20
Date: Thu, 24 Apr 2003 21:35:31 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030422232316.GF20108@osbox.osresearch.net>
In-Reply-To: <20030422232316.GF20108@osbox.osresearch.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030424193410.C52BF12F067@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23 Apr 03 01:23, Trammell Hudson wrote:
> [ Please cc hudson@osresearch.net on any replies.  Thank you! ]
>
> A few months ago I noticed gettimeofday running backwards on
> dual Pentium II and dual Pentium Pro systems with 2.4.18.  Based
> on postings made to linux-kernel in June of 2002, I upgraded
> to 2.4.20 and the problem seemed to go away:
>
>   http://groups.google.com/groups?threadm=3D16DE83.3060409@tiscalinet.it
>
> Just recently my NAS benchmarks and MPI latency tests showed bizarre
> results, so I pulled out my test program and am seeing the same
> problems again.  It seems that roughly 50 in 1 million calls go
> backwards, even with 2.4.20.

It's happening on my VAIO laptop as well, with a similar frequency.  The size 
of the typical regression dropped by roughly an order of magnitude between 
2.4.19 and 2.4.20, from several 10's of ms to a few ms.

There needs to be a final idiot check in there, as the last thing that 
happens in sys_gettimeofday, to catch and prevent such regressions in a 
brutally stupid way, in addition to the fancy algorithm that tries to prevent 
them, and has never fully succeeded in doing that.

A reasonable algorithm is: if time goes backwards by less than a second, it 
wasn't somebody changing the clock, so return the previous timeofday, 
otherwise, save the new value for the next test.

Applications like games (but not only games) can get pretty messed up by a 
timeofday that jumps backwards every couple of seconds.

Regards,

Daniel
