Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWFUTi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWFUTi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWFUTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:38:34 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:10598 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932706AbWFUTiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:38:22 -0400
Message-ID: <4499A030.8020106@sbcglobal.net>
Date: Wed, 21 Jun 2006 14:38:24 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Martin Peschke <mp3@de.ibm.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, greg@kroah.com, akpm@osdl.org,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
References: <20060613232131.GA30196@kroah.com>	 <20060613234739.GA30534@kroah.com>	 <20060613171827.73cd0688.rdunlap@xenotime.net> <4490923D.10904@de.ibm.com>	 <20060619221238.GA20018@kroah.com> <449816D1.3040104@de.ibm.com>	 <20060620095015.532901b4.rdunlap@xenotime.net> <1150915877.2938.133.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
In-Reply-To: <1150915877.2938.133.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke wrote:
> On Tue, 2006-06-20 at 09:50 -0700, Randy.Dunlap wrote:
>> On Tue, 20 Jun 2006 17:40:01 +0200 Martin Peschke wrote:
>>> Greg KH wrote:
>>>>> 7) With regard to the delivery of statistic data to user land,
>>>>> a library maintaining statistic counters, histograms or whatever
>>>>> on behalf of exploiters doesn't need any help from the exploiter.
>>>>> We can avoid the usual callbacks and code bloat in exploiters
>>>>> this way.
>>>> I don't really understand what you are stating here.
>>> Sorry.
>>> 1,$s/exploiter/client/g
>>>
>>> Any device driver or whatever gathering statistics data currently
>>> has code dealing with showing the data. Usually, they have some
>>> callbacks for procfs, sysfs or whatever.
>>>
>>> My point is that, if a library keeps track of statistics on behalf
>>> of its clients, no client needs to be called back in order to
>>> merge, format, copy, etc. data being shown to users. The library
>>> can handle as a background operation without disturbing clients.
>> That could be a good thing.  OTOH, it means that the library
>> has to be either all-ways flexible or willing to change to
>> accommodate clients since you can't predict the universe of all
>> clients' requirements.
> 
> Right. I have made provisions for that to some degree.
> 
> 
> First, I could imagine that the statistics data of a client requires
> a new way its data should be aggregated and, therewith, requires
> a new form of statistic result being shown to users.
> 
> I have scanned through the kernel sources for ways of aggregating
> and showing statistics data. The usual constructs appear to be:
> 
> - counter
> - histogram (for intervals), linear scale
> - histogram (for intervals), logarithmic scale
> - "histogram" for discrete and sparse values
> - "utilisation indicator" or "fill level indicator" (num-min-avg-max)
> 
> These are implemented in my patches. I would expect these to cover most
> requirements of possible new clients.

So you're saying, as regards "putting presentation format in ... the 
kernel", that we already have presentation formats specified pell-mell 
in the kernel.  That should then be a non-issue, because you aren't 
introducing anything new, just centralizing an existing kernel behavior. 
  Do I have you right?

> 
> If another construct would be needed anyway, it can be added to the
> statistics library by implemententing about half a dozen routines
> described by struct statistic_discipline. I might be wrong, but I don't
> think we would see an inflationary growth there.
> 
> 
-- elision --
> 
> OTOH, I don't see a real need for allowing that. Data can be reformatted
> and rearranged in any possible way in user space.

Because you're just providing a range of basic output formats, 
standardized.  So anybody can ask for statistics from the kernel in a 
preferred output to then massage as needed in userland.  ACK?  Am I 
oversimplifying?

Matt


