Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTILQXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTILQXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:23:41 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:20370 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261754AbTILQXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:23:40 -0400
Date: Fri, 12 Sep 2003 17:22:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Anthony Dominic Truong <anthony.truong@mascorp.com>
Cc: linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912162254.GA2719@mail.jlokier.co.uk>
References: <20030911192550.7dfaf08c.ak@suse.de> <1063308053.4430.37.camel@huykhoi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063308053.4430.37.camel@huykhoi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Dominic Truong wrote:
> Wouldn't it be better if we set the IN and OUT function pointers to the
> right functions during driver init. based on the setting of dev->mmio.
> And throughout the driver, we just call the IN and OUT functions by
> their pointers.  Then we don't have to do if (dev->mmio) every time.
> It's similar to the concept of virtual member function in C++.

I think it would be faster to hide the "if (mmio)" part into an
inline function which calls one or the other, given a resource cookie.

Branch prediction will remove most of the cost of a conditional test,
which is always the same in these drivers after all, but I don't think
it's quite so good at predicting indirect function calls.

-- Jamie
