Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbTCFQqK>; Thu, 6 Mar 2003 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268177AbTCFQqK>; Thu, 6 Mar 2003 11:46:10 -0500
Received: from fmr05.intel.com ([134.134.136.6]:25548 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S268174AbTCFQpO>; Thu, 6 Mar 2003 11:45:14 -0500
Subject: Re: [PATCH]Fix to the new sysfs bin file support
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0303060919520.994-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0303060919520.994-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Mar 2003 08:54:41 -0800
Message-Id: <1046969681.4169.28.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 07:34, Patrick Mochel wrote:
<snip> 
> > BTW, would you be totally opposed to a patch that added open, release,
> > and ioctl to the list of functions supported by sysfs binary files?
> 
> ->ioctl() - No. 
> 
> Why ->open() and ->release()? If we free the buffer in our release(), then 
> why do you need a notification? 

I was looking to see if I could use a sysfs bin file as a replacement
for the char device file used by watchdog drivers which need to:
1. know when the device file is opened in order to start the timer
2. know when the device file is released in order to stop the timer if
the nowayout option is not on

This also why I was asking for ioctl's.

Now I suspected that this was not the intended usage for a sysfs bin
file, but I wasn't sure.

> 
> > Another question... How would a driver know that the various write and
> > read calls are coming from the same open, or would there be a way for a
> > driver to make it so that only one thing can open the sysfs file at a
> > time?
> 
> I don't think you could know that a ->read() came from the same process as 
> the previous ->read(). Why would you need to know that?

I was under the impression that some existing device drivers could use
something from the file pointer to implement a session for a specific
open/close.  All I have ever done was to force only one process to open
my device file at a time so I would not have to worry about concurrent
sessions.

If I am mistaken about the ability to distinguish between different
processes, then no big deal, but it would be nice to be able to force
only one open at a time.  (Maybe a flag in bin_attribute?)

    --rustyl
> 
> Thanks,
> 
> 	-pat


