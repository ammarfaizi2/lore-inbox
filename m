Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWFIPcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWFIPcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWFIPcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:32:23 -0400
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:28066 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1030211AbWFIPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:32:22 -0400
Date: Fri, 9 Jun 2006 11:32:12 -0400
From: "Bill Rugolsky Jr." <bill@rugolsky.com>
To: Dan Carpenter <error27.lkml@gmail.com>
Cc: Matt Heler <lkml@lpbproductions.com>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Message-ID: <20060609153212.GA28830@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <bill@rugolsky.com>,
	Dan Carpenter <error27.lkml@gmail.com>,
	Matt Heler <lkml@lpbproductions.com>, Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <20060319232317.GA25578@ti64.telemetry-investments.com> <441F56AD.8020001@garzik.org> <200603262014.35466.lkml@lpbproductions.com> <20060327160845.GG9411@ti64.telemetry-investments.com> <b263e5900606071509o3b06c7a4y84aae7802a5aece2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b263e5900606071509o3b06c7a4y84aae7802a5aece2@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 03:09:31PM -0700, Dan Carpenter wrote:
> Bill Rugolsky Jr. <bill@rugolsky.com> wrote:
> >Here is an incomplete attempt to get the sata_nv ADMA code working.
> >
> >I made another pass through my merge of the sata_nv driver to fix and
> >clean up a few things.  I've only made the minimal changes necessary
> >to get it into a testable state; methinks it could do with a lot of
> >refactoring and cleanup, instead of all the "if (host->...host_type == 
> >ADMA)" tests.
> >
> 
> Did you ever figure this out?
> 
> It looks like you're mixing two completely seperate bugs.  The ata
> timeouts and the lost ticks messages.
> 
> >BIOS Information
> >        Vendor: Phoenix Technologies Ltd.
> >        Version: 2004Q3
> >        Release Date: 10/12/2005
> >
> 
> This is causing the sata failures:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190856
> Downgrade to match your other system (version 1.01).  That will fix
> the ata timeouts at least.

Interesting; I still have one such machine set aside for testing purposes,
so I can give that a try; in my limited testing, ADMA didn't exhibit the
same long latencies.

I'm just rolling up a 2.6.17 kernel patchset, so I'll pull in Jeff's
sata_nv branch and give it a try; the patch queue is long though, so
it will probably be sometime next week.

> I'm still interested in the lost ticks messages though...

My workaround has been to just use John Stultz's new timekeeping
code (actually the variant in Thomas Gleixner's hrtimers rollup --
http://tglx.de/projects/hrtimers/).  Our PostgreSQL servers now maintain
sub-millisecond NTP offsets, whereas previously they would drift 100+ms away,
lose sync, and require an NTP restart every day or so.

John wrote the other day:

   With the current code in -mm I can run a test app that disables
   interrupts for 2 seconds at a time over and over and I'm still keeping
   synched w/ an NTP server within 30 microseconds.

The patches in -mm are set to be merged in 2.6.18-rc1, so I have no qualms
about including them in my internal 2.6.17 patchset.

Kudos to John, Thomas, Ingo, and others who have worked on the new
timekeeping code.  This is yet another area where work on the -rt kernel
benefits everyone in a measurable way.

	-Bill
