Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWIYVL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWIYVL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWIYVL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:11:29 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:32787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751354AbWIYVL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:11:28 -0400
Date: Mon, 25 Sep 2006 22:11:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: dwalker@mvista.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] console: console_drivers not initialized
Message-ID: <20060925211122.GC25257@flint.arm.linux.org.uk>
Mail-Followup-To: dwalker@mvista.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060925210710.931336000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925210710.931336000@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:07:10PM -0700, dwalker@mvista.com wrote:
> I was doing -rt stuff on a PPC PowerBook G4. It would always reboot
> itself when it hit console_init() .
> 
> I noticed that the console code seems to want console_drivers = NULL,
> but it never actually sets it that way. Once I added this, the reboot 
> issue was gone..

It's a BSS variable, it _should_ be zeroed by the architecture's BSS
initialisation.  If not, it suggests there's something very _very_
wrong in the architecture's C runtime initialisation code.

As such, this patch is merely a band-aid, not a correct fix.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
