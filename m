Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVGME3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVGME3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 00:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVGME3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 00:29:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57282 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262558AbVGME3m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 00:29:42 -0400
Message-ID: <42D498AF.5070401@us.ibm.com>
Date: Tue, 12 Jul 2005 21:29:35 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <Pine.BSO.4.62.0507121544450.6919@rudy.mif.pg.gda.pl> <17107.57046.817407.562018@tut.ibm.com> <Pine.BSO.4.62.0507121731290.6919@rudy.mif.pg.gda.pl> <17107.61271.924455.965538@tut.ibm.com> <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0507121840260.6919@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:

> On Tue, 12 Jul 2005, Tom Zanussi wrote:
> [..]
>
>> > DTrace real examples shows something completly diffret.
>> > MANY things (if not ~almost all) can be kept only in aggregated form
>> > during experiments.
>>
>> But you can also do the aggregation in user space if you have a cheap
>> way of getting it there, as we've shown with some of the examples.
>
>
> Sorry but real life examples shows that store chunk of data in 
> agregator is less expensive than context switch neccessary for store 
> data or time neccasy for send and handle signal from buffer like "I'm 
> full! let me out of here ..".
>
> [..]
>
>> > store raw data. What you need ? only one counter (few bytes) 
>> instead of huge
>> > amount of memeory for buffer and store logs. Try measure something 
>> like
>> > scheduler with possible small system distruption.
>>
>> Most of the time the data is just being buffered and only when the
>> buffer is full is it written to disk, as one write.  If that's too
>> disruptive, then maybe you do need to do some aggregation in the kernel,
>> but it sounds like a special case.
>
>
> OK .. "so you can say better is stop flushing buffers on measure which 
> wil take day or more" ? :_)
> Some DTrace probes/technik are specialy prepared for long or evel very 
> long time experiment wich will only prodyce few lines results on end 
> of experiment.
> Look at DTrace documentation for speculative tracing:
> http://docs.sun.com/app/docs/doc/817-6223/6mlkidli7?a=view
>
> Some experiments do not have deterinistic time and must be finished 
> after i. e. "occasional failing". What if it will take so long so you 
> will fill all avalaible storage in relayfs way ?
> OK, never mind .. you have discontinued storage. Using kind 
> speculative tracing way I'll have result *just after* "occasional 
> failing" and you will start parse data stored using relayfs.
>
> kloczek


O.K, Tomasz your point is we can do aggregation in the kernel and cut 
down the amount of data that needs to be sent out from the kernel hence 
we don't need an efficient, low overhead mechanism like relayfs to get 
the data out of the kernel. Having relayfs doesn't prevent someone in 
aggregating the data in the kernel, so it is not an argument for not 
including relayfs in the kernel when it fills the need for those who 
needs raw data.

I am part of a team working on systemtap where we are are developing a 
tool similar to Dtrace that does some aggregation where appropriate but 
nothing like fancy statistics etc. We use relayfs in our systemtap 
project and  based on my reading of Dtrace paper they use exactly 
similar to relayfs buffering mechanism as well.

There are tools like itrace and Intel has one (i forgot the name) they 
would like to get the raw data into user space and do all kinds of  
fancy statistical analysis, visualization etc. Their value add is the 
analysis of the data. I am sure you are not suggesting pushing 
capabilities of those tools to the kernel, right.

As Steven Rostedt mentioned in his initial reply in this thread, many of 
us have written adhoc buffering scheme similar to what relayfs provides 
to debug kernel problems that happen after a long running test, if such 
facility already exists in the kernel everyone doesn't have to develop one.

I would like to see relayfs merged.




