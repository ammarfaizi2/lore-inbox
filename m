Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265880AbUGHHcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUGHHcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUGHHcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:32:05 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:8122 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265880AbUGHHcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:32:02 -0400
Message-ID: <40ECF86D.3060707@yahoo.com.au>
Date: Thu, 08 Jul 2004 17:31:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org> <40ECF278.7070606@yahoo.com.au> <cone.1089270749.964538.4554.502@pc.kolivas.org>
In-Reply-To: <cone.1089270749.964538.4554.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Nick Piggin writes:

>> A few comments. I think making swappiness depend on the amount of
>> swap you have used is not a good idea. I might be wrong though, but
>> generally you should only make something *more* complex if you have
>> a good rationale and good numbers (you have the later, Andrew might
>> consider this enough). I especially don't like this sort of temporal
>> dependancy either, because it makes things much harder to reproduce
>> and think through.
> 
> 
> Noted. The amount of swap hardly has any effect on the swappiness except 
> when you're close to OOMing and it is harder to OOM with this in place.
> 

OK that's easy then. The OOM algorithm can be changed if it is
OOMing too easily.

>> Secondly, can you please not mess with the exported sysctl. If you
>> think your "autoswappiness" calculation is better than the current
>> swappiness one, just completely replace it. Bonus points if you can
>> retain the swappiness knob in some capacity.
> 
> 
> I agree and would like them all removed, but people just love to leave 
> the knobs in place. While I dont think the knobs should still be there 
> either, I'm not reluctant to leave something that innocuous if the users 
> want them.
> 

Well, get rid of the auto-tuning thing to start with, and merge
it into the swappiness calculation..

Regarding all these knobs, the main thing you want to avoid is
having loads of them because you can't find acceptable defaults.
I think "swappiness" is in the category of a good sysctl: it is
simple, meaningful to the admin, works, etc.

It has proven somewhat useful in testing ("set it to blah and see
if it still happens"). Or for people who know what they are doing.
