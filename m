Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUEWJkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUEWJkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUEWJkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:40:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:16363 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261752AbUEWJjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:39:52 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
Date: Sun, 23 May 2004 11:39:41 +0200
User-Agent: KMail/1.6.2
Cc: Gergely Czuczy <phoemix@harmless.hu>, itk-sysadm@ppke.hu
References: <Pine.LNX.4.60.0405230914330.15840@localhost>
In-Reply-To: <Pine.LNX.4.60.0405230914330.15840@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405231139.44096.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gergely Czuczy wrote:
> failed. As I told it above all the processes are teminated right after
> creation, but there were a lot of defunct processes in the system, and
> they were only gone when the parent termineted.

Have you heard of wait, waitpid and pthread_join?

> With a few number of processes I wasn't able to go over 255 threads,
> after the 255th every creation attempt simply failed.

Your 255 thread limit is propably because you have a stack size of 8192 
kbytes. (see ulimit). As all threads share the same address space, this 
address space is the limiting factor. Try ulimit -s 1024 for example.

> It's easy to notice that in case of 2.4 the ratios of the creation times
> are converges to 1, so it depends on the load, while in case of a 2.6
> kernel the ratios are mostly fix, about 9. This means that creating a new
> child process takes much more time than creating a new thread.

Well, the other way around is the correct answer. Processes didnt get 
slower. Threads are faster than processes in 2.6 because of the NPTL. If 
you want to slow down threads to process level, just do 
LD_ASSUME_KERNEL=2.2.5 before running your test program.

cheers

Christian




