Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWHGPGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWHGPGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWHGPGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:06:31 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:19 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750913AbWHGPGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:06:30 -0400
Message-ID: <44D75691.8070908@shadowen.org>
Date: Mon, 07 Aug 2006 16:04:49 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86_64 command line truncated II
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <p73slk8pq6s.fsf_-_@verdi.suse.de> <44D75151.5070504@shadowen.org> <200608071646.53886.ak@suse.de>
In-Reply-To: <200608071646.53886.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 07 August 2006 16:42, Andy Whitcroft wrote:
>> Andi Kleen wrote:
>>> Andi Kleen <ak@suse.de> writes:
>>>
>>>> Andy Whitcroft <apw@shadowen.org> writes:
>>>>
>>>>> It seems that the command line on x86_64 is being truncated during boot:
>>>> in mm right?
>>>>> Will try and track it down.
>>>> Don't bother, it is likely "early-param" (the patch from
>>>> hell). I'll investigate.
>>> Following up myself ... 
>>>
>>> Are you sure it's a regression? 2.6.17 does the same
>>> and we always had that 255 character limit (I tried 
>>> to increase it once, but it broke some old lilo setups) 
>>>
>>> i386 should be the same btw.
>> Its not being truncated at 255 characters, its being truncated at the 
>> first space.  This is coming out of parse_args, which dumps '\0's into 
>> the command_line as it rips it apart.  We now only have one copy of the 
>> command line (in x86_64) instead of two, so we now expose this trashed 
>> copy in /proc/cmdline.
> 
> I don't see this in my version; so it's likely fixed already. I did quite
> a lot of changes on this patch already.
> 
> Please test
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/early-param

Easier said than done as the original version is unwilling to revert. 
Looking at the replacement patch it has the same fix I have been testing 
to restore the original dual buffer semantic.  So I think it would fix 
the problem we're seeing here.  I'll follow up to this email with the 
incremental patch I tested with 2.6.18-rc2-mm2.

-apw
