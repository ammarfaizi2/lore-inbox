Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268069AbTBRSvm>; Tue, 18 Feb 2003 13:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268068AbTBRSvm>; Tue, 18 Feb 2003 13:51:42 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:22161 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S268067AbTBRSvd>; Tue, 18 Feb 2003 13:51:33 -0500
Message-ID: <3E5282E5.4020801@nortelnetworks.com>
Date: Tue, 18 Feb 2003 14:00:53 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fcntl and flock wakeups not FIFO?
References: <20030218010054.J28902@parcelfarce.linux.theplanet.co.uk> <3E5246C3.4090008@nortelnetworks.com> <20030218150201.A22992@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Tue, Feb 18, 2003 at 09:44:19AM -0500, Chris Friesen wrote:


>>It appears that if this function is called with a wait value of zero,
>>all of the waiting processes will be woken up before the scheduler gets
>>called.  This means that the scheduler ends up picking which process
>>runs rather than the locking code.

> Right.  That's why I asked whether you were doing something clever with
> scheduling ;-)

Ah, okay.

>>Looking through the file, there is no call chain on an unlock or on
>>closing the last locked fd which can give a nonzero wait value, meaning
>>that we will always end up with the scheduler making the decision in
>>these cases.

> I'm impressed that you chased it through ;-)

I was bored and it was bothering me.... :)



>>Am I missing something?

> Nope, it's true.  But the tasks get marked as runnable in the right order,
> so the scheduler should be doing the right thing -- if any tasks really
> have a better reason to run first (whether it's through RT scheduling
> or through standard Unix priority scheduling) then they'll get the lock
> first.  Otherwise, I'd've thought it should be first-runnable, first-run.

Apparently not always.  I guess it's probably good enough for my 
purposes the way it is, it just surprised me a bit.

Is 2.5 the same way?  (Haven't looked at it yet.)

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

