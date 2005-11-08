Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVKHCOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVKHCOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVKHCOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:14:14 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:47544 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030251AbVKHCOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:14:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ulcDyicoq/Ku6b34mzJUKU5gtDJz2kJnwthld8EDTAVvnsMRFCpwe9eaNk6r07OBp185k35+04B+TRxBO7dJ9Qw2jUOQDwlJF0oBVjgAn3HWs6GQ/3kEFfiabWAIqcXV7BZe7lM0f9daohNTfVE89qghla4qlE6c6f5DoG1V6GA=  ;
Message-ID: <43700A35.1040403@yahoo.com.au>
Date: Tue, 08 Nov 2005 13:15:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Anton Blanchard <anton@samba.org>,
       Brian Twichell <tbrian@us.ibm.com>, linux-kernel@vger.kernel.org,
       slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <20051108011547.GP12353@krispykreme> <105220000.1131413677@flay> <43700371.6040507@yahoo.com.au> <Pine.LNX.4.62.0511071752550.9339@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0511071752550.9339@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Tue, 8 Nov 2005, Nick Piggin wrote:
> 
>>
>> Long lived and memory intensive cloned or forked tasks will often
>> [but far from always :(] want to be put on another memory controller
>> from their siblings.
>>
>> On workloads where there are lots of short lived ones (some bloated
>> java programs), the load balancer should normally detect this and
>> cut the balance-on-fork/clone.
> 
> 
> although if the primary workload is short-lived tasks and you don't do 
> balance-on-fork/clone won't you have trouble ever balancing things? 
> (anything that you do move over will probably exit quickly and put you 
> right back where you started)
> 

You'll have no trouble if things *need* to be balanced, because
that would imply the runqueue length average is significantly
above the lengths of other runqueues.

As far as the extra test goes, it's really a miniscule overhead
compared with the fork / clone cost itself, and can be really
worthwhile if we get it right.

> 
>> Of course there are going to be cases where this fails. I haven't
>> seen significant slowdowns in tests, although I'm sure there would
>> be some at least small regressions. Have you seen any? Do you have
>> any tests in mind that might show a problem?
> 
> 
> even though people will point out that it's a brin-dead workload (that 
> should be converted to a state machine) I would expect that most 
> fork-per-connection servers would show problems if the work per 
> connection is small
> 

Well it may be brain-dead, but if people use them (and they do)
then I would really be interested to see results.

I did testing with some things like apache and volanomark, however
I was not able to make out much difference on my setups. Though
obviously that's not to say that there won't be with other software
or other workloads / architectures etc.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
