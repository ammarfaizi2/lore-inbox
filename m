Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVCaL3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVCaL3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCaL3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:29:24 -0500
Received: from pcsmail.patni.com ([203.124.139.197]:28357 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S261360AbVCaL3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:29:17 -0500
Message-ID: <001001c535e4$c79789e0$5e91a8c0@patni.com>
Reply-To: "lk" <linux_kernel@patni.com>
From: "lk" <linux_kernel@patni.com>
To: "Banu R Reefath" <reefathbanur@myw.ltindia.com>,
       <linux-kernel@vger.kernel.org>
References: <s24be47e.095@EMAIL>
Subject: Re: Timers to threads
Date: Thu, 31 Mar 2005 03:28:36 -0800
Organization: Patni
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If u search for usleep in google then first document says that usleep will
have max range of 1,000,000 microseconds as the max sleep delay and
after the delay time expires the actual execution may get delayed because
of high system activity.

If you are writing kernel modules, you may  use schedule_timeout().
schedule_timeout() uses dynamic timers and when schedule( ) is invoked,
another process
is selected for execution; when the former process resumes its execution,
the function
schedule_timeout removes the dynamic timer.

code snippet
for(;;){
  set_current_state(TASK_UNINTERRUPTIBLE);
  schedule_timeout(unsigned long timeout); /* schedule_timeout(10*HZ) will
suspend process & resume execution after 10 seconds */
  set_current_state(TASK_RUNNING);
}
hope it helps
regards
lk
----- Original Message ----- 
From: "Banu R Reefath" <reefathbanur@myw.ltindia.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, March 30, 2005 10:22 PM
Subject: Timers to threads


> Dear Sir/Mam
>   We are using Linux in one of our embedded products.This is the first
time we are  working in this Platform.We have few doubts regarding
implementing s/w timers & how  to pass the  timer interrupts to threads .
>  In net we coudnt find exactly what we want .Could you please help us in
this regard?
>
> Ideas from us
> 1. If we want a thread to execute at particular intervals should it be
done only through
> usleep()  system call ? Will it be accurate enough ?
> Because it is a real time design for a Medical Product.
>
> 2. If we use kernel timers to invoke at particular time intervals using
add_timer () how to  pass on to the application that the time has elapsed?
>
> A piece of code demonstartion would be much more helpful to us
>
> Thanks & Regards,
> Reefath Banu Rajali
> Software Engineer
> Larsen & Toubro
> Embedded Systems & Software
> Mysore
> India
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


