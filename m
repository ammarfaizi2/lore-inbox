Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVG3BnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVG3BnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVG3BlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:41:16 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:27017 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262808AbVG3BkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:40:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=I1G6rkFni4/MiTY48m/OVhcq5SmWqgmPhyZk+Bqv+iTPYa/pWQ6mxU+T3xLPw8B3FVEsRLKnG9tFt+ILc3fs1orMOXEu6+Y8wsY7Mz7Ye7pb9I+4jk/x4oxZXLXHMYzyehSDSkfku889zDHk7lyMsH+hY9BLBg7/Xj78hcTthtc=
Message-ID: <42EADA76.2050606@pol.net>
Date: Sat, 30 Jul 2005 09:40:06 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       adaplas@gmail.com, ak@suse.de
Subject: Re: vesafb-fix-mtrr-bugs.patch added to -mm tree
References: <200507291825.j6TIParH012406@shell0.pdx.osdl.net>	<20050729185848.GP17003@redhat.com> <20050729180827.79679ff0.akpm@osdl.org>
In-Reply-To: <20050729180827.79679ff0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
>> On Fri, Jul 29, 2005 at 11:24:37AM -0700, Andrew Morton wrote:
>>
>>  > From: "Antonino A. Daplas" <adaplas@gmail.com>
>>  > 
>>  > >> vesafb: mode is 800x600x16, linelength=1600, pages=16
>>  > >> vesafb: scrolling: redraw
>>  > >> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
>>  > >> mtrr: type mismatch for fc000000,1000000 old: write-back new: write-
>>  > >> combining
>>  > 
>>  > Range is already set to write-back, vesafb attempts to add a write-combining
>>  > mtrr (default for vesafb).
>>  > 
>>  > >> mtrr: size and base must be multiples of 4 kiB
>>  > 
>>  > This is a bug, vesafb attempts to add a size < PAGE_SIZE triggering
>>  > the messages below.
>>
>> I fixed this a few weeks back. It's this line which your patch removes..
>>
>> -        while (temp_size > PAGE_SIZE &&
>>
>>  > To eliminate the warning messages, you can add the option mtrr:2 to add a
>>  > write-back mtrr for vesafb.  Or just use nomtrr option.
>>
>> If we need users to pass extra command line args to make warnings go
>> away, we may as well not bother. Because 99% of users will be completely
>> unaware that option even exists.  They'll still see the same message,
>> and still report the same bugs.
>>
>> The pains of MTRR strike again. This stuff is just screaming for
>> a usable PAT implementation. Andi, you were working on that, any news ?
>> Or should I resurrect Terrence's patch again ?
>>
> 
> Well something is still awry:
> 
> 
> 
> 
> Begin forwarded message:
> 
> Date: Fri, 29 Jul 2005 13:40:05 +0200
> From: Alessandro <alezzandro@gmail.com>
> To: Andrew Morton <akpm@osdl.org>
> Subject: Re: "mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining" on Kernel 2.6.12
> 
> 
> I try the new prepatch for the stable Linux kernel (2.6.13-rc4) but
> the problem is the same:
> ...
> vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 4608k,
> total 131072k
> vesafb: mode is 1024x768x24, linelength=3072, pages=55
> vesafb: protected mode interface info at c000:56cb
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
> mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,4000000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,2000000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,1000000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,800000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,400000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,200000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,100000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,80000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,40000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,20000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,10000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,8000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,4000 old: write-back new: write-combining
> mtrr: type mismatch for e0000000,2000 old: write-back new: write-combining

Vesafb defaults to write-combining mtrr.  But the memory range is already
set to write-back so mtrr_check() spewed the above messages. I don't think it
has any ill effects, but if you want to eliminate the above messages, tell
vesafb to also use write-back mtrr by adding the boot option "mtrr:2"
(or nomtrr).

I think I'll submit a documentation patch.

Tony
