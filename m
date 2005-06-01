Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFAJRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFAJRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFAJRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:17:37 -0400
Received: from village.ehouse.ru ([193.111.92.18]:41998 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261348AbVFAJQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:16:50 -0400
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: Christopher Warner <chris@servertogo.com>
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
Date: Wed, 1 Jun 2005 13:16:29 +0400
User-Agent: KMail/1.7.2
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Christopher Warner <cwarner@kernelcode.com>,
       "Peter J. Stieber" <developer@toyon.com>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>, admin@list.net.ru
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB> <Pine.LNX.4.62.0505262112540.32548@twin.uoregon.edu> <1117190965.13932.36.camel@sabrina>
In-Reply-To: <1117190965.13932.36.camel@sabrina>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011316.29771.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 14:49, Christopher Warner wrote:
> On Thu, 2005-05-26 at 21:41 -0700, Joel Jaeggli wrote:
> > On Thu, 26 May 2005, Christopher Warner wrote:
> > 
> > > Just read the other existing thread linked. Is everyone running the same
> > > model opteron on these Tyan boards (246)? To update even further.
> > > Besides the parallel port problem I've sent back about 5 of these tyan
> > > motherboards. A couple of then simply didn't have the gigabit network
> > > adapters available via bios. In some cases linux loaded the drivers for
> > > the adapters regardless of their setting in BIOS. In other cases they
> > > simply were not available.
> > 
> > I have 4 tyan s2882's. 2 with 244's and 2GB of ram and 2 with 246 and 4GB 
> > of ram. I don't appear to have bad parallel ports or bad ethernet 
> > interfaces. They're running fedora core 3's 2.6.11 x86_64 kernel
> > (2.6.11-1.14_FC3smp)... I cna't tell you what bios version off the top of 
> > my head but i can reboot one tomorrow if that helps.
> 
> Not to interested in the BIOS versions anymore. As the tyan boards in
> question have been rma'd I'm not exactly sure whats going on with them
> now. The tyan boards I have in here right now appear to work properly
> except for the pmd issue, i've noticed nothing wrong with them besides
> that. 
> 
> What we need is to try and single out the variables that are causing the
> badpmd's. Also the more people who report badpmd's with Andi Kleen's
> intial patch the better. Especially on different archs; would also be
> good. So far from lkml i'm only seeing Tyan S28* boards as of recent.
We have run into different problem (for our different from S28*arch)
for the box which had had badpmd issues with v2.6.11 (see:
    http://seclists.org/lists/linux-kernel/2005/May/6369.html)

with 2.6.12-rc5 we are always getting dozens of user-space segfaults:

grep[25377]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp 00007fffffb13cb8 error4
grep[29940]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp 00007fffff913428 error4
sed[5849] general protection rip:40bac5 rsp:7fffffb231d0 error:0
sed[27437] general protection rip:40bac5 rsp:7ffffff248c0 error:0
sed[27473] general protection rip:40bac5 rsp:7fffff923740 error:0
sed[27472] general protection rip:40bac5 rsp:7fffff923740 error:0
sed[28434] general protection rip:406965 rsp:7fffffb23f10 error:0
grep[32583]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp 00007fffffd13b58 error4
sed[9074] general protection rip:40bac5 rsp:7fffffb248a0 error:0
sed[9546] general protection rip:406965 rsp:7fffffb23cc0 error:0
sed[4331] general protection rip:40bac5 rsp:7fffff922fb0 error:0
sed[17906] general protection rip:40bac5 rsp:7fffffd24b30 error:0
sed[17934] general protection rip:40bac5 rsp:7fffffd243a0 error:0
sed[19555] general protection rip:40bac5 rsp:7fffff924ad0 error:0
sed[20453] general protection rip:40bac5 rsp:7ffffff23010 error:0

during the build of mysql.

There also was an oops with v2.6.12-rc3 for the same box:
http://seclists.org/lists/linux-kernel/2005/May/6369.html

Box passed two iterations of memtest86 (unfortunately this
is a production box, so we can't wait for days).

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
