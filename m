Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbUDGPEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbUDGPEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:04:33 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:18820 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263705AbUDGPCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:02:55 -0400
Message-ID: <40741819.5060001@yahoo.com.au>
Date: Thu, 08 Apr 2004 01:02:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
References: <20040401122802.23521599.pj@sgi.com>	<20040401131240.00f7d74d.pj@sgi.com>	<20040406043732.6fb2df9f.pj@sgi.com>	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>	<20040406235000.6c06af9a.pj@sgi.com>	<20040407004437.3a078f28.pj@sgi.com>	<40740C90.3060005@yahoo.com.au> <20040407074441.5070b58d.pj@sgi.com>
In-Reply-To: <20040407074441.5070b58d.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>No, the schedule() fastpath doesn't use find_next_bit. 
> 
> 
> Ok - makes sense - thanks.
> 
> Uninlining it is perhaps the easiest way out.
> 
> That or replacing it with the trivial version that is several times
> smaller (loops one bit at a time, checking 'test_bit()').
> 
> Right now, I don't see any excuse for that fat version of find_next_bit()
> to exist.
> 

Well it would be nice to keep it fast though, especially
for big masks like those 64 byte cpumasks of yours. In
the scheduler for example, a lot of balancing operations
are done with very sparse cpumasks, which your bit at a
time version doesn't handle very well.

For example, a global CPU balancing operation on a 512
CPU system with 2 CPUs per node currently does 256
for_each_cpu loops over cpumasks with two entries in
them. 130 thousand test_bit loop iteratinos.

The uninlined larger version would have to be smaller and
faster than your small version inlined, wouldn't it?
