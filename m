Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267002AbRGMKqR>; Fri, 13 Jul 2001 06:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbRGMKqH>; Fri, 13 Jul 2001 06:46:07 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:40165 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S267002AbRGMKpu>; Fri, 13 Jul 2001 06:45:50 -0400
Date: Fri, 13 Jul 2001 11:45:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [initramfs] wait_for_keypress() and ->wait_key()
Message-ID: <20010713114545.C970@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.21.0107121851430.15756-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0107121851430.15756-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Jul 12, 2001 at 08:00:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 08:00:27PM -0400, Alexander Viro wrote:
> ... On some of them (e.g. serial console) it actually
> eats the character it had receieved.
> ...
> 	Better yet, attach a VT220 to serial console and press any key that
> would send multiple characters. Yup, that will eat one of them. Have fun
> if you call wait_for_keypress() more than once. (On a normal keyboard
> the effect will differ - next call will block).

We could get round this easily by draining the serial port of charactesr
on entry to the wait_key method.  This would mean that the user would
have to press the key after the message has been displayed, which I don't
think is unreasonable, and probably reflects the keyboard behaviour more
accurately.

Note that as long as the device (whether it be VT or serial port) isn't
actually open, the characters pressed will be discarded in both the serial
port and keyboard case, so its not like you're storing up trouble later on.
Currently that is the case.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

