Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283599AbRK3K5y>; Fri, 30 Nov 2001 05:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283601AbRK3K5p>; Fri, 30 Nov 2001 05:57:45 -0500
Received: from [212.18.232.186] ([212.18.232.186]:14852 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283599AbRK3K5d>; Fri, 30 Nov 2001 05:57:33 -0500
Date: Fri, 30 Nov 2001 10:56:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: randall@uph.com, Balbir Singh <balbir_soni@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011130105633.A18992@flint.arm.linux.org.uk>
In-Reply-To: <200111291803.fATI37q08404@sword.damocles.com> <Pine.GSO.3.96.1011130112041.15249C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011130112041.15249C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Nov 30, 2001 at 11:44:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 11:44:14AM +0100, Maciej W. Rozycki wrote:
>  Here is a fix I'm using for 2.4.  It was submitted to Alan once, then a
> discussion was performed with a conclusion like "that may be a temporary
> fix for 2.4, but it needs a complete rework for 2.5".  I'm not sure if the
> patch went in anywhere.

Have you audited all the tty drivers in 2.4 to make sure that they clean
up safely?

I don't believe the serial code will clean up safely as it stands for
starters if block_til_ready in serial.c fails, leaving an interrupt
in use.  Further attempts to open the serial device will probably fail.

Try this as any user with your patch applied:

$ stty -clocal -F /dev/ttyS0
$ cat /proc/interrupts
$ cat /dev/ttyS0
^c
$ cat /proc/interrupts

I think you'll find your serial port interrupt is still claimed, despite
the module being marked as not in use.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

