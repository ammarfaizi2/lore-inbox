Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWISSD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWISSD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWISSD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:03:27 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21403 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751916AbWISSD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:03:26 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=f2QhgQUlhd98vPL8avMCENugiwXdNPeyULTZ8jCS4MuK7TjiocRH+08nt6smg2i0C
	wSdhmgAugggVIzHeZrw5w==
Message-ID: <451030A6.6040801@google.com>
Date: Tue, 19 Sep 2006 11:02:14 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com>
In-Reply-To: <20060919070516.GD23836@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Ah, good point. Though ... how much do we care what the speed of
>>insertion/removal actually is? If we can tolerate it being slow,
>>then just sync everyone up in an IPI to freeze them out whilst
>>doing the insert.
>>
> 
> I guess using IPI occasionally would be acceptable. But I think
> using IPI for each probes will lots of overhead.

Depends how often you're inserting/removing probes, I guess.
Aren't these being done manually, in which case it really can't
be that many? Still doesn't fix the problem Matieu just pointed
out though. Humpf.

>>How about we combine all three ideas together ...
>>
>>1. Load modified copy of the function in question.
>>2. overwrite the first instruction of the routine with an int3 that
>>does what you say (atomically)
>>3. Then overwrite the second instruction with a jump that's faster
>>4. Now atomically overwrite the int3 with a nop, and let the jump
>>take over.
> 
> That's a good solution.

It's not exactly elegant or simple, but I guess it'd work if we have
to go to that extent. Seems like a lot of complexity though, I'd
rather get rid of the int3 trap if we can.

M.
