Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVCCFXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVCCFXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVCCFXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:23:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261474AbVCCFVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:21:15 -0500
Date: Thu, 3 Mar 2005 00:21:01 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, jgarzik@pobox.com, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303052100.GA22952@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, jgarzik@pobox.com,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302203812.092f80a0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Wed, Mar 02, 2005 at 04:00:46PM -0800, Linus Torvalds wrote:
 > > 
 > >  > I would not keep regular driver updates from a 2.6.<even> thing. 
 > > 
 > > Then the notion of it being stable is bogus, given how many regressions
 > > the last few kernels have brought in drivers.  Moving from 2.6.9 -> 2.6.10
 > > broke ALSA, USB, parport, firewire, and countless other little bits and
 > > pieces that users tend to notice.
 > 
 > Grump.  Have all these regressions received the appropriate level of
 > visibility on this mailing list?

For the most part these things are usually known about by their upstream
authors.  To give an example: ALSA update in 2.6.10 broke sound for a
bunch of IBM thinkpads. As it turns out there are quite a lot of these
out there, so when I released a 2.6.10 update for Fedora, bugzilla lit
up like a christmas tree with "Hey, where'd my sound go?" reports.
(It was further confused by a load of other sound card problems, but
 thats another issue).  This got so out of control, Alan asked the ALSA
folks to take a look, and iirc Takashi figured out what had caused the
problem, and it got fixed in the ALSA folks tree, and subsequently, in 2.6.11rc.

Now, during all this time, there hadn't been any reports of this problem
at all on Linux-kernel. Not even from Linus' tree, let alone -mm.
Which amazes me given how widespread the problem was.

 > I too am a little put off by the number of regressions which certain
 > (admittedly tricky) subsystems keep on introducing.  One does wonder how
 > careful people are being at the development stage.  And that's a thing
 > which we can surely fix.
 > For example, here's today's crop (so far):
 > 
 > include/linux/soundcard.h:195: warning: `_PATCHKEY' redefined
 > include/linux/awe_voice.h:33: warning: this is the location of the previous definition

compile time regressions we should be able to nail down fairly easily.
(someone from OSDL is already doing compile stats and such on each release
 [too bad they're mostly incomprehensible to the casual viewer])
The bigger problem is runtime testing. If things aren't getting the
exposure they need, we're going to get screwed over by something or other
every time Linus bk pull's some random driver repo.

		Dave

