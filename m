Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291509AbSBADgv>; Thu, 31 Jan 2002 22:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291510AbSBADgm>; Thu, 31 Jan 2002 22:36:42 -0500
Received: from [66.89.142.2] ([66.89.142.2]:45095 "EHLO linux.xalien.org")
	by vger.kernel.org with ESMTP id <S291509AbSBADg3>;
	Thu, 31 Jan 2002 22:36:29 -0500
Message-Id: <200202010320.g113K2m02524@linux.xalien.org>
Content-Type: text/plain; charset=US-ASCII
From: Dragan Stancevic <visitor@xalien.org>
To: linux-kernel@vger.kernel.org
Subject: tasklet broken? Quick question
Date: Thu, 31 Jan 2002 19:20:01 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing a strange behavior when using tasklets so I was wondering if 
this is a bug or a feature and if anyone else has experienced the same 
behavior.

I am using 2.4.9 and I checked the ChangeLog and there was a fix from Andrea 
in 2.4.8 with relation to tasklets but nothing after that.

I schedule a tasklet from a network driver interrupt and what I am seeing is 
that in some cases the tasklet runs twice when I am expecting it to run once.

Here is pseudo code how it looks like:

network_interrupt(){
	tasklet_schedule()
}

tasklet_code(){
	do_stuff()
}

and here is what happens:

I get an interrupt which calls tasklet_schedule, the tasklet starts executing 
and has not exited yet and I get another interrupt that calls 
tasklet_schedule, now the tasklet code exits but in some cases it executes 
again without ever tasklet_schedule being called again, I checked this is 
done on the same cpu as the interrupt was called so thats ok. I am just not 
sure if I should be expecting that "extra" execution, I thought I shouldn't.


PS: Please Cc me on reply as I am not currently on lkml. Thanks.


-- 
Peace can only come as a natural consequence
of universal enlightenment. -Dr. Nikola Tesla
