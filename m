Return-Path: <linux-kernel-owner+w=401wt.eu-S1751286AbXAKBIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbXAKBIo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXAKBIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:08:44 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:48166 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751286AbXAKBIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:08:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VuVDzL0SX+lf/BnzvWPS7nKMxSJsGWKTyxwz0TB7qml+4ceiIJr6pV/8KXgkpk1FpjcnQO0ugNA6Vs650nam2wC7Na8hEzUkk5UbUzNuzLYgl0Clpy+WuFBTSDaUr4Zngsuba3xybkxnKE3j1aZYknAZSBxOpAh5qUjfl20339E=  ;
X-YMail-OSG: GofaDC4VM1kf_88czbNlzaIiA_73c2CcGhzTTB0GkT4yoXdQnvbgWX_hEzIsuJb3LajBfqHgOqNjc.DFo6uuslMQZ6lsINiq9IxOA1gj4hUsi2eGrCCe14D4wsSxFmvDmfiN.tKLbLgj1jG7zBBVa6PgfkYMoLdmh1UfM3dyUw2j71HJ4TOKDuZEBwCL
Message-ID: <45A58DFA.8050304@yahoo.com.au>
Date: Thu, 11 Jan 2007 12:08:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au> <20070111003158.GT33919298@melbourne.sgi.com>
In-Reply-To: <20070111003158.GT33919298@melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:
> On Thu, Jan 11, 2007 at 10:13:55AM +1100, Nick Piggin wrote:
> 
>>David Chinner wrote:
>>
>>>On Wed, Jan 10, 2007 at 03:04:15PM -0800, Christoph Lameter wrote:
>>>
>>>
>>>>On Thu, 11 Jan 2007, David Chinner wrote:
>>>>
>>>>
>>>>
>>>>>The performance and smoothness is fully restored on 2.6.20-rc3
>>>>>by setting dirty_ratio down to 10 (from the default 40), so
>>>>>something in the VM is not working as well as it used to....
>>>>
>>>>dirty_background_ratio is left as is at 10?
>>>
>>>
>>>Yes.
>>>
>>>
>>>
>>>>So you gain performance by switching off background writes via pdflush?
>>>
>>>
>>>Well, pdflush appears to be doing very little on both 2.6.18 and
>>>2.6.20-rc3. In both cases kswapd is consuming 10-20% of a CPU and
>>>all of the pdflush threads combined (I've seen up to 7 active at
>>>once) use maybe 1-2% of cpu time. This occurs regardless of the
>>>dirty_ratio setting.
>>
>>Hi David,
>>
>>Could you get /proc/vmstat deltas for each kernel, to start with?
> 
> 
> Sure, but that doesn't really show the how erratic the per-filesystem
> throughput is because the test I'm running is PCI-X bus limited in
> it's throughput at about 750MB/s. Each dm device is capable of about
> 340MB/s write, so when one slows down, the others will typically
> speed up.

But you do also get aggregate throughput drops? (ie. 2.6.20-rc3-worse)

> So, what I've attached is three files which have both
> 'vmstat 5' output and 'iostat 5 |grep dm-' output in them.

Ahh, sorry to be unclear, I meant:

   cat /proc/vmstat > pre
   run_test
   cat /proc/vmstat > post

It might just give us a hint what is changing (however vmstat doesn't
give much interesting in the way of pdflush stats, so it might not
show anything up).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
