Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTFAOlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbTFAOlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:41:21 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:52672 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262340AbTFAOlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:41:20 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>, alexh@ihatent.com
Subject: Re: USB 2.0 with 250Gb disk and insane loads
Date: Sun, 1 Jun 2003 16:53:47 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <3EDA0E5D.8080404@pacbell.net>
In-Reply-To: <3EDA0E5D.8080404@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306011653.47958.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Juni 2003 16:31 schrieb David Brownell:
> > I'm trying to nail own a problem here, with my shiny new Maxtor 250Gb
> > USB 2.0 disk. Under 2.4 (vanilla, latest 21-preX and 21-preX-acY) the
> > disk will mount and talk nicely. As soon as any load hits it, e.g. a
> > single cp from my internal CD-ROM to the disk, the mahcine load will
> > sky-rocket and at some point within a few minuter hang the machine.
> >
> > On 2.5 (vanilla and -mm) the load will show as i/o-wait and at some
> > point hang any access to the drive, but the kernel will go on working.
>
> That's a big clue -- nothing in the USB code ever shows up
> as "i/o wait".  It can't, since USB is usually built as
> modules and things like io_schedule() are, for some odd
> reason, never exported for use in modules.  So USB I/O
> can't use them, and won't show up as "i/o" ... and that
> load must come from some place other than USB.

Probably the block layer as it waits for free io slots.
But that doesn't tell us why the requests are not executed.
Where is SCSI timeout kicking in?
Have you tried enabling debugging in storage?
Could you try on USB1.1 only?

	Regards
		Oliver

