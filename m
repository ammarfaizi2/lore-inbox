Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUC1AVP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUC1AVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:21:15 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:9144 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262026AbUC1AVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:21:08 -0500
Message-ID: <40661A70.3090608@yahoo.com.au>
Date: Sun, 28 Mar 2004 10:21:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com>	<40661049.1050004@yahoo.com.au> <20040327160745.7207ff98.akpm@osdl.org>
In-Reply-To: <20040327160745.7207ff98.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> > 
>> > With this simple patch, the max request size goes from 128K to 32MB... 
>> > so you can imagine this will definitely help performance.  Throughput 
>> > goes up.  Interrupts go down.  Fun for the whole family.
>> > 
>>
>> Hi Jeff,
>> I think 32MB is too much. You incur latency and lose
>> scheduling grainularity. I bet returns start diminishing
>> pretty quickly after 1MB or so.
> 
> 
> As far as interactivity and throughput is concerned, the effect of really
> big requests will be the same as the effect of permitting _more_ requests. 
> Namely: more memory can be under readahead or writeback at any particular
> point in time.
> 

Not quite, because a single 32MB write might take what? 500ms to
complete... and the IO scheduler wants to stop writes after 60ms
if there are waiting reads.

And writes will be more likely to be submitted as large requests.

I think Jeff is right that in theory though, the drivers should
just export their capabilities, and the block layer or IO scheduler
should decide on the maximum size to actually use.
