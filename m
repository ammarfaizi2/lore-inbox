Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVCAXhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVCAXhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVCAXhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:37:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262125AbVCAXh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:37:26 -0500
Date: Tue, 1 Mar 2005 23:37:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/serial/8250.c:1256!
Message-ID: <20050301233720.B17470@flint.arm.linux.org.uk>
Mail-Followup-To: Karol Kozimor <sziwan@hell.org.pl>,
	linux-kernel@vger.kernel.org
References: <20050301230946.GA30841@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050301230946.GA30841@hell.org.pl>; from sziwan@hell.org.pl on Wed, Mar 02, 2005 at 12:09:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 12:09:46AM +0100, Karol Kozimor wrote:
> I've finally got around to test latest kernels and managed to find a bug in 
> the serial subsystem, which happens during suspend.

Yes, serial_cs is claiming that we don't have a device associated with
the port, so we're treating it as a legacy port.  However, serial_cs is
implementing the suspend/resume methods.  This is wrong, since that
means the port will be suspended twice, and hence causes this bug.

serial_cs needs to register the ports along with the PCMCIA device with
which the port belongs to.  This will stop it being treated as a legacy
serial port.

Unfortunately, it's too late tonight for me to dig into PCMCIA to work
out how we get at the device structure - I can't find any examples off
hand either.  Therefore, it may be a while before I can produce a patch
to resolve this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
