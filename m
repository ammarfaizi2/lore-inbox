Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312443AbSDSTu3>; Fri, 19 Apr 2002 15:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSDSTu2>; Fri, 19 Apr 2002 15:50:28 -0400
Received: from relay1.pair.com ([209.68.1.20]:30213 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S312443AbSDSTu1>;
	Fri, 19 Apr 2002 15:50:27 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CC07542.45E5267D@kegel.com>
Date: Fri, 19 Apr 2002 12:51:30 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: printk in init_module mixing with printf in insmod
In-Reply-To: <3CC06470.F05543C4@kegel.com> <20020419194703.A28850@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Apr 19, 2002 at 11:39:44AM -0700, Dan Kegel wrote:
> > I suppose this isn't terribly important, since printk's are
> > kind of a no-no in production, and this only affects printk's
> > in init_module, but it'd be nice to know what
> > the cleanest way to get rid of the mixing is.  Adding a sleep
> > inside insmod seems heavyhanded.  I suppose I could redirect
> > insmod's output to a file, sleep a bit, and then display the
> > file... bleah.
> 
> Output from a program to a serial port is buffered, and is thus
> asynchronous to the program.  printk output is synchronous, and as
> such will interrupt the normal IO to the port.
> 
> If you're going to use delays, you need to take account of the serial
> port baud rate and adjust the delay accordingly.  However, you don't
> really know how many characters are pending in the kernel anyway.

Thanks for the info.

For now, I'm just kludging in a sleep(1) in insmod right after
the print, as a temporary fix for my particular needs.  Saves
me editing lots of source files, and it "works" for this particular
situation.

> I don't think there's an answer to this if you're going to run both
> applications and kernel console on the same port.

insmod is run by /etc/init.d/rcS, so it's kind of unavoidable.
But I'm happy with my little private kludge for now.
- Dan
