Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264824AbUD1Ogk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbUD1Ogk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUD1Ogk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:36:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11282 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264826AbUD1Ogf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:36:35 -0400
Date: Wed, 28 Apr 2004 15:36:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] 2.6.6-rc3: make xxx_defconfig randomly sets options
Message-ID: <20040428153632.D24948@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040428145316.C24948@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040428145316.C24948@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Wed, Apr 28, 2004 at 02:53:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 02:53:16PM +0100, Russell King wrote:
> If I have an ARM defconfig file which contains:
> 
> # CONFIG_SERIO is not set
> 
> with none of the other CONFIG_SERIO symbols, and I run make foo_defconfig,
> I get the following in the resulting .config:
> 
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y

Argh, I had CONFIG_MOUSE_PS2 still selected, which was forcing
CONFIG_SERIO=y, and I incorrectly assumed that CONFIG_SERIO_I8042
would depend on CONFIG_SERIO.  But then, we are catering for Aunt
Tillie and not providing something with a logical structure... 8/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
