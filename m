Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUHXW06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUHXW06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUHXW06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:26:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:9091 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268664AbUHXW0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:26:54 -0400
Subject: Re: missing wait_event_timeout
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1093383090.4871.8.camel@stevef95.austin.ibm.com>
References: <1093383090.4871.8.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1093386199.4882.11.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Aug 2004 17:23:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it is just safer to call wait_event with the timeout check as one
of the conditions?

On Tue, 2004-08-24 at 16:31, Steve French wrote:
> Is there a reason why there is no wait_event_timeout function in kernel.
> There is only the __wait_event_timeout_interruptible in wait.h
> It seems the easiest way to fix the few remaining pieces of code which
> call the deprecated sleep_on_timeout.
> 
> ie something like:
> 
> 
> > #define __wait_event_timeout(wq, condition, ret)
> > do {			
> > 	DEFINE_WAIT(__wait);	
> > 				
> > 	for (;;) {		
> > 		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);
> > 		if (condition)				
> > 			break;				
> > 		ret = schedule_timeout(ret);	
> > 		if (!ret)			
> > 			break;			
> > 	}						
> > 	finish_wait(&wq, &__wait);					
> > } while (0)
> 
> 

