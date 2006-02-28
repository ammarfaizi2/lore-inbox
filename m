Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWB1SSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWB1SSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWB1SSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:18:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932388AbWB1SSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:18:44 -0500
Date: Tue, 28 Feb 2006 10:17:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-Id: <20060228101713.6fd44027.akpm@osdl.org>
In-Reply-To: <20060227141315.GD2429@ucw.cz>
References: <20060226100518.GA31256@flint.arm.linux.org.uk>
	<20060226021414.6a3db942.akpm@osdl.org>
	<20060227141315.GD2429@ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> 
> On Sun 26-02-06 02:14:14, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >
> > > Calling serial functions to flush buffers, or try to send more data
> > >  after the port has been closed or hung up is a bug in the code doing
> > >  the calling, not in the serial_core driver.
> > > 
> > >  Make this explicitly obvious by adding BUG_ON()'s.
> > 
> > If we make it
> > 
> > 	if (!info) {
> > 		WARN_ON(1);
> > 		return;
> > 	}
> > 
> > will that allow people's kernels to limp along until it gets fixed?
> 
> It will oops in hard-to-guess, place, anyway.

Will it?   Where?  Unfixably?

> BUG_ON is right.

WARN_ON+return is far better.  It keeps people's machines working until the
bug gets fixed.
