Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUGAMxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUGAMxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUGAMxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:53:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6920 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264833AbUGAMxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:53:04 -0400
Date: Thu, 1 Jul 2004 13:52:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701135258.A5225@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org,
	Michael Kerrisk <michael.kerrisk@gmx.net>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040701032606.GA1564@mail.shareable.org>; from jamie@shareable.org on Thu, Jul 01, 2004 at 04:26:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 04:26:06AM +0100, Jamie Lokier wrote:
> When running it on i386, I got a *huge* surprise (to me).  A
> PROT_WRITE-only page can sometimes fault on read or exec.  This is the
> output:
> 
> Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
> ========================================================================
> MAP_SHARED     | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx
> MAP_PRIVATE    | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx
> 
> The "!" means that a read or exec *sometimes* raises a signal.

Here are the ARM results:

Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx
MAP_PRIVATE    | ---    r-x    !w!    rwx    r-x    r-x    rwx    rwx

As expected, the same as x86 since we have the same situation there -
we can not represent the write-only page permission in hardware.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
