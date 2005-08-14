Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVHNOAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVHNOAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 10:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHNOAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 10:00:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:36296 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932527AbVHNOAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 10:00:54 -0400
Subject: Re: IDE CD problems in 2.6.13rc6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e05081404354fe6a097@mail.gmail.com>
References: <20050813232957.GE3172@redhat.com>
	 <58cb370e05081404354fe6a097@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 14:46:41 +0100
Message-Id: <1124027202.14138.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 13:35 +0200, Bartlomiej Zolnierkiewicz wrote:
> > The symptoms vary. On some of my machines just inserting
> > an audio CD makes the box instantly lock up.

You've got all the gnome cruft running. Start by turning that off. Then
try inserting/removing audio discs, playing them with "cdplay". I'd
expect that to be ok

Next try ripping an audio cd without all the gnome crud loaded. If that
works (it may or may not) then its practical to try and pin down the bug
and see if its error handling (the locking patterns all changed in the
base kernel recently hence all those new PIIX error reports) or
something else.

> I checked 2.6.13-rc6 patch and I see no IDE / CD changes which
> could be responsible for this regression.  You can try reverting ide-cd
> changes and see if this helps.  IRQ routing changes?

Then you'd expect to see "drive confused" methods. It could be IRQ
related - missing IRQ might do it although I'd expect that to cause
crashes during probe if we got extra IRQs (because the code to handle it
was removed from the base kernel even though it is required).

Another thing that will do this is if you bomb the drive with commands
from somewhere (say GNOME) or crash the firmware, which is why you need
to isolate all the gnome gunge for testing, and if that makes the
difference see if its a kernel or higher level change and if so what its
doing that causes problems.

Alan

