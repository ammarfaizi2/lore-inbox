Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSF0OUd>; Thu, 27 Jun 2002 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSF0OUc>; Thu, 27 Jun 2002 10:20:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34056 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316855AbSF0OUc>;
	Thu, 27 Jun 2002 10:20:32 -0400
Message-ID: <3D1B1E17.EC626EFD@zip.com.au>
Date: Thu, 27 Jun 2002 07:15:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: anton wilson <anton.wilson@camotion.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: printks in the scheduler freeze during scripts
References: <200206271349.JAA16318@test-area.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anton wilson wrote:
> 
> I'm running linux 2.4.17 and Redhat 7.2 with the preemptive and low latency
> patches, and whenever I stick printks in the scheduler(void) my system
> freezes somewhere after it tries to load the system font. Where it stops
> seems to be random. I can only run under single user mode without my system
> freezing. Does anyone have any clues why? Or any better ways to go about
> tracking the scheduling of processes in the scheduler?
> 

printk() calls wake_up(), to give klogd a kick.  So a printk
from the scheduler tends to deadlock.  Just delete the
last two lines of kernel/printk.c:release_console_sem() and it
should work OK.
