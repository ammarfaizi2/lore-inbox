Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVBVUWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVBVUWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVBVUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:22:55 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1236 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261226AbVBVUWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:22:53 -0500
Message-ID: <421B95B8.4070006@tmr.com>
Date: Tue, 22 Feb 2005 15:27:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX
 as device 
References: <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com> <200502190023.j1J0NBDi023090@turing-police.cc.vt.edu>
In-Reply-To: <200502190023.j1J0NBDi023090@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 18 Feb 2005 15:23:44 EST, Bill Davidsen said:
> 
> 
>>I'll try to build a truth table for this, I'm now working with some 
>>non-iso data sets, so I'm a bit more interested. I would expect read() 
>>to only try to read one sector, so I'll just do a quick and dirty to get 
>>the size from the command line, seek and read.
>>
>>I haven't had a problem using dd to date, as long as I know how long the 
>>data set was, but I'll try to have results tonight.
> 
> 
> The problem is that often you don't know exactly how long the data set is
> (think "backup burned to CD/RW") - there's a *lot* of code that does stuff
> like
> 
> 	while (actual=read(fd,buffer,65536) > 0) {
> 		...
> 	}
> 
> with the realistic expectation that the last read might return less than 64k,
> in which case 'actual' will tell us how much was read.  Instead, we just get
> an error on the read.
> 
> Note that 'dd' does this - that's why you get messages like '12343+1 blocks read'.
> We *really* want to get to a point where 'dd' will work *without* having to
> tell it a 'bs=' and 'count=' to get the size right....

I think I already had a pretty good grasp on that, in my previous post 
on this I noted: "The last time I looked at this, the issue was that the 
user software did a large read and the ide-cd didn't properly return a 
small data block with no error, but rather returned an error with no 
data. If you get the size of the ISO image, you can read that with any 
program which doesn't try to read MORE than that."

It sounds as if (a) the problem with ide-cd is going to get fixed, and 
(b) ide-scsi may not remain depreciated. A win-win if I ever saw one.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
