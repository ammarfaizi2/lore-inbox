Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVKAHwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVKAHwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVKAHwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:52:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54540 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932564AbVKAHwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:52:44 -0500
Date: Tue, 1 Nov 2005 07:52:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       ak@suse.de, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051101075229.GB22053@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
	ak@suse.de, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
	linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org> <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 04:13:22PM -0800, Linus Torvalds wrote:
> On Mon, 31 Oct 2005, Andrew Morton wrote:
> > Are you sure these kernels are feature-equivalent?
> 
> They may not be feature-equivalent in reality, but it's hard to generate 
> something that has the features (or lack there-of) of old kernels these 
> days. Which is problematic.
> 
> But some of it is likely also compilers. gcc does insane padding in many 
> cases these days. 
> 
> And a lot of it is us just being bloated. Argh.

Which is one of the reasons I've started working on fixing up the
platform device/driver stuff to conform to the "usual" method,
with the view to killing off _all_ the function pointers in
struct device_driver.

Most bus types wrap struct device_driver, and then provide their own
function pointers which pass their bus-type specific device structure.
This does two things: 1. it centralises the conversion from struct
device to struct whatever_device, and 2. improves typechecking.

However, once the use of the function pointers in struct device_driver
have been eliminated, we can be sure of reclaiming at least 20 bytes
per device driver, maybe more if GCC does insane padding.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
