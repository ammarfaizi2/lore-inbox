Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWB1Xe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWB1Xe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWB1Xe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:34:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932600AbWB1Xe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:34:28 -0500
Date: Tue, 28 Feb 2006 15:32:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: pavel@suse.cz, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-Id: <20060228153256.64f4781d.akpm@osdl.org>
In-Reply-To: <20060228220128.GA4254@unjust.cyrius.com>
References: <20060226100518.GA31256@flint.arm.linux.org.uk>
	<20060226021414.6a3db942.akpm@osdl.org>
	<20060227141315.GD2429@ucw.cz>
	<20060228101713.6fd44027.akpm@osdl.org>
	<20060228220128.GA4254@unjust.cyrius.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> wrote:
>
> * Andrew Morton <akpm@osdl.org> [2006-02-28 10:17]:
> > > It will oops in hard-to-guess, place, anyway.
> > Will it?   Where?  Unfixably?
> 
> http://www.linux-mips.org/archives/linux-mips/2006-02/msg00241.html is
> one example we just had on MIPS.  On SGI IP22, using the serial
> console, you'd get the following on shutdown:
> 
> The system is going down for reboot NOW!
> INIT: Sending processes the TERM signal
> INIT: Sending proces
> 
> and then nothing at all.  I'd never have suspected the serial driver,
> had not users reported that the machine shutdowns properly when using
> the framebuffer.
> 
> For the record, I don't mind whether it's BUG_ON or WARN_ON, but I
> just wanted to give this as an example of an "oops in hard-to-guess,
> place".

>From my reading of the above thread, putting the proposed workaround into
serial core will indeed allow people's machines to keep running while
reminding us about the driver bugs.
