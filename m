Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWITRaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWITRaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWITRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:30:39 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:32183 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932103AbWITRah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:30:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=M01PoJVxYWdtqhLjEr9dAr8nFgv0fo+noA0LfGe9KcMrL/P6oEmHhLqHzkjjeAQDptA49xSfOvQKoKsetTF7ySk8TCbn/F/OBLdvvnnFLjJRNPnDI7JnZHti7vY+OQ1ZvJIy2GUjjgzphMQzWzTpHuAV0/o18MfXg32Z+f3ASkg=  ;
Message-ID: <45117AB6.5040403@yahoo.com.au>
Date: Thu, 21 Sep 2006 03:30:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, rohitseth@google.com,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
References: <1158718568.29000.44.camel@galaxy.corp.google.com>	 <4510D3F4.1040009@yahoo.com.au> <1158751720.8970.67.camel@twins>	 <4511626B.9000106@yahoo.com.au> <1158767787.3278.103.camel@taijtu>	 <451173B5.1000805@yahoo.com.au> <1158773800.7705.21.camel@localhost.localdomain>
In-Reply-To: <1158773800.7705.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-09-21 am 03:00 +1000, ysgrifennodd Nick Piggin:
> 
>> > I've been thinking a bit on that problem, and it would be possible to
>> > share all address_space pages equally between attached containers, this
>> > would lose some accuracy, since one container could read 10% of the file
>> > and another 90%, but I don't think that is a common scenario.
>>
>>
>>Yeah, I'm not sure about that. I don't think really complex schemes
>>are needed... but again I might need more knowledge of their workloads
>>and problems.
> 
> 
> Any scenario which permits "cheating" will be a scenario that happens
> because people will try and cheat.

That's true, and that's one reason why I've advocated the solution
implemented by Rohit's patches, that is: just throw in the towel and
be happy to count just pages.

Look at the beancounter stuff, and it has hooks (in the form of gfp
flags) throughput the tree, and they still manage to miss accounting
user exploitable memory overallocation from some callers. Maintaining
that will be much more difficult and error prone.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
