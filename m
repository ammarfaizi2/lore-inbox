Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBVXKI>; Thu, 22 Feb 2001 18:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBVXJ6>; Thu, 22 Feb 2001 18:09:58 -0500
Received: from phoenix.nanospace.com ([209.213.199.19]:40201 "HELO
	phoenix.nanospace.com") by vger.kernel.org with SMTP
	id <S129250AbRBVXJt>; Thu, 22 Feb 2001 18:09:49 -0500
Date: Thu, 22 Feb 2001 15:09:46 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use correct include dir for build tools
Message-ID: <20010222150946.D20997@thune.yy.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010222123940.A20319@tenchi.datarithm.net> <E14W4EP-00055G-00@the-village.bc.nu> <20010222144055.B20752@tenchi.datarithm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <20010222144055.B20752@tenchi.datarithm.net>; from rread@datarithm.net on Thu, Feb 22, 2001 at 02:40:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 02:40:55PM -0800, Robert Read wrote:
> Ok, my bad, I forgot about cross-compiles. The problem was
> scripts/split-include.c includes errno.h, which requires linux/errno.h
> to exist, and I thought it would be better to use the current kernel's
> version, rather than the system version. I guess not.

Oh no.  Definitely not.

Linus went on a tirade not too long ago about that.  You can search the
kernel archives for the details and long heated threads.  But it comes down
to this:

For user space compiling, the kernel include files should be those that
libc was built against.

For kernel space compiling, the kernel include files should be those that
the components will link against (static or modules).

So, theoretically, a package that has both components should take care to
do the proper includes.  But that's it.

(libc does usually take care to be able to build against a later kernel
version than you're running on, and determine at run time what features may
or may not be there, so one could have a 2.4.2 kernel handy to build libc
against while still running a 2.2.18 kernel.  Theoretically.)

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
