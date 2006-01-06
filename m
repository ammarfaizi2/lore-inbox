Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWAFPWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWAFPWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWAFPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:22:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30938 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751467AbWAFPWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:22:23 -0500
Date: Fri, 6 Jan 2006 16:22:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106152203.GA11906@elf.ucw.cz>
References: <20060105045212.GA15789@redhat.com> <1136468254.16358.23.camel@localhost.localdomain> <20060105205221.GN20809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105205221.GN20809@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > The one case this doesn't catch is the problem of oopses whilst
>  > > in X. Previously a non-fatal oops would stall X momentarily,
>  > > and then things continue. Now those cases will lock up completely
>  > > for two minutes. 
>  > 
>  > The console has awareness of graphic/text mode at all times and knows
>  > what is going on. Why not use that information if you must go this way ?
> 
> If we've just oopsed, the console may have no awareness of what day it is,
> yet alone anything about video modes. I'm not entirely sure what you're
> suggesting, but it gives me the creeps. Are you talking about switching
> away from X back to a tty when we oops?

No.

But you _know_ if user is running X or not -- notice that kernel does
not attempt to printk() when X is running, because that could lock up
the box.

If user is running X, you don't need the delay.

if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
	delay(10sec)
}

or something like that should do the trick.
								Pavel

-- 
Thanks, Sharp!
