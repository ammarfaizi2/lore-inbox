Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWHTQof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWHTQof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWHTQof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:44:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:54615 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750849AbWHTQoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:44:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XfV56HSToutUEDH6ZC/dXLJzql8BzqzNcGh8oH2e01j+NkixDfTpLqlUsYwC34BwEO+96vuwPYv/zv6Oxp5ke2ITB0AeaiExcQHPnr57dyZTrytSquZ+wpbotLk/qBxr+GZlpFrk7pP7Ug1uTzNH670oIWkCv7uBqaLpk0YWYdA=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: mplayer + heavy io: why ionice doesn't help?
Date: Sun, 20 Aug 2006 18:43:58 +0200
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, mplayer-users@mplayerhq.hu,
       linux-kernel@vger.kernel.org
References: <200608181937.25295.vda.linux@googlemail.com> <Pine.LNX.4.61.0608201021340.9707@yvahk01.tjqt.qr> <1156085026.10565.39.camel@mindpipe>
In-Reply-To: <1156085026.10565.39.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201843.58849.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 16:43, Lee Revell wrote:
> On Sun, 2006-08-20 at 10:22 +0200, Jan Engelhardt wrote:
> > >
> > >It helps. mplayer skips much less, but still some skipping is present.
> > 
> > Try with -ao alsa, then it should skip less, or at least, if it skip, skip 
> > back so that less audio is lost.
> > When playing audio-only files, it is always wise to specify e.g. -cache 320
> > which proved to be a good value for my workloads.
> > 
> 
> Only with the very latest versions of mplayer does ALSA work at all.
> It's unusable here because it resets the auduio stream on each underrun
> rather than simply ignoring them.

I'm not sure that I ever got an underrun (may check it
for you if you need that, how to do it?),
but mplayer -ao alsa is working for me just fine.

I eliminated skips due to CPU and disk using
nice and -cache 8000. I still can make it skip
when my KDE background picture is changing.

I think that these skips are caused by the X server.
It has no prioritization for request handling and
thus it does not paint mplayer output fast enough:
it needs to repaint background and semi-transparent
konsole(s), and that is taking a few seconds at least.

This is probably aggravated by serializing nature of Xlib,
according to:

http://en.wikipedia.org/wiki/XLib
http://en.wikipedia.org/wiki/XCB
--
vda
