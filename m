Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVLWBqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVLWBqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVLWBqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:46:18 -0500
Received: from bay16-f2.bay16.hotmail.com ([65.54.186.52]:59885 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964985AbVLWBqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:46:17 -0500
Message-ID: <BAY16-F260F9C6F509BFC683D3A6AF330@phx.gbl>
X-Originating-IP: [203.166.111.194]
X-Originating-Email: [alexshinkin@hotmail.com]
In-Reply-To: <1135300240.12761.27.camel@localhost.localdomain>
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: questions on wait_event ...
Date: Fri, 23 Dec 2005 07:46:17 +0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Dec 2005 01:46:17.0925 (UTC) FILETIME=[AABB9F50:01C60762]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Look:

We call wait_event() , condition is FALSE at the moment  :

    do {
         if (condition)
                 break;
    /* and here we have condition changed  to TRUE  */
    /*  process is NOT in any wait queue yet  */
    /*  then  unroll     __wait_event(wq, condition);        */

     do {							DEFINE_WAIT(__wait);					for (;;) {
	prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);

          /* at this point condition is TRUE , process is in a wait queue 
and its state is
             TASK_UNINTERRUPTIBLE.   If  rescheduling happens now the 
process will asleep,
              despite of condition is  TRUE . And will not be woken up until 
next wake_up happens
              Is that correct ?  */

	if (condition)						     break;
                    schedule();
        }
   finish_wait(&wq, &__wait);
} while (0)
   /*  end of unroll __wait_event*/

} while (0)

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

