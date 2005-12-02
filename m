Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVLBWBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVLBWBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVLBWBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:01:46 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:11170 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750805AbVLBWBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:01:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Date: Fri, 2 Dec 2005 23:02:48 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20051202183748.GA12584@hexapodia.org>
In-Reply-To: <20051202183748.GA12584@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512022302.48734.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2 of December 2005 19:37, Andy Isaacson wrote:
> On Thu, Dec 01, 2005 at 10:42:44PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, 1 of December 2005 18:36, Andy Isaacson wrote:
> > > My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> > > 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> > > successful suspend/resume cycles.  But now that I'm running
> > > 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:
> > 
> > Thanks a lot for the report.
> > 
> > The problem is apparently caused by my recent patch intended to speed up
> > suspend.  Could you please apply the appended debug patch, try to reproduce
> > the problem and send full dmesg output back to me?
> 
> Here you go.  This is two suspends; the first one completed
> successfully, then I triggered a failure by starting a bunch of
> processes until highmem looked full.  (Just firefox wasn't enough, so I
> started a bunch of vim -R sessions on a 50MB file until HighFree went
> under 1MB.)

Thanks a lot.

}-- snip --{
> [17179971.660000] Stopping tasks: ============================================================|
> [17179972.060000] Shrinking memory...  Data pages: 65794
> [17179972.092000] Data and highmem pages: 161459
> [17179972.092000] Total pages: 162957
> [17179972.092000] Pages to free: 159697
> [17179972.092000] Pages to free: 159697
> [17179972.092000] Pages to free: -623
> [17179972.092000] -done (0 pages freed)
}-- snip --{
> [17179972.224000] ................................................................................................swsusp: Need to copy 162186 pages
> [17179972.224000] swsusp: available memory: 67188 pages
> [17179972.224000] swsusp: Not enough free memory
> [17179972.224000] Error -12 suspending
}-- snip --{

Well, now that's crystal clear.

I'm working on a patch.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
