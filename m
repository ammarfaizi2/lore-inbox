Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUCSPaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUCSPaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:30:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59409 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263005AbUCSPaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:30:15 -0500
Date: Fri, 19 Mar 2004 15:30:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org, ranty@debian.org
Subject: Re: 2.6.xx - linux/firmware.h - missing include
Message-ID: <20040319153008.D14431@flint.arm.linux.org.uk>
Mail-Followup-To: Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org, ranty@debian.org
References: <5.1.0.14.2.20040319155257.00ac0af8@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20040319155257.00ac0af8@pop.t-online.de>; from margitsw@t-online.de on Fri, Mar 19, 2004 at 04:17:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 04:17:45PM +0100, Margit Schubert-While wrote:
> The prototype for request_firmware uses a struct device parameter.
> This is only defined if linux/device.h is included.
> Fix is simple : include linux/device.h in linux/firmware.h

That way leads to madness in the includes.  firmware.h does not need
the definition of struct device, it only needs to know that struct
device exists.

You can do this via:

struct device;

before its use - this works much the same way as a function declaration
vs. function prototype.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
