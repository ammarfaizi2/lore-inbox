Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262739AbSI1IA7>; Sat, 28 Sep 2002 04:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262740AbSI1IA7>; Sat, 28 Sep 2002 04:00:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52238 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262739AbSI1IA6>; Sat, 28 Sep 2002 04:00:58 -0400
Date: Sat, 28 Sep 2002 09:06:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysrq on serial console
Message-ID: <20020928090617.A32639@flint.arm.linux.org.uk>
References: <3D94ED88.5040407@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D94ED88.5040407@us.ibm.com>; from haveblue@us.ibm.com on Fri, Sep 27, 2002 at 04:45:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 04:45:12PM -0700, Dave Hansen wrote:
> It looks like the UART_LSR_BI bit needs to be set in the status 
> variable for the break character to be interpreted as a break in the 
> driver.

That is correct; that is how the UART reports a break character.

> I doubt that it is actually broken,  but it isn't immediately obvious 
> how that bit gets set.  Is there something that I should have set when 
> the device was initialized to make sure that UART_LSR_BI is asserted 
> in "status" when the interrupt occurs?

Now.  Its a status bit from the UART LSR register itself, read from
serial8250_handle_port() and receive_chars().  It will cause an
interrupt any time that the receive interrupt is enabled, ie when
the port is open by user space.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

