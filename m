Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWCARLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWCARLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCARLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:11:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50960 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751286AbWCARLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:11:09 -0500
Date: Wed, 1 Mar 2006 17:10:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060301171046.GA4024@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Martin Michlmayr <tbm@cyrius.com>, pavel@suse.cz,
	linux-kernel@vger.kernel.org
References: <20060226100518.GA31256@flint.arm.linux.org.uk> <20060226021414.6a3db942.akpm@osdl.org> <20060227141315.GD2429@ucw.cz> <20060228101713.6fd44027.akpm@osdl.org> <20060228220128.GA4254@unjust.cyrius.com> <20060228153256.64f4781d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228153256.64f4781d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:32:56PM -0800, Andrew Morton wrote:
> Martin Michlmayr <tbm@cyrius.com> wrote:
> >
> > * Andrew Morton <akpm@osdl.org> [2006-02-28 10:17]:
> > > > It will oops in hard-to-guess, place, anyway.
> > > Will it?   Where?  Unfixably?
> > 
> > http://www.linux-mips.org/archives/linux-mips/2006-02/msg00241.html is
> > one example we just had on MIPS.  On SGI IP22, using the serial
> > console, you'd get the following on shutdown:
> > 
> > The system is going down for reboot NOW!
> > INIT: Sending processes the TERM signal
> > INIT: Sending proces
> > 
> > and then nothing at all.  I'd never have suspected the serial driver,
> > had not users reported that the machine shutdowns properly when using
> > the framebuffer.
> > 
> > For the record, I don't mind whether it's BUG_ON or WARN_ON, but I
> > just wanted to give this as an example of an "oops in hard-to-guess,
> > place".
> 
> >From my reading of the above thread, putting the proposed workaround into
> serial core will indeed allow people's machines to keep running while
> reminding us about the driver bugs.

I would much rather the buggy drivers were actually fixed - is there a
reason why the drivers can't actually be fixed (other than lazyness)?

Once they're fixed, adding a BUG_ON then becomes practical IMHO - it'll
stop new driver writers being confused.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
