Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbUCSN6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUCSN6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:58:08 -0500
Received: from styx.suse.cz ([82.208.2.94]:24960 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S262997AbUCSN6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:58:02 -0500
Date: Fri, 19 Mar 2004 14:58:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Message-ID: <20040319135819.GB658@ucw.cz>
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <20040318203717.GA4430@ucw.cz> <200403190005.36956.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403190005.36956.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 12:05:36AM -0500, Dmitry Torokhov wrote:

> > Could this be the bit that indicates whether the report is coming from
> > an internal or external device?
> 
> That is what I suspect, but I can not prove it and in fact I am quite
> surprised that KBC would mangle data requested via CMD_AUX_LOOP. So far
> I have seen the following sequences (* denotes 4th bit flipped):
> 
> 2.6.1:
> IN:    	FO   
> OUT:    F8* 
> 
> 2.6.2-rc1-bk1:
> IN:     5A  F0  56  A4 
> OUT:    5A  F0  56  AC*
> 
> 2.6.3 + my debug
> IN:     5A  A4  5B  A4  53  F0  56
> OUT:    5A  A4  5B  AC* AC  F0  5E*
> 
> 2.6.3 + my other debug
> IN:     5A  A4  A4  A4  A4  F0  56  A4  A4  A4  A4
> OUT:	5A  A4  A4  A4  A4  F0  56  A4  A4  A4  A4
> 
> ... and I am waiting on sequence:
> 5A 00 00 00 00 F0 56 A4 00 00 00 00
> 
> As you can see it does not always flip that bit, but if it will mangle the
> last sequence I think we can claim that we see "hidden multiplexor" and
> abort active multiplexor test.

So far on every machine I've got a report from it was caused by BIOS
emulation of PS/2 mouse using an USB mouse (even when USB mouse wasn't
present). Compiling the USB modules into the kernel fixes the problem.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
