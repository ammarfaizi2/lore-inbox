Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUK0VP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUK0VP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbUK0VP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:15:56 -0500
Received: from www.zeroc.com ([63.251.146.250]:3819 "EHLO www.zeroc.com")
	by vger.kernel.org with ESMTP id S261337AbUK0VPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:15:51 -0500
Message-ID: <009501c4d4c6$40b4f270$6400a8c0@centrino>
From: "Bernard Normier" <bernard@zeroc.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr>
Subject: Re: Concurrent access to /dev/urandom
Date: Sat, 27 Nov 2004 16:15:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >As long as I serialize access to /dev/urandom, I get different values.
>>However, with concurrent access to /dev/urandom, I quickly get duplicate
>
> How do you concurrently read from urandom? That's only possible with 2 or 
> more
> CPUs, and even then, I hope that the urandom chardev has some spinlock.
>
As shown in the code included in my first e-mail, each thread simply
open("/dev/urandom", O_RDONLY), use read(2) to read 16 bytes, and
then close the file descriptor.
Duplicates appear quickly on: single CPU with HT, dual CPU without HT,
and dual CPU with HT (all with smp kernels)
But not on a lower end single CPU without HT (2.6.8-1.521 non-smp).

>>#include <pthread.h>
>>[...]
>
> Rule of thumb: Post the smallest possible code that shows the problem.
Will do next time!

Bernard


