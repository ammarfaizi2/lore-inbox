Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWCIIp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWCIIp5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 03:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWCIIp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 03:45:57 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:32855 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750862AbWCIIp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 03:45:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qw+9o4LJAPf49j1PRnuAeheRYj6s/KlTIC7+lQLeL0U2m8sX8DxUQUEazxzOZYdRGcCXeSI0K2P+y3RvUREjLa/pv1kjAQNYGbJ2bjepnx+sP8bXPseqzCgyulYjY2dyeDe8eNV1BHTCbeWAjApgqBvHf4WF19QIYEXTi1zaNH0=  ;
Message-ID: <440FEA24.3060307@yahoo.com.au>
Date: Thu, 09 Mar 2006 19:41:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, bcrl@kvack.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org, Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
References: <20060308203642.GZ5410@kvack.org> <20060308210726.GD4493@localhost.localdomain> <20060308211733.GA5410@kvack.org> <20060308222528.GE4493@localhost.localdomain> <20060308224140.GC5410@kvack.org> <20060308154321.0e779111.akpm@osdl.org> <20060309001803.GF4493@localhost.localdomain> <20060308163258.36f3bd79.akpm@osdl.org> <20060309080651.GA3599@localhost.localdomain> <440FE3E2.1060307@yahoo.com.au> <20060309082251.GB3599@localhost.localdomain>
In-Reply-To: <20060309082251.GB3599@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> On Thu, Mar 09, 2006 at 07:14:26PM +1100, Nick Piggin wrote:
> 
>>Ravikiran G Thirumalai wrote:
>>
>>
>>>Here's a patch making x86_64 local_t to 64 bits like other 64 bit arches.
>>>This keeps local_t unsigned long.  (We can change it to signed value 
>>>along with other arches later in one go I guess) 
>>>
>>
>>Why not just keep naming and structure of interfaces consistent with
>>atomic_t?
>>
>>That would be signed and 32-bit. You then also have a local64_t.
> 
> 
> No, local_t is supposed to be 64-bits on 64bits arches and 32 bit on 32 bit
> arches.  x86_64 was the only exception, so this patch fixes that.
> 
> 

Right. If it wasn't I wouldn't have proposed the change.

Considering that local_t has been broken so that basically nobody
is using it, now is a great time to rethink the types before it
gets fixed and people start using it.

And modelling the type on the atomic types would make the most
sense because everyone already knows them.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
