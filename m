Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289772AbSAJXVm>; Thu, 10 Jan 2002 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSAJXVc>; Thu, 10 Jan 2002 18:21:32 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:10003 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289772AbSAJXVV>;
	Thu, 10 Jan 2002 18:21:21 -0500
Date: Thu, 10 Jan 2002 15:18:49 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: [RFC] klibc requirements, round 2
Message-ID: <20020110231849.GA28945@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok, now that we have a general idea that people are going to want to
stick lots of different types of programs into the initramfs, does this
change any of the initial requirement list for klibc that I sent out?

To summarize, here's a partial list of the programs people want to run:
	- mount
	- hotplug
	- busybox
	- dhcpcd
	- image viewer
	- mkreiserfs
	- partition discovery (currently in the kernel)
	- lots of other, existing in kernel code.

So on to the requirements:
  1) portable
     This is still true.
     
     dietlibc and uClibc currently do not cover the
     range of platforms that this code must run on.  For either of them
     to be used, they must be worked on.

  2) tiny
     Still true.
     
     For some people, glibc will be acceptable.  For the rest of us, we
     want something a bit smaller :) Both uClibc and dietlibc fit this
     requirement.

  3) dynamic version available
     Probably not true anymore.
     In talking with lots of people, and playing with the dynamic
     linking capabilities of different libraries, I don't think this is
     worth having as a requirement for this kind of library.

  4) not suck
     Still true :)


So, what's the available options to try to meet these requirements?

Here's some proposed solutions:
  - dietlibc / uClibc
    Nice options.  Both of these libraries are already fairly complete.
    One drawback is they are not portable to all platforms.  With some
    work, this can probably be solved.

  - klibc
    Portability can be achieved through using the kernel unistd.h file
    for the syscall logic, and having a very small _start function
    written.  For an example of this kind of code, see the initramfs
    patches from Al Viro on his ftp site:
	    ftp://ftp.math.psu.edu/pub/viro/
    This would involve writing/porting a lot of the basic library
    functions.  They could be copied from the existing libc
    implementations, but this would be a separate project, requiring
    maintenance over time, and people willing to do the work.

Is this all a good summary?  Any other comments from people?

How about responses from the dietlibc and uClibc people on the odds of
them being able to port to the remaining platforms?

In the meantime, I'll go off and play with klibc, and see if I can get
some portability based off of Al's example code.  If anyone is
interested, the code can be found at:
	http://linuxusb.bkbits.net:8088/klibc

thanks,

greg k-h
