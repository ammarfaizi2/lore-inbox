Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUBRDvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUBRDvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:51:19 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:19669
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S262564AbUBRDvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:51:17 -0500
Message-ID: <4032DCF1.9050603@tmr.com>
Date: Tue, 17 Feb 2004 22:33:05 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hilko Bengen <bengen@hilluzination.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
References: <402403A5.4090708@tmr.com> (Bill Davidsen's message of "Fri, 06 Feb 2004 16:14:13 -0500") <87znbupydc.fsf@hilluzination.de>
In-Reply-To: <87znbupydc.fsf@hilluzination.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hilko Bengen wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> 
>>What would be nice is some kind of table approach, hash or tree,
>>which allows operations to be matches against all of the IPs in a
>>group, and obviously to add/delete entries. I think for simplicity
>>individual IPs rather than CIDR blocks are desirable.
> 
> 
> Do you mean something like <http://www.hipac.org/>?

Thank you for the pointer, it's not what I meant but probably will be 
highly useful anyway.

What I had in mind was a single rule which would apply against a table 
of IP addresses and CIDR blocks instead of one. Somewhat like the access 
table in sendmail, but perhaps more like a database in that I could add 
and delete to/from the table at runtime while always leaving the table 
valid (pseudo-atomic operations).

Perhaps the example of what I would like to do is better than what I 
wrote. Think of tables in iproute2.

iptables -A INPUT -p tcp --stable badguys --dport smtp -j REJECT
   then as I detect...
iptables -T badguys add 270.1.2.3
iptables -T badguys add 270.4.5.16/4

So I could add and delete to a table, and it's use would not be limited 
to a single rule. It would be an independent in-memory table of some 
(hash?) organization.

I think the link you kindly provided is a viable solution, it's just not 
quite what I had in mind, allowing me to use an IP set in multiple or 
changing ways without redefinition for each IP.

Didn't mean to get this going in this list, it grew from a chance comment.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
