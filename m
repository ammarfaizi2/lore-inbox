Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUCWKbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUCWKbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:31:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262451AbUCWKbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:31:06 -0500
Date: Tue, 23 Mar 2004 10:31:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christof <mail@pop2wap.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: synchronous serial port communication (16550A)
Message-ID: <20040323103102.B23349@flint.arm.linux.org.uk>
Mail-Followup-To: Christof <mail@pop2wap.net>, linux-kernel@vger.kernel.org
References: <40600CDD.5050807@pop2wap.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40600CDD.5050807@pop2wap.net>; from mail@pop2wap.net on Tue, Mar 23, 2004 at 11:09:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:09:33AM +0100, Christof wrote:
> To make the story short: I see a lot of garbage on the LCD.
> It looks like output would be buffered and all data would be sent at
> once without giving me the possibility to check if everything's
> allright. Sometimes I can send >400 Bytes and ioctl says that CTS is not
> asserted, altough it certainly is.

It probably isn't, at the time you check it.  When you write a byte,
the call will generally return immediately because it'll be placed in
a buffer.  Transmission has only just started, and you then go and check
the CTS line.  Repeat multiple times on a slow enough baud rate, and
you'll end up queueing a lot of bytes.

You could write a byte, wait for it to complete by calling ioctl(TCSETSW)
without changing any parameters, and then read the CTS status.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
