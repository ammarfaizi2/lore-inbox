Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbRGPPjt>; Mon, 16 Jul 2001 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbRGPPjk>; Mon, 16 Jul 2001 11:39:40 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:45330 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S267429AbRGPPjY>;
	Mon, 16 Jul 2001 11:39:24 -0400
Message-Id: <200107161539.JAA183448@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: Too much memory causes crash when reading/writing to disk
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Mon, 16 Jul 2001 09:39:28 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have done a bit more work on the problem I reported in my message
"Crashes reading and writing to disk".  To recap, on a machine with
8GB of RAM, either 

dd if=/dev/zero bs=1G count=10 | split -b 1073741824

or

find /bigfulldisk -type f -exec cat {} \; > /dev/null

can reliably cause a crash.  In my naive view, it seems like once a
certain amount of memory is being completely used for disk buffer
(cache, whatever, excuse my not knowing the proper term) the kernel
gets very confused and dies.  The dd dies after having written about
4.5GB.

Booting the machine with mem=3000M avoids the crashes.  I haven't done
a binary search to determine what the maximum amount of memory I can
use is before the problem exhibits itself.  Hopefully this provides a
hint as to what could be causing the problem.  If any more information
would be useful, please ask.

To go along with this, are there any parameters in /proc/sys/vm/* that
I could tune to avoid these crashes?

--
Thanks,
Jeff Lessem.
