Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbTHYWlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbTHYWlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:41:52 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19140
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262399AbTHYWlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:41:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Alex Riesen <fork0@users.sf.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Date: Tue, 26 Aug 2003 08:48:23 +1000
User-Agent: KMail/1.5.3
References: <200308231555.24530.kernel@kolivas.org> <20030825102133.GA14402@Synopsys.COM> <20030825210254.GA12781@steel.home>
In-Reply-To: <20030825210254.GA12781@steel.home>
Cc: William Lee Irwin III <wli@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308260848.23538.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003 07:02, Alex Riesen wrote:
> Alex Riesen, Mon, Aug 25, 2003 12:21:33 +0200:
> > > > > XEmacs still spins after running a background job like make or
> > > > > grep. It's fine if I reverse patch-O16.2-O16.3. The spinning
> > > > > doesn't happen as often, or as long time as with O16.3, but it's
> > > > > there and it's irritating.
> > > >
> > > > another example is RXVT (an X terminal emulator). Starts spinnig
> > > > after it's child has exited. Not always, but annoyingly often. System
> > > > is almost locked while it spins (calling select).
> > >
> > > What does vanilla kernel do with these apps running? Both immediately
> > > after the apps have started up and some time (>1 min) after they've
> > > been running?
> >
> > cannot test atm. Will do in 10hours.
> > RXVT behaved sanely (or probably spin-effect is very rare) in 2.4 (with
> > O(1) alone and your 2.4 patches) and plain 2.6-test1.
>
> Sorry, I have to postpone this investigation. No time on the machine.
>
> I try to describe the behaviour of rxvt as best as I can below.
>
> Afaics, the application (rxvt) just sleeps at the beginning waiting for
> input from X. As every terminal would do. At some point its inferior
> process finishes, but it fails to notice this spinning madly in the
> internal loop calling select, which returns immediately (because other
> side of pty was closed. That is the error in rxvt). Probably it has
> accumulated enough "priority" up to this moment to block other
> applications (window manager, for example) when it suddenly starts running?

Something like that. Interesting you point out select as wli was 
profiling/tracing the mozilla/acroread plugin combination that spins on wait 
and also found select was causing grief. It was calling select with a 15ms 
timeout and X was getting less than 5ms to do it's work and respond and it 
was repeatedly timing out. Seems a common link there.

Con

