Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUB0ADK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUB0ADJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:03:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:27853 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261344AbUB0ACN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:02:13 -0500
Message-ID: <403E8900.4030500@roemling.net>
Date: Fri, 27 Feb 2004 01:02:08 +0100
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it>
In-Reply-To: <1tDgT-4r2-13@gated-at.bofh.it>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:35bace2e8eeec41a1b9500b782c09cc4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * William Lee Irwin III (wli@holomorphy.com) wrote:
> 
>>On Thu, Feb 26, 2004 at 11:36:03PM +0100, Jochen Roemling wrote:
>>
>>>How can I grant the permission to use HUGETLB to ordinary users?
>>
>>(a) use the fs which uses fs permissions to grant users permission to
>>	fiddle with hugetlb
>>(b) man 2 capset
> 
> 
> In case that part wasn't clear, it would be CAP_IPC_LOCK capability.
> 
Thanks. Capset was the keyword I couldn't remember.

_Background:_
I would like to install Oracle 10g Database on Linux with HUGETLB
support. The oracle binary exits with -EPERM because it is not allowed
to create a shared memory segment with the SHM_HUGETLB flag set.

I installed the libcap2 package (from debian testing) and now have the
tool "setcap" available. I wanted to test this on my example pgm
mentioned in the original post using:

roesrv01~ # setcap CAP_IPC_LOCK a.out
fatal error: Invalid argument
usage: setcap [-q] (-|<caps>) <filename> [ ... (-|<capsN>) <filenameN> ]

using the number "14" instead of the name "CAP_IPC_LOCK" doesn't work
either. I don't have any glue. Do have a simple example for me?

By the way: CAP_IPC_LOCK is only checked in line 508 of ipc/shm.c:

         case SHM_LOCK:
         case SHM_UNLOCK:
         {
/* Allow superuser to lock segment in memory */
/* Should the pages be faulted in here or leave it to user? */
/* need to determine interaction with current->swappable */
                 if (!capable(CAP_IPC_LOCK)) {
                         err = -EPERM;
                         goto out;
                 }

There is nothing around that says: "Allow this only without HUGETLB".
Are you sure that this capability is my problem?







