Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTKHXgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 18:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTKHXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 18:36:03 -0500
Received: from galileo.bork.org ([66.11.174.156]:42925 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261276AbTKHXgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 18:36:00 -0500
Subject: Re: [PATCH 2.6] Number of proc entries based on NR_CPUS ?
From: Martin Hicks <mort@wildopensource.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031108190310.GG3440@krispykreme>
References: <1068313378.685.7.camel@socrates>
	 <20031108190310.GG3440@krispykreme>
Content-Type: text/plain
Organization: Wild Open Source Inc.
Message-Id: <1068334559.2039.11.camel@socrates>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 08 Nov 2003 18:35:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-08 at 14:03, Anton Blanchard wrote:
> Hi Martin,
> 
> > Here is a patch that makes the number of /proc entries be based on
> > NR_CPUS instead of just having a fixed number.  I think it is a good
> > idea now that big Linux machines are starting to appear.
> > 
> > The proper constant and slope of increase are up for argument too.
> > 
> > Patch is against the latest linux-2.5 bk tree.
> 
> I think I first bumped that to 16k, that was needed on a 32way box.
> At 128way my gut feeling is its 32k.
> 

Okay, those are useful numbers to have.  This seems to be higher than
what is required by SGI's sn2.

> Linking the number of proc entries to the number of cpus is a bit crude
> but its better than having it fixed.

Yeah, I'm not sure what a really good solution is.  I really don't have
an urge to tear apart the proc code to make it more dynamic than this
compile time option.

> 
> FYI I think some networking people were complaining about this limit
> when they create gobs of network interfaces (dummy devices?  ipsec?).
> Each interface creates a bunch of /proc/sys/net entries...

Based on your guidlines above, we need a number of proc entries more
like:

8192 + 256*NR_CPUS

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296


