Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbSJMUzB>; Sun, 13 Oct 2002 16:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJMUzB>; Sun, 13 Oct 2002 16:55:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52485 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261838AbSJMUzA>; Sun, 13 Oct 2002 16:55:00 -0400
Date: Sun, 13 Oct 2002 22:00:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Anton Blanchard <anton@samba.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
Message-ID: <20021013220041.G23142@flint.arm.linux.org.uk>
References: <20021012014332.GA7050@krispykreme> <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Sun, Oct 13, 2002 at 01:40:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 01:40:50PM -0700, James Simmons wrote:
> Ugh!!! The reason I reworked the console system is because over the years
> hack after hack has been added. It now has lead to this twisted monster.
> Take a look at the fbdev driver codes in 2.4.X. Instead of another hack
> the console system should be cleaned up with a well thought out design to
> make the code base smaller and more effiencent.

There is a very good reason why stuff like this is needed.  Its to get
the boot messages out of a non-booting box, when you know that its oopsed
before fbcon can be initialised.

fbcon can't be initialised before PCI setup on many systems because the
PCI bus may not be setup, and therefore the VGA card may very well not
be accessible.

I think you'll find that virtually every architecture has some method
to get real early boot time messages out of the box in some way (on ARM,
it involves enabling CONFIG_DEBUG_LL and adding a function call into
printk.c, and attaching a machine to a serial port - this works from
the moment that we start executing any kernel image.)

You're not going to be able to design something to cover all cases.
Especially the ones where the normal C environment isn't up and running
yet. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

