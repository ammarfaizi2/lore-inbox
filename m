Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264517AbSIQT0Q>; Tue, 17 Sep 2002 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264520AbSIQT0P>; Tue, 17 Sep 2002 15:26:15 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:21232 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S264517AbSIQT0K>; Tue, 17 Sep 2002 15:26:10 -0400
Message-ID: <794826DE8867D411BAB8009027AE9EB913D03F15@fmsmsx38.fm.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Benjamin LaHaise'" <bcrl@redhat.com>, linux-aio@kvack.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: libaio 0.3.92 test release
Date: Tue, 17 Sep 2002 12:31:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

several questions regarding to aio-20020916 release:

In fs/aio.c, it doesn't appear that the API as well as the implementation
are sync'ed up with what's in 2.5.x.  And this leads to the following
discrepancy compare to what's in 2.5:

  1. The min_nr semantics in io_getevents() doesn't appear to be merged
correctly in this release.
  2. lookup_kiocb() still doesn't look right.
  3. sys_io_cancel() missing argument "struct io_event *result".
  4. kiocb is still pre-allocated on sys_io_setup while in 2.5, it is not.

Is there another release (hopefully soon) to sync up fs/aio.c with 2.5? or
is it going to be never?

- Ken Chen


-----Original Message-----
From: Benjamin LaHaise [mailto:bcrl@redhat.com]
Sent: Monday, September 16, 2002 7:12 PM
To: linux-aio@kvack.org
Cc: Linux Kernel
Subject: libaio 0.3.92 test release


Hello folks,

I've just uploaded the libaio 0.3.92 test release to kernel.org.  Most 
notably, this release passes a few basic tests on ia64, and should work 
on x86-64 too (but isn't tested).  An updated kernel patch can be found
in /pub/linux/kernel/people/bcrl/aio/patches/testing/aio-20020916.diff 
which uses the registered syscall ABI (no more dynamic syscalls), fixes 
a bug in io_submit that allowed iocbs to be read from kernel memory 
(that bug is not present in RH 2.1AS; the fix was lost in the 2.4.18 
merge), fixes an occasional hang caused by timers not being unregistered 
in io_getevents, and probably introduces a few other bugs.  This is a 
test release as I still have to split up the patches into -stable, 
-alpha and -developement to prevent people from shipping experimental 
code that was never meant to be used on production machines.  In any 
case, if people could give this a whirl and submit reports to 
linux-aio@kvack.org, it would be appreciated.  My hit list still 
includes getting ARM, PPC, S/390, SPARC and m68k support merged into 
libaio, so if anyone cares to provide patches, I'd appreciate it.  Cheers,

		-ben
--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
