Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbUKJXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUKJXel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbUKJXeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:34:01 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:59600 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S262147AbUKJXdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:33:49 -0500
Message-ID: <4192AAA9.7080407@drdos.com>
Date: Wed, 10 Nov 2004 16:56:25 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 RCU breakage in dev_queue_xmit
References: <E1CRhaw-0001v7-00@gondolin.me.apana.org.au>
In-Reply-To: <E1CRhaw-0001v7-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>Jeff V. Merkey <jmerkey@drdos.com> wrote:
>  
>
>>Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
>>receive, 12 CLK interacket gap time, 1500 bytes payload
>>at 65000 packets per second per gigabit interface, and retransmitting 
>>received packets at 130 MB/S out of a third gigabit interface
>>with skb, RCU locks in dev_queue_xmit breaks and enters the following state:
>>    
>>
>
>This patch might help.
>  
>

Herbert,

Even with this patch I still see RCU breakage at these data rates and 
the problem persists -- it just takes
longer for it to manifest (about 23 hours).  I am recoding 
dev_queue_xmit since the use of RCU primitives
is severely busted.   I looked over the code and the fact it breaks on 
uniprocessor is really a joke. 
No offense guys, but this is pretty bad.  How about something simple, 
like a spinlock or
multiple send queues per proc?

Jeff

