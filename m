Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSG2T7U>; Mon, 29 Jul 2002 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSG2T7U>; Mon, 29 Jul 2002 15:59:20 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:26581 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317616AbSG2T7S> convert rfc822-to-8bit; Mon, 29 Jul 2002 15:59:18 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
Date: Mon, 29 Jul 2002 14:54:30 -0500
X-Mailer: KMail [version 1.4]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207291454.30076.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would caution against having hyperthreading on by default in the 2.4.19 
release.  I am seeing a significant degrade in network workloads on P4 with 
hyperthreading on.  On 2.4.19-pre10, I get 788 Mbps on NetBench, but on 
2.4.19-rc1 (and probably rc3, should know in an hour), I get 690 Mbps.  It is 
clearly a hyperthreading/interrupt routing issue.  On this system (4 x P4), 
with no hyperthreading, there is enough CPU to handle all interrupts on CPU0 
(this is where all ints go by default).  With hyperthreading on, I get "1/2" 
of a CPU for interrupt processing.  What ends up happenning is that CPU0 is 
at 100%, while CPU1-CPU7 are at 75%.  Now I know the "noth" is available, but 
since hyperthreading is not proven to give a performance boost to more than 
1/2 of the common workloads for linux users (or is it? who has done tests?), 
I'd like to see this default behavior reversed, and still use acpismp=force 
to enable hyperthreading.  

Also, If anyone has performance results for their workloads showing a boost 
with hyperthreading, I would really like to know.  

-Andrew Theurer



<<So here goes rc3. Another -rc is going to come only in the case of really
critical problem(s).

I'm attaching the rc2->rc3 changelog only because the full changelog got
too big (I guess thats why my -rc2 announce mail didnt go to lk).>>


