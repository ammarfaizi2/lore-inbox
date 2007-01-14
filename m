Return-Path: <linux-kernel-owner+w=401wt.eu-S1751325AbXANPmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbXANPmp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 10:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbXANPmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 10:42:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50448 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbXANPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 10:42:44 -0500
Message-ID: <45AA4F4D.5030605@redhat.com>
Date: Sun, 14 Jan 2007 09:42:05 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
MIME-Version: 1.0
To: Dmitriy Monakhov <dmonakhov@sw.ru>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] [RFC] remove ext3 inode from orphan list when link and
 unlink race
References: <45A7F384.3050303@redhat.com> <878xg5q0q7.fsf@sw.ru>
In-Reply-To: <878xg5q0q7.fsf@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitriy Monakhov wrote:
> Eric Sandeen <sandeen@redhat.com> writes:
> 
>> I've been looking at a case where many threads are opening, unlinking, and
>> hardlinking files on ext3 .
> How many concurent threads do you use and how long does it takes to trigger 
> this race? I've tried to reproduce this with two threads, but not succeed.
> <thread 1>  
>         fd = create("src")
>         close(fd)
>         unlink("src")
> <thread 2>
>         link("src", "dst")
>         unlink("dst")
> 
> Original testcase will be the best answer :).

Sure :)  Though I didn't write it... see this collection of bash scripts:

http://people.redhat.com/esandeen/testcases/orphan-repro.tar.bz2

I didn't write it, but it exposed the bug for me.  The VAR file contains 
variables to specify mountpoint and a device, which the script starts by 
mkfs'ing, so be warned.

It spawns -many- threads, and on my 4 CPU opteron I can hit it in a 
reasonable amount of time.  It would probably be nice to have a more 
targeted testcase but it did the trick for me.

Thanks,
-Eric

> Thanks.

