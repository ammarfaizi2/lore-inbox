Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUK0IDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUK0IDo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 03:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUK0IDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 03:03:44 -0500
Received: from mail.charite.de ([160.45.207.131]:61614 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261158AbUK0IDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 03:03:30 -0500
Date: Sat, 27 Nov 2004 09:03:29 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Out of memory, but no OOM Killer? (2.6.9-ac11)
Message-ID: <20041127080329.GU30987@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041126224722.GK30987@charite.de> <41A7C2CA.1030008@yahoo.com.au> <20041127003353.GQ30987@charite.de> <41A7D3EF.3030002@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41A7D3EF.3030002@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin <nickpiggin@yahoo.com.au>:

> >I see. rsync requested a big chunk of memory, but failed due to the
> >fragmentation of free memory? my "sar" output shows lots of free memory and
> >lots of unused swap:
> >
> 
> Basically, yes. Well not *exactly* rsync - your network drivers. I guess
> rsync is showing up in process context most often because that is the
> process causing most of the network activity.

At that time, yes.

> Yep, it looks like fragmentation is indeed the problem here. See you have
> a lot of memory that is able to be reclaimed, but the failing allocations
> themselves can't reclaim any of it because they are happening from
> interrupts. What they should be doing is telling `kswapd` to start freeing
> memory for them - however this currently doesn't happen properly for
> allocations which are order greater than 0.
> 
> Fortunately that is usually not a big problem, but as you have seen, it
> can be. Anyway, expect 2.6.10 to be better (ie. good enough), and 2.6.11
> should have even more complete fixes.

Aha.

> OK that should be fine. If you should upgrade to a 2.6.10 or later kernel,
> put this value back to the default, and report further problems if they
> occur.

I just set it "for now"

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
