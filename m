Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTLFRth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265220AbTLFRtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:49:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:43485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265219AbTLFRte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:49:34 -0500
From: Craig Thomas <craiger@osdl.org>
Message-ID: <65094.4.5.34.184.1070732972.squirrel@www.osdl.org>
Date: Sat, 6 Dec 2003 09:49:32 -0800 (PST)
Subject: Re: Prcess scheduler Imiprovements in 2.6.0-test9
To: <piggin@cyberone.com.au>
In-Reply-To: <3FD1B47E.3050600@cyberone.com.au>
References: <1070650522.13254.28.camel@bullpen.pdx.osdl.net>
        <3FD1B47E.3050600@cyberone.com.au>
X-Priority: 3
Importance: Normal
Cc: <craiger@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> Craig Thomas wrote:
>
>>OSDL has been running peformance tests with hackbench to measure the
>> improvment of the scheduler, compared with LInux 2.4.18.  We ran the
>> test on our Scalable Test Platform on different system sizes.  The
>> results obtained seem to show that the 2.6 scheduler is more
>>efficient and allows for greater scalability on larger systems.
>>See http://marc.theaimsgroup.com/?l=linux-kernel&m=100805466304516&w=2
>> for a description of hackbench.
>>
>>The set of data below shows an average time of five hackbench runs for
>> each set of groups.  Linux 2.6.0-test9 clearly shows significan
>> improvement in the completion times.
>>
>>Test set 1: Performance of hackbench
>>
>>(times are in seconds, lower number is better)
>>
>>number of groups     50     100     150     200
>>--------------------------------------------------
>>1 CPU
>>   2.4.18          15.52   37.63   74.34   110.62
>>   2.6.0-test9      9.91   17.86   27.55    39.77
>>--------------------------------------------------
>>2 CPUs
>>   2.4.18          10.50   30.42   64.26   112.46
>>   2.6.0-test9      7.44   13.45   19.68    26.68
>>--------------------------------------------------
>>4 CPUs
>>   2.4.18           7.07   22.75   54.10   101.45
>>   2.6.0-test9      5.16   9.25    13.64    18.65
>>--------------------------------------------------
>>8 CPUs
>>   2.4.18           7.02   24.63   61.48   114.93
>>   2.6.0-test9      4.08   7.15    10.31    13.84
>>--------------------------------------------------
>>
>
> Hi Craig,
> The numbers here are very impressive. Is there is an easy way
> to make a table of results like this with STP? What is the
> exact parameter line you pass to hackbench to get this?
> These are results from a run with my scheduler patch on the
> 8-way. Not sure if they're comparable but if so they are a
> small improvement.
>
> 20 		1.69
> 40 		2.54
> 60 		3.41
> 80 		4.38
> 100 		5.44


I made a change to the STP version of hackbench so that you could enter
optional script parameters in the STP web interface.  I used the following
values:  25 200 (the increment and the maximum value). By default, the
values are 10 and 100; that's why the results you have shown stop at 100.
To enter your specific values, you need to type them in the "Optional
Script Parameters" text box on the first page of the STP run request
page (it is below the test selection pulldown).  Just enter the increment
followed by a space, followed by the maximum value you want.

Your patch looks much better for the first 100 groups.  I'll bet that
that it will look even better as you increase the max value.

One caution though, Since I did not tune the kernel, I ran out of
resources at the levels noted above.  The result from STP is that I
my hackbench run is automatically killed after 2 hours and the test
is marked as failed.  However, the data results are captured and you
can take the numbers and plot them manually.  I can help you get the
data if you have difficulty.

Now, to answer the question about an easy way to create a table like I
showed above.  We are working on an extensive tool to compare run results
of different tests, but we are still a few months away from completion.
In the mean time, let me know what results you are trying to compare,
and perhaps I can come up with a quick and dirty perl script to generate
the data.

Your results look impressive so far.  I think you'll have made a big
improvement when you increase the numbers of processes.


