Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWDTQvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWDTQvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWDTQvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:51:15 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:31137 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751104AbWDTQvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:51:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=q5+lHR/+0z+Vd2TzAoNuEam8OekXm71W8E1zz7q1RxR24NPslk2dIS+VEUyDRuidpvJ1HmGeWkFwou2QJ8T3u2umA8T91UJWpkcYLSVOauvJ+foaHY/8kGr0cIICDdgarxV/m7sgeQFYfpTCzQHu/OMSDJK/WInpsEiEL8RvOug=  ;
Message-ID: <44473BA3.6090709@yahoo.com.au>
Date: Thu, 20 Apr 2006 17:43:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Theodore Ts'o" <tytso@mit.edu>, Erik Mouw <erik@harddisk-recovery.com>,
       Lee Revell <rlrevell@joe-job.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>	 <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe>	 <20060418163539.GB10933@thunk.org>	 <1145384357.2976.39.camel@laptopd505.fenrus.org>	 <20060419124210.GB24807@harddisk-recovery.com>	 <1145456594.3085.42.camel@laptopd505.fenrus.org>	 <20060419143815.GH706@thunk.org> <1145457937.3085.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1145457937.3085.49.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-04-19 at 10:38 -0400, Theodore Ts'o wrote:
> 
>>On Wed, Apr 19, 2006 at 04:23:14PM +0200, Arjan van de Ven wrote:
>>
>>>as long as the irqs are spread the apaches will (on average) follow your
>>>irq to the right cpu. Only if you put both irqs on the same cpu you have
>>>an issue
>>
>>Maybe I'm being stupid but I don't see how the Apache's will follow
>>the IRQ's to the right CPU.  I agree this would be a good thing to do,
>>but how does the scheduler accomplish this?
> 
> 
> iirc this part of the kernel uses wake_up_sync() and such, which tend to
> pull the apache to the cpu (if it's idle) in the long term
> (or it ought to; at one point it did)

Yeah it has "affine wakeups" now, which will do that for all
types of wakeups, and not just to idle CPUs either (sync
wakeups just get pulled a little more strongly).

IIRC SGI reported something like a factor 8 improvement in
CPU efficiency on a database IO simulation on a smallish
system (16-way maybe).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
