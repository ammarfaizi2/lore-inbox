Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271183AbTHLVyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271185AbTHLVyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:54:17 -0400
Received: from gate.firmix.at ([80.109.18.208]:19921 "EHLO buffy.firmix.at")
	by vger.kernel.org with ESMTP id S271183AbTHLVyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:54:16 -0400
Subject: Re: generic strncpy - off-by-one error
From: Bernd Petrovitsch <bernd@firmix.at>
To: Anthony Truong <Anthony.Truong@mascorp.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060708460.12532.59.camel@dhcp22.swansea.linux.org.uk>
References: <1060653362.5294.58.camel@huykhoi> 
	<1060708460.12532.59.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 12 Aug 2003 23:53:58 +0200
Message-Id: <1060725239.1500.22.camel@gimli.at.home>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 19:14, Alan Cox wrote:
> On Maw, 2003-08-12 at 02:56, Anthony Truong wrote:
> > Thanks for pointing that out to me.  However, I don't think the kernel
> > strncpy implementation is exactly the same as that of Standard C lib
> 
> It is true it doesnt need to be

Nevertheless it is defined the inefficient way by the C-Standard and
lots of people actually really know this.
So IMHO (re)implementing a function called "strncpy" differently doesn't
make much sense.

> > implementation.  Iwas just looking at it from the kernel code context. 

The kernel is implemented in C. And the function strncpy() _is_ already
defined by C. So please use at least another name. Given the existence
of strlcpy() -  http://www.courtesan.com/todd/papers/strlcpy.html- this
problem already has been solved.

> > There's a point in doing it the "kernel" way, to save precious CPU
> > cycles from being wasted otherwise.
> 
> CPU cycles, got lots of those 8). If its going to do anything it might
> be to reference an extra cache line. For people who dont need padding
> 2.6 has strlcpy. Lots of drivers assume strncpy fills the entire block

ACK. To use strlcpy() is correct solution (if padding is not required).

	Bernd

