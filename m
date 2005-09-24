Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVIXDQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVIXDQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 23:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVIXDQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 23:16:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:51393 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751382AbVIXDQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 23:16:04 -0400
Date: Sat, 24 Sep 2005 05:15:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127458197.24044.726.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509240443440.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home>  <1127342485.24044.600.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
  <Pine.LNX.4.61.0509230151080.3743@scrub.home> <1127458197.24044.726.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Sep 2005, Thomas Gleixner wrote:

> The idea of ktimers is to use the requested time given by a timespec in
> human time without any corrections, so we actually can avoid the above.
> 
> Also doing time ordered insertion into a list introduces incompabilities
> between 32/64 bit storage formats.

Except that the (time) range of the list would be limited I don't really 
see a big difference.
Anyway, the biggest cost is the conversion from/to the 64bit ns value and 
if its main use is sorting, you can use something like this:

typedef union {
	u64 tv64;
	struct {
#ifdef __BIG_ENDIAN
		u32 sec, nsec;
#else
		u32 nsec, sec;
#endif
	} tv;
} ktimespec;

To compare two time values the tv64 value is sufficient.

bye, Roman
