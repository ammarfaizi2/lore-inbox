Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTELDNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTELDNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:13:35 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:41437 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261876AbTELDNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:13:34 -0400
Message-ID: <3EBF144E.7050608@nortelnetworks.com>
Date: Sun, 11 May 2003 23:26:06 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
References: <3EBC9C62.5010507@nortelnetworks.com> <20030510073842.GA31003@actcom.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Sat, May 10, 2003 at 02:29:54AM -0400, Chris Friesen wrote:
> 
> 
>>I see two immediate uses for this.  One would be to enable a "watcher" 
>>process which can do useful things on the death of processes which 
>>registered with it (logging, respawning, notifying other processes,
>>etc).  
>>
> 
> Do it from user space, kill(pid, 0), check for ESRCH. I might see the
> benefit of a new system call if it was synchronous (wait() semantics),
> but since signal delivery is asynch anyway.... 

Exactly.  I don't want to explicitly poll each process being monitored to see if 
it is still alive.  That solution doesn't scale well--what happens when you are 
monitoring 5000 processes and you want to make sure that you catch them within a 
certain amount of time?  You end up spending a lot of cpu time doing the monitoring.


> There's already a well established way to do what you want (get
> non-immediate notification of process death). What benefit would your
> approach give? 

Its cheaper and faster.  It only costs a single call for each process, and then 
you get notified immediately when it dies.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

