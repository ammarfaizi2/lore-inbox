Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWC3Uce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWC3Uce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC3Uce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:32:34 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:48927 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750832AbWC3Ucd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:32:33 -0500
Message-ID: <442AC46F.2060107@tmr.com>
Date: Wed, 29 Mar 2006 12:31:27 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk
Subject: Re: HZ != 1000 causes problem with serial device shown by   git-bisect
References: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com> <1143555233.17522.23.camel@localhost.localdomain>
In-Reply-To: <1143555233.17522.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-03-27 at 18:46 -0500, Greg Lee wrote:
>> I am having a problem when using PPP over a particular PCMCIA based serial device and have
>> pinned the problem down using git-bisect to this particular commit that was made between
>> 2.6.12.6 and 2.6.13:
> 
> That would make sense.
> 
>> I have also tried a number of other kernels and the problem exists all the way to 2.6.15.6
>> but is fixed in 2.6.16, so I am going to git-bisect 2.6.15.6 to 2.6.16, but I thought I
>> would get this message out now in case someone has an inkling of what the problem is.
> 
> I think I can tell you fairly accurately if you are running fairly high
> data rates.
> 
> The old pre 2.6.16 tty code works something like this
> 
> Each serial IRQ
> 	add chars to buffer if they fit
> 
> Each timer IRQ
> 	switch buffers
> 	process original buffer
> 
> 
> So the higher HZ is the faster data speed you can do. With very high
> data rates lower HZ means more dropped characters.
> 
> 2.6.16 implements the new tty layer which replaces this with a proper
> buffering and queueing mechanism and is SMP aware (and thanks to Paul
> rather SMP clever too). 

Just as an aside to this and thanks to Paul, this seems in practice to 
work as well with HT (as I would expect) and handle fairly high rate 
(230kb) connections perfectly. I hope it applies for dumb multiport 
cards as well, I have a fair number of them here and there.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

