Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSGVQOr>; Mon, 22 Jul 2002 12:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSGVQOr>; Mon, 22 Jul 2002 12:14:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49668 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317546AbSGVQOq>; Mon, 22 Jul 2002 12:14:46 -0400
Date: Mon, 22 Jul 2002 17:17:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [MOAN] CONFIG_SERIAL_CONSOLE
Message-ID: <20020722171753.H2838@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Tom for spotting this.

We seem to have configuration breakage in several architectures regarding
CONFIG_SERIAL_CONSOLE.  This option began life to select the serial console
code in serial.c, and had its own "bool" option in drivers/char/Config.in

However, several architectures seem to be using this to select similar
code in their serial drivers by the following method (eg, from ppc):

if [ "$CONFIG_8260" = "y" ]; then
   define_bool CONFIG_SERIAL_CONSOLE y
   choice 'Machine Type'        \
        "EST8260        CONFIG_EST8260  \
         SBS8260        CONFIG_SBS8260  \
         RPXSUPER       CONFIG_RPX6     \
         TQM8260        CONFIG_TQM8260  \
         Willow         CONFIG_WILLOW"  Willow
fi

Since ppc also include{s,d} drivers/char/Config.in, this means there was
a define_bool _and_ bool for the same configuration variable.  This sounds
contary to the shell-nature of the configure scripts, and therefore illegal,
and as such gets broken when changes happen.

Firstly, these platform specific serial drivers need to be ported to the
new serial driver (cvs available...)  They can then use
CONFIG_SERIAL_CORE_CONSOLE to indicate whether a serial console has been
built into the kernel or not.  But please don't go and hijack this
configuration symbol like you did the CONFIG_SERIAL_CONSOLE symbol.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

