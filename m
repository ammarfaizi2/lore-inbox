Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVAXPnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVAXPnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 10:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVAXPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 10:43:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52239 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261303AbVAXPnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 10:43:31 -0500
Date: Mon, 24 Jan 2005 15:43:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: ARM undefined symbols.  Again.
Message-ID: <20050124154326.A5541@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

Where did the hacks go which detect the silent failure of the ARM binutils?

I'm asking because I've just spent all of today trying to work out why
the hell code isn't working, only to find that it's all down to the
toolchain problem not being detected by kbuild.  IOW, the code sequence:

        mov     r0, #CR1A_SMPE

where CR1A_SMPE is undefined, assembles to:

c001224c:       e3a00000        mov     r0, #0  ; 0x0

without any warnings or errors, and links a successful kernel, leaving
this in System.map:

         U CR1A_SMPE

I absolutely must have the kernel build system detecting this binutils
problem when it occurs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
