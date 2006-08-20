Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWHTRZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWHTRZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWHTRZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:25:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34027 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750957AbWHTRZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:25:29 -0400
Date: Sun, 20 Aug 2006 19:25:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [NTP 5/9] add time_adjust to tick length
In-Reply-To: <20060821.003317.63131005.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0608201914310.6761@scrub.home>
References: <20060810000146.913645000@linux-m68k.org> <20060810001114.706731000@linux-m68k.org>
 <20060821.003317.63131005.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Aug 2006, Atsushi Nemoto wrote:

> On Thu, 10 Aug 2006 02:01:51 +0200, zippel@linux-m68k.org wrote:
> > This folds update_ntp_one_tick() into second_overflow() and adds
> > time_adjust to the tick length, this makes time_next_adjust unnecessary.
> > This slightly changes the adjtime() behaviour, instead of applying it to
> > the next tick, it's applied to the next second.
> ...
> > -/* Don't completely fail for HZ > 500.  */
> > -int tickadj = 500/HZ ? : 1;		/* microsecs */
> 
> The tickadj is used by cris, frv, m32r, m68k, mips and sparc.  This
> patch would break build on those platforms.
> 
> I have not looked at this patch closely yet.  Just a report.

Oops, I indeed missed that. I searched for if anyone would change that 
value, but later forgot about the other users.
A simple solution would be to move this (constant) value to a header and 
another rather simple solution would be to remove it completely, as it's 
rather bogus anyway. These users check time_adjust, which is unused in a 
NTP controlled system. The correct value to check would be the tick 
length, but I'm sure it's really worth the trouble.

bye, Roman
