Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263609AbTCNUc1>; Fri, 14 Mar 2003 15:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263610AbTCNUc0>; Fri, 14 Mar 2003 15:32:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263609AbTCNUcZ>; Fri, 14 Mar 2003 15:32:25 -0500
Date: Fri, 14 Mar 2003 20:43:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: EdV@macrolink.com, driver@jpl.nasa.gov, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030314204311.J23686@flint.arm.linux.org.uk>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>, EdV@macrolink.com,
	driver@jpl.nasa.gov, dwmw2@infradead.org,
	linux-kernel@vger.kernel.org
References: <200303142028.MAA02437@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303142028.MAA02437@adam.yggdrasil.com>; from adam@yggdrasil.com on Fri, Mar 14, 2003 at 12:28:47PM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 12:28:47PM -0800, Adam J. Richter wrote:
> There was tangential mention in that thread
> of a "/proc/serialdev" interface, but nobody really identified any
> real benefit to it over the existing "uart: unknown" system.

There is one benefit, which would be to get rid of some of the yucky
mess we currently have surrounding the implementation of stuff which
changes the port base address/irq.

Currently, we have to check that we're the only user, shutdown, tweak
stuff, hope it all goes to plan, and start stuff back up again.  If
something fails, we have to pray we can go back to the original setup
without stuff breaking.  If that fails, we mark the port "unknown".

All of this would be a lot simpler if we didn't have the port actually
open at the time we change these parameters.  We could just lock the
port against opens, check no one was using it, tweak the settings,
and release the port.  If the changes fail, just report the failure.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

