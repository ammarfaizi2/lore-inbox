Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVBZOqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVBZOqp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 09:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBZOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 09:46:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33800 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261187AbVBZOqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 09:46:39 -0500
Date: Sat, 26 Feb 2005 14:46:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050226144635.B7151@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050226133337.GK3311@stusta.de>; from bunk@stusta.de on Sat, Feb 26, 2005 at 02:33:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 02:33:37PM +0100, Adrian Bunk wrote:
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Please don't deprecate this symbol.  ARM has a large variety of RTC
implementations, some of which reside in I2C modules which are yet
to be merged.

Firstly, these aren't accessible until the i2c subsystem has been
initialised.  Secondly, i2c is modular, so this function must be
accessible from a module in order for the system time/date to be
initialised from the RTC with a modular build.

(It can be argued that you wouldn't want to build such a thing as a
module in the first place, in which case removing the export would
of course be fine.  However, we can't sanely force I2C to be either
always builtin, and placing this expectation on people will eventually
lead other janitors to complain that the symbol is used by modules but
isn't exported.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
