Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUHXVlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUHXVlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUHXViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:38:22 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5559 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268354AbUHXVfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:35:05 -0400
Subject: missing wait_event_timeout
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1093383090.4871.8.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Aug 2004 16:31:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason why there is no wait_event_timeout function in kernel.
There is only the __wait_event_timeout_interruptible in wait.h
It seems the easiest way to fix the few remaining pieces of code which
call the deprecated sleep_on_timeout.

ie something like:


> #define __wait_event_timeout(wq, condition, ret)
> do {			
> 	DEFINE_WAIT(__wait);	
> 				
> 	for (;;) {		
> 		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);
> 		if (condition)				
> 			break;				
> 		ret = schedule_timeout(ret);	
> 		if (!ret)			
> 			break;			
> 	}						
> 	finish_wait(&wq, &__wait);					
> } while (0)



