Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSBCAdk>; Sat, 2 Feb 2002 19:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBCAdc>; Sat, 2 Feb 2002 19:33:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53009 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284305AbSBCAdR>; Sat, 2 Feb 2002 19:33:17 -0500
Date: Sun, 3 Feb 2002 00:33:09 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Christoph Bartelmus <columbus@hit.handshake.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: serial port driver grabs occupied port
Message-ID: <20020203003309.E19201@flint.arm.linux.org.uk>
In-Reply-To: <8IBS9f7Xz9B@hit-columbus.hit.handshake.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8IBS9f7Xz9B@hit-columbus.hit.handshake.de>; from columbus@hit.handshake.de on Sat, Feb 02, 2002 at 11:21:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 11:21:00PM +0000, Christoph Bartelmus wrote:
> Now the problem:
> 3. Open the /dev/ttySx for the port that is occupied by the lirc_serial  
> module. rs_open() does not check the state of the serial port and returns  
> no error. Now you can use setserial to hijack the port... lirc_serial  
> stops working.

One of setserial's basic functions is to configure a ttyS device for a
serial port that you know is there.  In this patch, you are preventing
any port that is in 'PORT_UNKNOWN' state from being changed, even if
you want to change the IRQ and IO base address.  This is a different,
but nevertheless fundamental problem.

The real bug is that serial.c should allows you to change the port from
'PORT_UNKNOWN' even when it can't grab the resources for the port.
Thanks for finding it - are you able to work on this more to come up
with a better fix?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

