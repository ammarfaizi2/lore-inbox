Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWCLRXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWCLRXe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCLRXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:23:34 -0500
Received: from soundwarez.org ([217.160.171.123]:55226 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751628AbWCLRXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:23:33 -0500
Date: Sun, 12 Mar 2006 18:23:32 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, ambx1@neo.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060312172332.GA10278@vrfy.org>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4414033F.2000205@drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 12:17:19PM +0100, Pierre Ossman wrote:
> Andrew Morton wrote:
> > I assume you mean that the drivers/pnp/card.c patch of
> > pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
> > on top of the result.
> >
> > But I don't want to break udev.
> >   
> 
> I suppose I wasn't entirely clear there. I'd like you to do the first
> part (remove the card.c part), but not apply this second patch. I just
> sent that in as a means of getting the ball rolling again.

Again, multiline sysfs modalias files are not going to happen. Find a
sane way to encode the list of devices into a single string, or don't do
it at all. And it must be available in the event environment too.

> The reason I'm pushing this issue is that Red Hat decided to drop all
> magical scripts that figured out what modules to load and instead only
> use the modalias attribute. They consider the right way to go is to get
> the PNP layer to export modalias, so that's what I'm trying to do.

There is no need to rush out with this half-baken solution. This simple
udev rule does the job for you, if you want pnp module autoloading with
the current kernel:
  SUBSYSTEM=="pnp", RUN+="/bin/sh -c 'while read id; do /sbin/modprobe pnp:d$$id; done < /sys$devpath/id'"

Andrew, please make sure, that this patch does not hit mainline until
there is a _sane_ solution to the multiple id's exported for a single
device problem.

Thanks,
Kay
