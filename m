Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWHQLx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWHQLx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWHQLx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:53:58 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:53196 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S964831AbWHQLx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:53:57 -0400
Date: Thu, 17 Aug 2006 05:53:56 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Random scsi disk disappearing
Message-ID: <20060817115356.GM4340@parisc-linux.org>
References: <44E44B3E.10708@tls.msk.ru> <20060817113537.GK4340@parisc-linux.org> <44E4567B.4080104@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E4567B.4080104@tls.msk.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 03:43:55PM +0400, Michael Tokarev wrote:
> Matthew Wilcox wrote:
> > On Thu, Aug 17, 2006 at 02:55:58PM +0400, Michael Tokarev wrote:
> [sporadic disk disappearing, no logging]
> > 
> > I'd recommend turning on scsi logging; it might give you a clue about
> > which bit of scanning is failing to work properly.
> > 
> > Try booting with scsi_mod.scsi_logging_level = 448 (I think I have that
> > number right; 7 shifted left by 6) and then you can compare failing and
> > non-failing runs and see if there's any difference.
> 
> It should be the same as
>    echo $((7<<6)) > /sys/module/scsi_mod/parameters/scsi_logging_level
> (which indeed is 448) at runtime, right?  (And yes, CONFIG_SCSI_LOGGING
> is set to y).

That's right.

> Heh oh those magic numbers!.. ;)

Yeah, but the alternative is an in-kernel named symbol parser ... which
we have in some drivers, but boy is it ugly.

> Ok, I've turned on the logging on a bunch of machines (using the sysfs
> method), let's see what will happen next.  Thank you!
> 
> By the way, should kernel pefrorm at least *some* "minimal" logging of
> such a serious events by default?  Well ok, ok, it's not known yet what
> the event really is, so I'm shutting up now, at least for a while.. ;)

That's the problem -- if it turns out the event is a reasonable thing to
happen for some devices, we'll annoy everyone with those devices.  It's
hard to please everybody ;-)
