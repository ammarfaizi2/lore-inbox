Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVBCSZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVBCSZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263431AbVBCSYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:24:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:33456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262720AbVBCSWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:22:23 -0500
Date: Thu, 3 Feb 2005 10:21:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk+lkml@arm.linux.org.uk, e9925248@student.tuwien.ac.at,
       linux-kernel@vger.kernel.org
Subject: Re: Deadlock in serial driver 2.6.x
Message-Id: <20050203102112.06c06fe7.akpm@osdl.org>
In-Reply-To: <1107332396.14847.112.camel@localhost.localdomain>
References: <20050126132047.GA2713@stud4.tuwien.ac.at>
	<20050126231329.440fbcd8.akpm@osdl.org>
	<1106844084.14782.45.camel@localhost.localdomain>
	<20050130164840.D25000@flint.arm.linux.org.uk>
	<1107157019.14847.64.camel@localhost.localdomain>
	<20050131004857.07f5e2c4.akpm@osdl.org>
	<1107332396.14847.112.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2005-01-31 at 08:48, Andrew Morton wrote:
> > >  The tty layer cannot fix this for now, and I don't intend to fix it. Fix
> > >  the serial driver: the fix is quite simple since you can keep a field in
> > >  the driver for now to detect recursive calling into the echo case and
> > >  don't relock.
> > 
> > Are we sure that the serial driver is the only one which will hit this
> > deadlock?
> 
> Yes fairly sure. The feature has been a well known but non-documented
> property of the tty layer since about 1.0. There are two ways I see to
> clean it up - we
> can have the serial driver behave like other drivers and if need be
> known about
> recursive entries or we could extend the driver interface with an "echo"
> method used by line disciplines when calling back to the tty driver from
> a data
> receive event.

The "echo method" method sounds good.  Do we think that's feasible for
2.6.11, or would it be safer to disable low-latency mode for that driver?
