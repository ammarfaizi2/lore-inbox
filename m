Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUFVS2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUFVS2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUFVSUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:20:24 -0400
Received: from hera.kernel.org ([63.209.29.2]:34229 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265025AbUFVSFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:05:36 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Tue, 22 Jun 2004 11:05:05 -0700
Organization: Open Source Development Lab
Message-ID: <20040622110505.331a9f77@dell_ss3.pdx.osdl.net>
References: <40C7BE29.9010600@am.sony.com>
	<20040611062256.GB13100@devserv.devel.redhat.com>
	<40CA3342.9020105@mvista.com>
	<200406140828.08924.mgross@linux.intel.com>
	<40D7662A.2030006@am.sony.com>
	<40D76C76.7000509@mvista.com>
	<40D86E51.2080108@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1087927505 3799 172.20.1.60 (22 Jun 2004 18:05:05 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 22 Jun 2004 18:05:05 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Another thing that seems to be a sore point is the HRT core.  I think 
> there's a good consensus that the current use of preprocessor 
> conditionals makes the code pretty hairy, but what alternatives are there?

The way to handle this is to abstract the needed interface
into a set of inline's in one place (hrtime.h) then something like

#ifdef CONFIG_HIRES_TIMERS

static inline void update_hires(struct foo *foo) {
	foo->sub_tick = ...
}
#else

static inline void update_hires(struct foo *foo) {
}

#endif

> If the HRT code is always compiled in, that would simplify things alot, 
> but then there would always be a small performance hit in the compares, 
> and a slightly bigger code size.  Is this acceptable?  Also, something 
> would need to be arranged to take care of the non-supported arch's.  Any 
> ideas here?

There are two different questions. Should size of structures change based on
config options, that is what tends to make binaries break. The other is whether
the sub-tick stuff is implemented or not.


> Another way would be to pull out the HRT operations into separate 
> functions that could be conditionally included or replaced with no-op 
> versions based on a config option.  I don't know if this would be 
> do-able, or if the result would be very clean though...

It is best if the conditional code is in only a few of places,
like the inline's in an one include file; and the main code in timers
plus any arch dependant stuff.


-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
