Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTAWQTk>; Thu, 23 Jan 2003 11:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTAWQTk>; Thu, 23 Jan 2003 11:19:40 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:51600 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265351AbTAWQTj>; Thu, 23 Jan 2003 11:19:39 -0500
Message-ID: <3E301833.8030103@nortelnetworks.com>
Date: Thu, 23 Jan 2003 11:28:35 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tom Sanders <developer_linux@yahoo.com>
Cc: redhat-list@redhat.com, linux-kernel@vger.kernel.org,
       redhat-devel-list@redhat.com
Subject: Re: Linux application level timers?
References: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sanders wrote:
> I'm writing an application server which receives
> requests from other applications. For each request
> received, I want to start a timer so that I can fail
> the application request if it could not be completed
> in max specified time.
> 
> Which Linux timer facility can be used for this?

I used setitimer for a similar task.  Since you can only have one timer 
going at any given time, I set up a linked list of timing events, with 
each event's timeout expressed as a delta from the previous event.  This 
way changing the time on the system has no effect on the application. 
The itimer is then set for the first event in the list.  When a timer 
goes off, it optionally re-inserts the event into the list, starts the 
next itimer, and then calls a callback function for the expired event 
with an opaque data pointer as an argument.

Works really well.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

