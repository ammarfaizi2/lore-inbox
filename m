Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVCGFO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVCGFO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVCGFO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:14:56 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:13903 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261625AbVCGFOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:14:44 -0500
Message-ID: <422BE33D.5080904@yahoo.com.au>
Date: Mon, 07 Mar 2005 16:14:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Christian Schmid <webmaster@rapidforum.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com>
In-Reply-To: <422BC303.9060907@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Christian Schmid wrote:
> 
>> Ben Greear wrote:

>>> How many bytes are you sending with each call to write()/sendto() 
>>> whatever?
>>
>>  
>> I am using sendfile-call every 100 ms per socket with the poll-api. So 
>> basically around 40 kb per round.
> 
> 
> My application is single-threaded, uses non-blocking IO, and sends/rcvs 
> from/to memory.
> It will be a good test of the TCP stack, but will not use the sendfile 
> logic,
> nor will it touch the HD.
> 

I think you would have better luck in reproducing this problem if you
did the full sendfile thing.

I think it is becoming disk bound due to page reclaim problems, which
is causing the slowdown.

In that case, writing the network only test would help to confirm the
problem is not a networking one - so not useless by any means.

