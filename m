Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbTEAW0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTEAW0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:26:07 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:18088 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262715AbTEAW0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:26:06 -0400
Message-ID: <3EB1A1AD.8070107@nortelnetworks.com>
Date: Thu, 01 May 2003 18:37:33 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Lee, Shuyu" <SLee@cognex.com>
Cc: linux-kernel@vger.kernel.org,
       "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to notify a user process from within a driver
References: <6AF24836F3EB074BA5C922466F9E92E10791B532@prince.pc.cognex.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee, Shuyu wrote:

> For example, assuming there are 8 input lines on my hardware, and the user
> wants to be notified in the following three cases:
> 1) input on Line 1 only,
> 2) input on either Line 2 or Line 3,
> 3) input on both Line 4 and Line 5,
> how do I pass that info to the driver? Also, other than POLLERR and POLLHUP,
> can I pass back to the user more descriptive error messages?

One to do something like this is to use signals.  You could use ioctl for 
userspace to register with the driver, and to query the status.  When the 
correct combination of inputs occurs, you thwap the process with a SIGUSR1, 
which tells it to wake up and query the input line status.

Alternately, you could use ioctl for configuration and wait on a socket for 
notification as to when to query the status.

Finally, you could use ioctl for configuration and write a byte to the socket 
when the right event happens, the byte being a bitmap of the 8 input lines.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

