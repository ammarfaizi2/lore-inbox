Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLLE23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLLE23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVLLE23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:28:29 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:65427 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751087AbVLLE22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:28:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ozm1ntcGHGxX+D4HcqHGS64NOYn2hkGSDn5sd71ZionW8ojjKgUGQhDSv3vH8vFA3w5qYX70BD/k9zva3/s8AR2ss6IEsdO9r6m96zL53d0cvajUmx+EbNRN3cxmdDg/DihtHFUgKeFoStDMzCxjLfxr/zHjmv6z4Oc9eatZgJw=  ;
Message-ID: <439CFC67.4030107@yahoo.com.au>
Date: Mon, 12 Dec 2005 15:28:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com> <439CF2A2.60105@yahoo.com.au> <20051212035631.GX11190@wotan.suse.de> <439CF93D.5090207@yahoo.com.au> <20051212042142.GZ11190@wotan.suse.de>
In-Reply-To: <20051212042142.GZ11190@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Dec 12, 2005 at 03:14:53PM +1100, Nick Piggin wrote:

>>Cool. That is a patch that should go on top of mine, because most of
>>my patch is aimed at moving modifications under interrupts-off sections,
> 
> 
> That's obsolete then.

No it isn't.

> With local_t you don't need to turn off interrupts
> anymore.
> 

Then you can't use __local_xxx, and so many architectures will use
atomic instructions (the ones who don't are the ones with tripled
cacheline footprint of this structure).

Sure i386 and x86-64 are happy, but this would probably slow down
most other architectures.

> 
>>However I'm still worried about the use of locals tripling the cacheline
>>size of a hot-path structure on some 64-bit architectures. Probably we
>>should get them to try to move to the atomic64 scheme before using
>>local_t here.
> 
> 
> I think the right fix for those is to just change the fallback local_t
> to disable interrupts again - that should be a better tradeoff and
> when they have a better alternative they can implement it in the arch.
> 

Probably right.

> (in fact i did a patch for that too, but considered throwing it away
> again because I don't have a good way to test it) 
> 

Yep, it will be difficult to test.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
