Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbUKJHH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUKJHH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUKJHH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:07:57 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:6768 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261496AbUKJHHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:07:36 -0500
Message-ID: <4191BE2D.4060407@yahoo.com.au>
Date: Wed, 10 Nov 2004 18:07:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Workaround for wrapping loadaverage
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org> <20041108102553.GA31980@oscar.prima.de> <20041108155051.53c11fff.akpm@osdl.org> <20041109004335.GA1822@oscar.prima.de> <20041109185103.GE29661@mail.13thfloor.at>
In-Reply-To: <20041109185103.GE29661@mail.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Tue, Nov 09, 2004 at 01:43:35AM +0100, Patrick Mau wrote:
> 

>>We re-calculate the load every 5 seconds. I think it would be OK to
>>use more bits/registers, it's not that frequently called.
> 
> 
> hmm ...
> 
> 	do_timer() -> update_times() -> calc_load()
> 
> so not exactly every 5 seconds ...
> 

calc_load() -> messing with LOAD_FREQ -> once every 5 seconds, no?

I think doing 32/32 bit calculations would be fine.

> but I agree that a higher resolution would be a good
> idea ... also doing the calculation when the number
> of running/uninterruptible processes has changed would
> be a good idea ...
> 

Apart from the problem Con pointed out, you'd need a fancier algorithm
to calculate load because your interval isn't going to be fixed, so you
need to factor that in when calculating the area under the 'curve'
(loadavg).

I think the good 'ol 5 seconds should be alright.
