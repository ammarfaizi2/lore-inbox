Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFZNY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTFZNY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:24:57 -0400
Received: from yin.wanderer.org ([195.218.87.139]:64267 "EHLO yin.wanderer.org")
	by vger.kernel.org with ESMTP id S261741AbTFZNYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:24:33 -0400
Date: Thu, 26 Jun 2003 15:17:07 +0300
From: Tommi Virtanen 
	<tv-nospam.da39a3ee5e6b4b0d3255bfef95601890afd80709@tv.debian.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030626121707.GA10603@lapdog>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com> <20030619165135.C6248@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619165135.C6248@almesberger.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 04:51:35PM -0300, Werner Almesberger wrote:
> 4) Losses:
> 
> Actually, I'm not so sure what really ought to happen with
> losses. If we have serialization requirements elsewhere,
> proceeding after unrecovered losses would probably mean that
> they're being violated. So if they can be violated then,
> maybe there is some leeway in other circumstances too ?
> 
> On the other hand, if any loss means that major surgery is
> needed, the interface should probably have a "in loss" state,
> in which it just shuts down until someone cleans up the mess.
> Also a partial shutdown may be interesting (e.g. implemented
> by the dispatcher), where events with no interdependencies
> with other events would still be processed.

	One thing came to my mind:

	If you have a sysfs-scanning method for startup, couldn't you
	just make the sequence-number-checking daemon reset its state
	and redo the sysfs scan on loss of events? (Or even make it
	just exec itself and use the exact same code as at startup.)

	That way the system recovers from event loss (or a reordering
	that gets the earlier event too late and is believed to be a
	loss) in a way that needs to work anyway, and isn't a magic
	special case.

-- 
:(){ :|:&};:
