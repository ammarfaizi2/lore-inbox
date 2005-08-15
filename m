Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVHOWM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVHOWM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVHOWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:12:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62694 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965008AbVHOWM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:12:58 -0400
Date: Tue, 16 Aug 2005 00:12:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/13] NTP cleanup work (v. B5)
In-Reply-To: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508151212000.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Aug 2005, john stultz wrote:

> 	The goal of this patch set is to isolate the in kernel NTP state
> machine in the hope of simplifying the current timekeeping code and
> allowing for optional future changes in the timekeeping subsystem.
> 
> I've tried to address some of the complexity concerns for systems that
> do not have a continuous timesource, preserving the existing behavior
> while still providing a ppm interface allowing smooth adjustments to
> continuous timesources. 

I think most of this is premature cleanup. As it also changes the logic in 
small ways, I'm not even sure it qualifies as a cleanup.
The only obvious patch is the PPS code removal, which is fine.
For the rest I can't agree on to move everything that aggressively into 
the ntp namespace. The kernel clock is controlled via NTP, but how it 
actually works has little to do with "network time". Some of the 
parameters are even private clock variables (e.g. time adjustment, phase), 
which don't belong in any common code. (I'll expand on that in the next 
mail.)

bye, Roman
