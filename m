Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUEaD7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUEaD7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 23:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUEaD7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 23:59:11 -0400
Received: from waste.org ([209.173.204.2]:59554 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264527AbUEaD7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 23:59:08 -0400
Date: Sun, 30 May 2004 22:59:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
Message-ID: <20040531035900.GB5414@waste.org>
References: <200405310152.i4V1qNk03732@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405310152.i4V1qNk03732@mailout.despammed.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 08:52:23PM -0500, ndiamond@despammed.com wrote:

> A driver, implemented as a module, must do some floating-point
> computations including trig functions. Fortunately the architecture
> is x86. A few hundred kilograms of searching (almost a ton of
> searching :-) seems to reveal the following possibilities.

[bizarre method deleted]

How about:

mask off interrupts locally
save floating point state
do floating point work
restore floating point state
restore interrupt mask

You will need to take care that you keep gcc from using library
functions, see the gcc manual.

Another approach is to do it all in fixed point, which is a simple
matter of doing some shifts after your multiplies. This only works if
you've got a fairly small dynamic range, but if you only need to
calculate a sine or two, it's not too painful and you can have about
8-10 decimal digits of accuracy. Or you can go quick and dirty with a
piecewise polynomial approximation for 2-5 digits of accuracy.

-- 
Mathematics is the supreme nostalgia of our time.
