Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTEUJJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTEUJJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:09:07 -0400
Received: from imap.gmx.net ([213.165.65.60]:56611 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261322AbTEUJJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:09:06 -0400
Message-Id: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 21 May 2003 11:26:31 +0200
To: davidm@hpl.hp.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <16075.8557.309002.866895@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:49 PM 5/20/2003 -0700, David Mosberger wrote:
>Recently, I started to look into some odd performance behaviors of the
>O(1) scheduler.  I decided to document what I found in a web page
>at:
>
>         http://www.hpl.hp.com/research/linux/kernel/o1.php

<snip>

>Comments welcome.

The page mentions persistent starvation.  My own explorations of this issue 
indicate that the primary source is always selecting the highest priority 
queue.  Combine that with the round-robin, and you have a good chance of 
being grossly unfair with some workloads.  I know for certain that lock 
holders in the active array can be starved for very long periods by tasks 
entering higher priority queues, thereby causing even more starvation when 
they finally get the cpu and can release the lock (sleepers go through the 
roof).

Try the attached overly simplistic (KISS:) diff, and watch your starvation 
issues be very noticably reduced.

         -Mike 

