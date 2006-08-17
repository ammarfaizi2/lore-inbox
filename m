Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWHQKin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWHQKin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 06:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWHQKim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 06:38:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53959 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964793AbWHQKim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 06:38:42 -0400
Date: Thu, 17 Aug 2006 12:32:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [NTP 0/9] NTP patches
In-Reply-To: <1155769647.6785.67.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608171203240.6761@scrub.home>
References: <20060810000146.913645000@linux-m68k.org>
 <1155769647.6785.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Aug 2006, john stultz wrote:

> 	How much real-world testing have you done with these patches? I've been
> running w/ this set of patches for a few days and I've been noticing my
> system is having difficulties synching up w/ the NTP server.

I tested it on a few machines of course.

> I haven't been logging anything, so its currently uncertain data, but
> normally I've seen NTP sync the time within 1-2ms in just an hour or so,
> however since this morning (~6 hours ago) I'm seeing it still 10ms off.
> 
> I'm going to let it run for the rest of the day then try to bisect the
> patches to see where things went wrong. I'll let you know as soon as I
> find anything.

I would need the loopstats over a few days to really say something about 
this. It may also depend on the stability of your remote NTP serer. The 
new code adjusts a little a slower, but should be overall a little more 
stable.
The ntpd does basically "if (!pll_nano) ntv.constant = sys_poll - 4;" to 
adjust for the difference in behaviour of the two models, but this causes 
rather fast adjustments. In the NTP4 patch I undo this adjustment for the 
new model.

> I'm going to let it run for the rest of the day then try to bisect the
> patches to see where things went wrong. I'll let you know as soon as I
> find anything.

Well, upto the NTP4 patch the behaviour should be mostly unchanged.

bye, Roman
