Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280894AbRKCAUD>; Fri, 2 Nov 2001 19:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280895AbRKCATx>; Fri, 2 Nov 2001 19:19:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59666 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280894AbRKCATh>; Fri, 2 Nov 2001 19:19:37 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Sat, 3 Nov 2001 00:16:46 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rvd1e$vk$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111021250560.20078-100000@penguin.transmeta.com> <Pine.LNX.4.33.0111021303060.20128-100000@penguin.transmeta.com> <20011102222754.2366f1f5.skraw@ithnet.com>
X-Trace: palladium.transmeta.com 1004746756 32206 127.0.0.1 (3 Nov 2001 00:19:16 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Nov 2001 00:19:16 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011102222754.2366f1f5.skraw@ithnet.com>,
Stephan von Krawczynski  <skraw@ithnet.com> wrote:
>
>> -	/* Don't swap out areas which are locked down */
>> -	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
>> +	/* Don't swap out areas which are reserved */
>> +	if (vma->vm_flags & VM_RESERVED)
>>  		return count;
>
>Although I agree what you said about differences of old and new VM, I believe
>the above was not really what Ben intended to do by mlocking. I mean, you swap
>them out right now, or not?

Not. See where I added the VM_LOCKED test - deep down in the page-out
code it will decide that a VM_LOCKED page is always accessed, and will
move it to the active list instead of swapping it out.

		Linus
