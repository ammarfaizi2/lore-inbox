Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWGaXYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWGaXYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWGaXYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:24:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:13714 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751444AbWGaXYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:24:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: XFS vs. swsusp
Date: Tue, 1 Aug 2006 01:23:37 +0200
User-Agent: KMail/1.9.3
Cc: Nathan Scott <nathans@sgi.com>, kernel list <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
References: <20060731215933.GB3612@elf.ucw.cz> <20060801084143.D2286470@wobbly.melbourne.sgi.com> <20060731225308.GA4000@elf.ucw.cz>
In-Reply-To: <20060731225308.GA4000@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010123.37466.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 01 August 2006 00:53, Pavel Machek wrote:
> > > Rafael has patches to add bdev freezing to swsusp. I'd like to know if
> > > they are neccessary (and why).
> > > 
> > > 1) Is sync() enough to guarantee that all the data written before sync
> > > actually reach the platters?
> > > 
> > > (Or is it that data only reach the journal? OTOH that would be okay, too).
> > 
> > It ensures file data reaches its final resting place, and that
> > metadata changes have been logged.  It does not necessarily
> ....
> 
> Okay, good, being safely in the journal is okay.
> 
> > > 2) If we stop all the user proceses and all the kernel threads, is
> > > that enough to prevent XFS from writing to disk?
> > 
> > Yes, I believe so (if all user processes and kernel threads are
> > stopped, who else would be left to initiate I/O?).  There is a
> 
> Well, we were afraid that you'd do it from timer interrupt or
> something like that.
> 
> > timer driven wakeup done on the per-fs xfssyncd kernel threads,
> > which do background metadata writeout and will write to the log
> > periodically... but if those processes are all stopped too, you
> > should be OK.
> 
> Timer only wakes up xfssyncd thread, right? That's okay, as that
> thread will be stopped.

But we call sync() before kernel threads are frozen.  What happens if xfssyncd
gets woken up by the timer after the sync() and before we freeze it?

Rafael
