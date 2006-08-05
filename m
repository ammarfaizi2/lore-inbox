Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWHEQIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWHEQIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 12:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWHEQIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 12:08:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52375 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030189AbWHEQIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 12:08:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060706081520.GB28225@host0.dyn.jankratochvil.net>
	<aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>
	<20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060804210826.GE16231@redhat.com>
	<m164h8p50c.fsf@ebiederm.dsl.xmission.com>
	<20060804234327.GF16231@redhat.com>
Date: Sat, 05 Aug 2006 10:07:01 -0600
In-Reply-To: <20060804234327.GF16231@redhat.com> (Don Zickus's message of
	"Fri, 4 Aug 2006 19:43:27 -0400")
Message-ID: <m1hd0rmaje.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

>> The length error comes from lib/inflate.c 
>> 
>> I think it would be interesting to look at orig_len and bytes_out.
>> 
>> My hunch is that I have tripped over a tool chain bug or a weird
>> alignment issue.
>
> I thought so too, but I took vmlinuz images from people (Vivek) who had it
> boot on their systems but those images still failed on my two machines.  
>
>> 
>> The error is the uncompressed length does not math the stored length
>> of the data before from before we compressed it.  Now what is
>> fascinating is that our crc's match (as that check is performed first).
>> 
>> Something is very slightly off and I don't see what it is.
>
> I printed out orig_len -> 5910532 (which matches vmlinux.bin)
>              bytes_out -> 5910531
>
>> 
>> After looking at the state variables I would probably start looking
>> at the uncompressed data to see if it really was decompressing
>> properly.  If nothing else that is the kind of process that would tend
>> to spark a clue.
>
> I am not familiar with the code, so very few sparks are flying.  I'll
> still dig through though.  Thanks for the tips.

I guess the interesting thing to do would be to 
- Recompute the crc to see if we still match.
- Possibly instrument of flush_window.

I have a strange feeling that the uncompressed data is getting corrupted
after we have flushed the window.

Eric


