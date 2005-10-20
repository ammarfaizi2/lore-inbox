Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVJTRb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVJTRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVJTRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 13:31:59 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:57205 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932499AbVJTRb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 13:31:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dQ517zG5NDIK+dxqLZs5j2dqdh8lZPfmdlZX5s00b4az/1Kl85r6P287Xo+Y6pznYagK3uYtUBXY3XCNBJNTMseuWyUowj3+zn5meG6l/Rgv3jcq+UPEvgt2lO79cSzwUn6YkNPexKlScGtyT/fMOBcLiTyrj5S1C8Mv53Gb15I=
Message-ID: <4357D487.8000801@gmail.com>
Date: Fri, 21 Oct 2005 02:31:51 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 02/05] blk: update ioscheds to
 use generic dispatch queue
References: <20051019123429.450E4424@htj.dyndns.org> <20051019123429.D377069C@htj.dyndns.org> <20051020112109.GC2811@suse.de> <20051020135124.GB26004@htj.dyndns.org> <20051020141104.GQ2811@suse.de> <4357AB3F.1050004@gmail.com> <20051020144108.GR2811@suse.de> <4357B10E.7010608@gmail.com> <20051020170705.GU2811@suse.de>
In-Reply-To: <20051020170705.GU2811@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Oct 21 2005, Tejun Heo wrote:
> 
>> I think we're currently talking about two issues.
> 
> 
> I think so too :)
> 
> 
>> 1. Is @sort=0 case useful?
>>
>> Currently all ioscheds dispatch requests in sorted order.  I was 
>>afraid that sorting again might result in less efficient seek pattern 
>>although I'm not quite sure whether or how that will happen.  That's why 
>>I added the @sort argument to elv_dispatch_insert().  If sorting cannot 
>>hurt in any case, we might sort unconditionally and remove @sort 
>>argument from elv_dispatch_insert().
> 
> 
> That's what I ended up merging, elv_dispatch_sort() and it only takes q
> and rq as parameters.
> 
> 
>> 2. Why @force is used to turn on @sort?
> 
> 
> Yes, that was my question :-)
> 
> 
>> The reasoning was that, when a iosched is forced dispatched, it 
>>doesn't have control over many aspects of IO scheduling, so it cannot 
>>produce good ordering of dumped requests, which actually is true for 
>>cfq.  That's why @sort is turned on while force-dispatching requests.
> 
> 
> Well that's not quite my question, it is the opposite - why would you
> not want to sort?
> 
> 
>> Maybe just removing @sort argument from elv_dispatch_insert() and 
>>sorting always is the way to go?
> 
> 
> See the merged stuff, I think so. I just don't see any reason at all to
> tie 'force' and 'sort' together.
> 

  Yeap, merged version looks fine.

-- 
tejun
