Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312791AbSDSSrM>; Fri, 19 Apr 2002 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSDSSrL>; Fri, 19 Apr 2002 14:47:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312791AbSDSSrL>; Fri, 19 Apr 2002 14:47:11 -0400
Date: Fri, 19 Apr 2002 19:47:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: printk in init_module mixing with printf in insmod
Message-ID: <20020419194703.A28850@flint.arm.linux.org.uk>
In-Reply-To: <3CC06470.F05543C4@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 11:39:44AM -0700, Dan Kegel wrote:
> I suppose this isn't terribly important, since printk's are
> kind of a no-no in production, and this only affects printk's
> in init_module, but it'd be nice to know what
> the cleanest way to get rid of the mixing is.  Adding a sleep
> inside insmod seems heavyhanded.  I suppose I could redirect
> insmod's output to a file, sleep a bit, and then display the 
> file... bleah.

Output from a program to a serial port is buffered, and is thus
asynchronous to the program.  printk output is synchronous, and as
such will interrupt the normal IO to the port.

If you're going to use delays, you need to take account of the serial
port baud rate and adjust the delay accordingly.  However, you don't
really know how many characters are pending in the kernel anyway.

I don't think there's an answer to this if you're going to run both
applications and kernel console on the same port.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

