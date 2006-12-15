Return-Path: <linux-kernel-owner+w=401wt.eu-S1752848AbWLOQYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbWLOQYb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbWLOQYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:24:31 -0500
Received: from pat.uio.no ([129.240.10.15]:47444 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbWLOQYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:24:30 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michal Sabala <lkml@saahbs.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061215023014.GC2721@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 11:24:15 -0500
Message-Id: <1166199855.5761.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> Hello LKML,
> 
> I am observing processes entering uninterruptible sleep apparently due
> to an unrelated application using mmap over nfs. Applications in
> "uninterruptible sleep" hang indefinitely while other applications
> continue working properly.
> 
> The code causing the mmap nfs hangs does the following:
> (as replicated by the included test-mmap.c file)
> 
>   1. create file on nfs (file_A, descr_A)
>   2. make file_A a sparse 200MB file
>   3. mmap descr_A
>   4. close descr_A
>   5. unlink file_A
>   6. memcpy 200MB to mmaped buffer
>   7. create a second file on nfs (file_B, descr_B)
>   8. write() 200MB from mmaped buffer to descr_B
>   9. close descr_B
>   10. munmap first file
> 
> This code may need to be ran tens to hundred runs to trigger the condition.
> 
> During the execution of the above code, unrelated applications enter
> uninterruptible sleep (D) - usually firefox2.0, Xorg/XFree86, gimp2.2, gconfd
> or bash; probably the most active processes.
> 
> `dmesg` shows nothing of interest.
> 
> `free` shows anywhere between 1MB and 80MB of memory still remaining
> free when the problem occurs.
> 
> `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.

Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
these hanging processes? If so, what does the output look like?

Cheers
  Trond

