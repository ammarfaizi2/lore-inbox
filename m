Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVIMXaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVIMXaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVIMXaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:30:19 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16081 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932529AbVIMXaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:30:17 -0400
Date: Tue, 13 Sep 2005 17:30:09 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: wait_event_interruptible_timeout problem
In-reply-to: <4MjuE-6Cb-37@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43276101.3020104@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4MjuE-6Cb-37@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manomugdha biswas wrote:
>  Hi,
>  I have a kernel module (kernel 2.6) where I have
>  opened multiple tcp connections. when there is no
>  data
>  i want my process to sleep. For that i have added
>  the
>  following code.
>   
>  /* Initialise the wait q head */
>    init_waitqueue_head(&VNICClientWQHead);
>  
>  init_waitqueue_entry(&(currentMap->waitQ), current);
>  add_wait_queue(currentMap->sock->sk->sk_sleep,
>  &(currentMap->waitQ));
>  
>  /* here currentMap is a structure containing tcp
>  conenction info for my module. There is a currentMap
>  for each tcp connection */
>  
>  wait_event_interruptible_timeout(VNICClientWQHead,
>                                   0, HZ * 100000);
>  
>  I am not sure about the condition argument, 0. 

The condition should be an expression that returns true when whatever 
you are waiting for occurs - in this case when data is available. If you 
put the condition as 0 it will never wake up.

Also, why the huge timeout? If you just want to sleep forever, use 
regular wait_event_interruptible.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


