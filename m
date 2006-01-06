Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWAFWs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWAFWs1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWAFWs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:48:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964877AbWAFWs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:48:26 -0500
Date: Fri, 6 Jan 2006 17:48:11 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106224811.GA2624@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <1136468254.16358.23.camel@localhost.localdomain> <20060105205221.GN20809@redhat.com> <20060106152203.GA11906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106152203.GA11906@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 04:22:03PM +0100, Pavel Machek wrote:
 > Hi!
 > 
 > >  > > The one case this doesn't catch is the problem of oopses whilst
 > >  > > in X. Previously a non-fatal oops would stall X momentarily,
 > >  > > and then things continue. Now those cases will lock up completely
 > >  > > for two minutes. 
 > >  > 
 > >  > The console has awareness of graphic/text mode at all times and knows
 > >  > what is going on. Why not use that information if you must go this way ?
 > > 
 > > If we've just oopsed, the console may have no awareness of what day it is,
 > > yet alone anything about video modes. I'm not entirely sure what you're
 > > suggesting, but it gives me the creeps. Are you talking about switching
 > > away from X back to a tty when we oops?
 > 
 > No.
 > 
 > But you _know_ if user is running X or not -- notice that kernel does
 > not attempt to printk() when X is running, because that could lock up
 > the box.
 > 
 > If user is running X, you don't need the delay.
 > 
 > if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
 > 	delay(10sec)
 > }

>From this context though, we don't have a 'vc' to reference,
so we'll need to find out from the console layer somehow, which
is the current vc.

		Dave

