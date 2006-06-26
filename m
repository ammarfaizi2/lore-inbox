Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWFZQaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWFZQaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWFZQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:30:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750772AbWFZQav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:30:51 -0400
Date: Mon, 26 Jun 2006 09:30:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PM_TRACE corrupts RTC
In-Reply-To: <20060626091413.a15df2e0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606260927130.3747@g5.osdl.org>
References: <20060625232322.af3f4f6c.akpm@osdl.org> <Pine.LNX.4.64.0606260851000.3747@g5.osdl.org>
 <20060626091413.a15df2e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Jun 2006, Andrew Morton wrote:
> 
> Oh, I thought it found some spare space in there somehow.

I really tried. The fact is, the RTC chips have at least 114 bytes of 
NVRAM available in them, and most have more. Sadly, while from a hw 
standpoint it's non-volatile, the firmware I was testing with cleared it 
all (including the extended banks etc).

> Making it `default y' was a bit unfriendly.  How's about `default n' and
> `depends on EMBEDDED'?

We can certainly make it 'default n', and perhaps hide it behind 
EXPERIMENTAL (it's not really, but hey..). Not EMBEDDED, though, this is 
literally meant to help random people who have a dead machine on suspend 
be able to just turn this on, test suspend, and then when suspend causes a 
dead machine, just turn off power and reboot immediately again, and it 
will tell you which device was the last one to go through the resume 
cycle.

		Linus
