Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTELEVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTELEVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:21:14 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53894 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261879AbTELEVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:21:12 -0400
Message-ID: <3EBF240A.4050706@nortelnetworks.com>
Date: Mon, 12 May 2003 00:33:14 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug McNaught <doug@mcnaught.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
References: <3EBC9C62.5010507@nortelnetworks.com>	<20030510073842.GA31003@actcom.co.il>	<3EBF144E.7050608@nortelnetworks.com> <m3y91cj0vm.fsf@varsoon.wireboard.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:
> Chris Friesen <cfriesen@nortelnetworks.com> writes:
> 
> 
>>>There's already a well established way to do what you want (get
>>>non-immediate notification of process death). What benefit would your
>>>approach give?
>>>
>>Its cheaper and faster.  It only costs a single call for each process,
>>and then you get notified immediately when it dies.
>>
> 
> Rather than a new syscall, what about a magic file or device that you
> can poll()? 

This is definately an option to consider.  The problem that I see with this is 
that when you are trying to monitor large numbers of processes you have to worry 
about running out of file descriptors, and select() is no longer as happy.

I have an actual real request to be able to monitor 5000 processes.  This would 
be a lot of file descriptors, and when select returns it would take some 
processing to figure out which one had an event.

It does have easier handling of multiple simultaneous deaths though...the signal 
method would probably want to use realtime signals to get signal queueing.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

