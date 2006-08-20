Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWHTVgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWHTVgB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWHTVgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:36:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26252 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751122AbWHTVgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:36:00 -0400
Subject: Re: mplayer + heavy io: why ionice doesn't help?
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608201843.58849.vda.linux@googlemail.com>
References: <200608181937.25295.vda.linux@googlemail.com>
	 <Pine.LNX.4.61.0608201021340.9707@yvahk01.tjqt.qr>
	 <1156085026.10565.39.camel@mindpipe>
	 <200608201843.58849.vda.linux@googlemail.com>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 17:36:07 -0400
Message-Id: <1156109768.10565.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 18:43 +0200, Denis Vlasenko wrote:
> On Sunday 20 August 2006 16:43, Lee Revell wrote:
> > On Sun, 2006-08-20 at 10:22 +0200, Jan Engelhardt wrote:
> > > >
> > > >It helps. mplayer skips much less, but still some skipping is present.
> > > 
> > > Try with -ao alsa, then it should skip less, or at least, if it skip, skip 
> > > back so that less audio is lost.
> > > When playing audio-only files, it is always wise to specify e.g. -cache 320
> > > which proved to be a good value for my workloads.
> > > 
> > 
> > Only with the very latest versions of mplayer does ALSA work at all.
> > It's unusable here because it resets the auduio stream on each underrun
> > rather than simply ignoring them.
> 
> I'm not sure that I ever got an underrun (may check it
> for you if you need that, how to do it?),
> but mplayer -ao alsa is working for me just fine.
> 

You probably don't get underruns because your machine is fast.  Mine is
a 600Mhz Via board, but I know this is an mplayer ALSA driver bug
because it works perfectly with -ao oss, and because mplayer's ALSA
driver maintainer has acknowledged the bug.

> I eliminated skips due to CPU and disk using
> nice and -cache 8000. I still can make it skip
> when my KDE background picture is changing.
> 

I also must run mplayer at nice -20 for it to be usable.

> I think that these skips are caused by the X server.
> It has no prioritization for request handling and
> thus it does not paint mplayer output fast enough:
> it needs to repaint background and semi-transparent
> konsole(s), and that is taking a few seconds at least.
> 
> This is probably aggravated by serializing nature of Xlib,
> according to:
> 
> http://en.wikipedia.org/wiki/XLib
> http://en.wikipedia.org/wiki/XCB

I think the problem is also due to mplayer's faulty design.  It should
be multithreaded and use RT threads for the time sensitive work, like
all professional AV applications and many other consumer players do.

Lee

