Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTJUVqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbTJUVqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:46:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35076 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263304AbTJUVql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:46:41 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Software RAID5 with 2.6.0-test
Date: 21 Oct 2003 21:36:39 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn48t7$j8s$1@gatekeeper.tmr.com>
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net>
X-Trace: gatekeeper.tmr.com 1066772199 19740 192.168.12.62 (21 Oct 2003 21:36:39 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <yw1xu167kbcw.fsf@users.sourceforge.net>,
=?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net> wrote:
| Bill Davidsen <davidsen@tmr.com> writes:
| 
| >> However, I wouln't count on superior performance from software based
| >> RAID 5 (ata/fakeraid or otherwise), that is whats real raid controllers
| >> are for.
| >
| > While an overloaded system may benefit from offloaded the CPU
| > requirements of RAID, unless you go to a very expensive external unit
| > the kernel RAID will usually outperform the inexpensive RAID embedded on
| > a controller. The kernel simply knows more about the data needs and can
| > can do things a controller can't.
| 
| What about the RAID controllers in the $400 category?  Surely, they
| must be doing something better than the $50 fakeraid controllers.

Unfortunately my experience is with either the cheap motherboard ones I
get for free and the IBM ServRAID controllers which are kind of in the
"more than that" category. The benefit of the m/b ones is that with
RAID-1 you will get a boot if the boot drive fails. Period. Unlike
optimal RAID-1 which will read mirrored data from any non-busy drive,
the cheap ones seem to do fail-over only, and read the second drive
only if the first fails, or even require both drives to be on the same
cable, ensuring that the bus will be busy when either drive is busy.
They do buy reliability, however, so there are places where they are
very cost effective.

The IBM controllers are everything you ever wanted in a controller. It
supports four SCSI busses for bandwidth, all the RAID types including
5e, and it has Linux config software so you can do most reconfigures on
a running system. I would choose them over anything else I've personally
used, mainly Adaptec and PERC. They are really great for multi-TB
storage systems.

But in between is where software RAID wins. In many medium
applications, the limit isn't CPU, and it isn't bus bandwidth, it's the
base speed of the disk access counted as either access time or
bandwidth depending on the application. So the major benefits of
midprice RAID for ATAPI/SATA aren't realized, performance is the issue.

It's obvious that the o/s has information which a RAID controller
doesn't in terms of ordering i/o. And similarly true that adding a GB to
the main system is going to help overall more than a GB on a controller
(as noted, 256MB seems the limit on some), because the o/s will use it
more effectively for buffers, and because it will eliminate some i/o
entirely, particularly swap. And nothing speeds a disk operation more
than avoiding the need to do it.

Anyone who says that any one solution is best for everything is clearly
misguided, but I do think that for many midsize applications that
software RAID is the most cost effective solution, and vs. moderately
priced controllers very likely to be the higher performance solution as
well.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
