Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbRGYTqO>; Wed, 25 Jul 2001 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268621AbRGYTqF>; Wed, 25 Jul 2001 15:46:05 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:33292 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S267248AbRGYTpq>; Wed, 25 Jul 2001 15:45:46 -0400
To: linux-kernel@vger.kernel.org
Subject: my patches won't compile under 2.4.7
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 25 Jul 2001 15:45:46 -0400
In-Reply-To: <E15PU4j-0002Xw-00@the-village.bc.nu>
Message-ID: <x7itgglrmd.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

As of 2.4.7 my patches to the kernel won't compile.  It appears to be
something to do with devfs_fs_kernel.h being part of miscdevices.h.  I
have sifted through the code but have not been able to determine
exactly why they won't work any more.  Here is the error output from
my compile:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o speakup.o speakup.c
In file included from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from speakup.c:63:
/usr/src/linux/include/linux/pagemap.h:35: `currcons' undeclared here (not in a function)
/usr/src/linux/include/linux/pagemap.h:35: parse error before `.'
make[4]: *** [speakup.o] Error 1

I'm not sure even where to start trying to describe what I've looked
at and what I don't understand.  It appears that page_cache_alloc() is
now an inline function with an argument passed to it, where it used to
be a #define with no arguments.  I see that struct misc_device now has
a new member devfs_handle but the other drivers I've looked at rtc.c
haven't changed their structure members to take this into account.  It
seems nothing new is necessary because misc_register checks if it's
been set or not.  The two error lines don't look to me to have anything
to do with any of these things either currcons isn't used in any of
the misc_device structure or anything I can see which might end up
calling page_cache_alloc().  Can anyone give me any ideas what I
should check to hunt down exactly what's going on here?  It almost
looks like gcc is getting screwed up in it's parsing or something.

Any ideas will greatefully be accepted I'm lost!

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
