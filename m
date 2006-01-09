Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWAIRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWAIRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWAIRBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:01:51 -0500
Received: from ns.firmix.at ([62.141.48.66]:64992 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1030182AbWAIRBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:01:49 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Bernd Petrovitsch <bernd@firmix.at>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Oliver Neukum <oliver@neukum.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1136824880.9957.55.camel@mindpipe>
References: <5t06S-7nB-15@gated-at.bofh.it>
	 <200601091702.48955.oliver@neukum.org> <1136822646.9957.35.camel@mindpipe>
	 <200601091714.27303.oliver@neukum.org>  <1136823598.9957.43.camel@mindpipe>
	 <1136824149.5785.75.camel@tara.firmix.at>
	 <1136824880.9957.55.camel@mindpipe>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 09 Jan 2006 17:59:46 +0100
Message-Id: <1136825987.5785.93.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 11:41 -0500, Lee Revell wrote:
> On Mon, 2006-01-09 at 17:29 +0100, Bernd Petrovitsch wrote:
> > On Mon, 2006-01-09 at 11:19 -0500, Lee Revell wrote:
[....]
> > > I think you'll get at most a 10% or 20% speedup by improving the kernel,
> > > while some of these apps (think Nautilus vs Windows Explorer) will need
> > > to be 1000% faster to seem reasonable to a Windows user.
> > 
> > That's easy: Just start nautilus, OOorg, Firefox, a java-vm and
> > GNOME/KDE infrastructure at login time in the background (*eg* and
> > mlockall() the more important ones so that the are surely in RAM) and
> > "starting the app" is only a small program connecting to the respective
> > process to get a fork() there (e.g. like the "-remote" parameter in the
> > Mozilla family).
> 
> Have you tried this?  I suspect it still takes at least twice as long as
> on windows.

No, I don't run all on them at once (only xemacs, firefox and the above
forgotten evolution on XFCE) and if, the hosts I'm usually working on
have probably not enough RAM for mlockall(MCL_CURRRENT).
And AFAIK there are no small starter programs and features - only for
Mozilla and cousins.

> For example on my system there was already a "nautilus" process but
> "Places -> Home Folder" still took ~2 seconds to display anything, and
> ~8 seconds to completely render the window and icons.  On Windows this
> takes much less than a second.

Hmm, what happens on the click:
- The click is transported via X, TCP/IP to the application.
- The app decides what to do and generates anew window and content.
- If swapped out, swap it in.
- Load the home directory and what else is needed for displaying it
  (Icons, etc.) from the disk.
- Load these images into the X server.

Id a completely new progrma is started, you must load it from disk, wait
for the shared linker, let it initialize everything and *then* it is
actually usable (and I hate that default OO.org feature that it puts the
window in foreground after startup  at least three times until the
document is loaded).

If you have a memory hog like firefox with a large page loaded then lots
of RAM are occupied anyways and no one except firefox can do anything
about it (without swapping out and this is also slow). And I have just
to switch tabs to hear my disk working.

Ths point is: You have to analyze *where* the apps spend that much time
(independent of being idle wehile waiting for disk I/O or busy moving MB
of graphic data around). It doesn't make that much sense to improve the
(e.g.) 2% in the kernel by 50% since that would bring next to nothing.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

