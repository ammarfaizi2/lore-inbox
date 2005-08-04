Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVHDO3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVHDO3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVHDO3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:29:16 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:54907 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261849AbVHDO3I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:29:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LzfuZ62HeNx0Qtcrt5/QYT1wluBCL+WNSQohqqfHhtJQWYcXUxGyOILuLjrgTsY5VHs5m2ABuXo6JqGCS4kyOPoyWI62HxgW2+mwckmcgRHwKksUx4OPvW3LvyUa5fZWQPqMX4pueC9LXbwt7Fj+OQPjmPOxIhzhl9pkG0Pjrms=
Message-ID: <92fc8b8105080407297d8ced80@mail.gmail.com>
Date: Thu, 4 Aug 2005 07:29:06 -0700
From: Chris Budd <budorola@gmail.com>
Reply-To: Chris Budd <budorola@gmail.com>
To: Chris Budd <budorola@gmail.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: 2.4.21: Sharing interrupts with serial console
In-Reply-To: <20050804085440.A22910@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <92fc8b8105080318367f77fed1@mail.gmail.com>
	 <20050804085440.A22910@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Aug 03, 2005 at 06:36:51PM -0700, Chris Budd wrote:
> > 1.  The rs_init function in ./linux-2.4.21/drivers/char/serial.c
> > explicitly states "The interrupt of the serial console port can't be
> > shared."  Does this include *ALL* interrupts?  The code checks for
> > sharing only with other serial devices, not *ALL* types of devices
> > like I2C, RTC, etc.
<snip>
> > 2.  While the presence of the comment about not sharing was nice, it
> > does not explain "why?"
> 
> Connecting a level-active interrupt output to an edge-triggered
> interrupt controller input is Bad News(tm) for missing interrupts.
> 

Of course.  I thought it was something more serious in the bowels of
the kernel.  All the comment needed was just that one adjective "The
*edge-triggered* interrupt of the serial console port can't be
shared."  I know many programmers do not like to write comments, but
good comments make the code more robust and stable:  the code clearly
shows *what* you did, but comments are necessary to indicate *why*.

<snip>
> If your Intel hardware doesn't have level triggered input capabilities,
> please apply customer pressure to Intel to ensure that they consider it
> for their future ARM-based designs.

You will be happy to know that the Intel IOP80321 has level-sensitive
interrupts.

Thank you for the detailed explanation.
Chris.
