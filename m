Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUHUWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUHUWoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267983AbUHUWoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:44:13 -0400
Received: from web20823.mail.yahoo.com ([216.136.227.136]:57236 "HELO
	web20823.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267979AbUHUWoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:44:08 -0400
Message-ID: <20040821224408.87169.qmail@web20823.mail.yahoo.com>
Date: Sat, 21 Aug 2004 15:44:08 -0700 (PDT)
From: Fawad Lateef <fawad_lateef@yahoo.com>
Subject: Problem in Creating Cache Device ............ related to Sleep ......... plzz help .....
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I m using kernel 2.4, and trying to make a front cache
block drive, for this I need to pool bh (buffer head)
to perform operation on free time.

1) to do this, I m using two threads, one to full fill
the request.
2) Other one is used to synch the data when 80% is
filled on the actual drive.

I have my own 5MB memory pages buffer, and using this
to transfer the data from source drive to target drive
through generic make request. when no more 
pages available then it goes to down like
wait_event_disk in RAID.

When cache drive cross the 70% boudry it wake-up
flushing thread which start transfer data from cache
drive to target drive. at this time synching and 
normal transfer working parallely. when I/O rate is
high, at this moment cache drive increases it self,
whether flush thread is running parallely. 

After 98% fill of cache drive we lock first thread
which fullfilling the request, in the mean time
requests are allwed to queue, and at that moment 
flushing thread trying to reduce cache disk used area
by flushing to the target drive.

PROBLEM occurs, when pages are locked and in the mean
time 98% arrived because of first thread, and it
locked itself, and never comes back, and in the mean
time requests are arriving from the outside and queing
them selves. 

we have thousants of request already in the target
drive, but no one is fullfilling after lock of both
threads.

help me , how I can forcely order to the drive to
start operation on request which it has in its queue.

even i used plug_device(), run_task_queue(&tq_disk)
fuctions but no results, my process is locked..

Thanks

Fawad



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
