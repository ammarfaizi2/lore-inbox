Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbTICQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTICQGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:06:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21767 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263815AbTICQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:05:10 -0400
Date: Wed, 3 Sep 2003 17:05:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: CPU dependent inline in 8250 serial drivers
Message-ID: <20030903170505.C24951@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20030903142758.GA23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030903142758.GA23729@fs.tum.de>; from bunk@fs.tum.de on Wed, Sep 03, 2003 at 04:27:59PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 04:27:59PM +0200, Adrian Bunk wrote:
> drivers/serial/8250.h in 2.6 contains the following:
> 
> <--  snip  -->
> 
> ...
> #if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
> #define SERIAL_INLINE
> #endif
>   
> #ifdef SERIAL_INLINE
> #define _INLINE_ inline
> #else
> #define _INLINE_
> #endif
> ...
> 
> <--  snip  -->
> 
> Why should these functions be inlined only for 386 and 486 CPUs but not 
> for more recent CPUs or other architectures?

The old serial.c did that as well - its mainly there so we don't go
overboard and inline stuff when it isn't necessary.  From what I
remember when this was discussed some time ago, 386 and 486 performs
better when they have the interrupt handling as one function, but
other CPUs perform better when the code is out of line.

Since people tend to care about getting good performance from their
serial ports, I preserved this trick.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

