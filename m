Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTHYVC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbTHYVC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:02:59 -0400
Received: from smtp.mailix.net ([216.148.213.132]:64585 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S262201AbTHYVC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:02:57 -0400
Date: Mon, 25 Aug 2003 23:02:54 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Message-ID: <20030825210254.GA12781@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net> <20030825094240.GJ16080@Synopsys.COM> <200308252016.13315.kernel@kolivas.org> <20030825102133.GA14402@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825102133.GA14402@Synopsys.COM>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Mon, Aug 25, 2003 12:21:33 +0200:
> > > > XEmacs still spins after running a background job like make or grep.
> > > > It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> > > > as often, or as long time as with O16.3, but it's there and it's
> > > > irritating.
> > >
> > > another example is RXVT (an X terminal emulator). Starts spinnig after
> > > it's child has exited. Not always, but annoyingly often. System is
> > > almost locked while it spins (calling select).
> > 
> > What does vanilla kernel do with these apps running? Both immediately after 
> > the apps have started up and some time (>1 min) after they've been running?
> 
> cannot test atm. Will do in 10hours.
> RXVT behaved sanely (or probably spin-effect is very rare) in 2.4 (with
> O(1) alone and your 2.4 patches) and plain 2.6-test1.
> 

Sorry, I have to postpone this investigation. No time on the machine.

I try to describe the behaviour of rxvt as best as I can below.

Afaics, the application (rxvt) just sleeps at the beginning waiting for
input from X. As every terminal would do. At some point its inferior
process finishes, but it fails to notice this spinning madly in the
internal loop calling select, which returns immediately (because other
side of pty was closed. That is the error in rxvt). Probably it has
accumulated enough "priority" up to this moment to block other
applications (window manager, for example) when it suddenly starts running?

-alex
