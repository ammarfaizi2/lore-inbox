Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUE0VSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUE0VSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUE0VSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:18:37 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:25752 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265261AbUE0VSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:18:35 -0400
Message-ID: <40B65B0F.9090106@zytor.com>
Date: Thu, 27 May 2004 14:18:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mem= handling mess.
References: <20040527200320.GR22630@redhat.com>
In-Reply-To: <20040527200320.GR22630@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> At some point in time during 2.4, parse_cmdline_early() changed
> so that it handled such boot command lines as..
> 
> mem=exactmap mem=640k@0 mem=511m@1m
> 
> And all was good.  This change propagated forward into 2.5,
> where it sat for a while, until hpa freaked out and
> Randy Dunlap sent in cset 1.889.364.25
> 
> ChangeSet 1.889.364.25 2003/03/16 23:22:16 akpm@digeo.com
>   [PATCH] Fix mem= options
>   
>   Patch from "Randy.Dunlap" <rddunlap@osdl.org>
>   
>   Reverts the recent alteration of the format of the `mem=' option.  This is
>   because `mem=' is interpreted by bootloaders and may not be freely changed.
>   
>   Instead, the new functionality to set specific memory region usages is
>   provided via the new "memmap=" option.
>   
>   The documentation for memmap= is added, and the documentation for mem= is
>   updated.
> 
> This is all well and good, but 2.4 never got the same treatment.
> Result ? Now users are upgrading their 2.4 systems to 2.6,
> and finding that they don't boot any more.
> (See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=124312
>  for example).
> 
> The "`mem=' is interpreted by bootloaders and may not be freely changed."
> obviously hasn't broken the however many users of this we have in 2.4
> so I don't buy that it'll break in 2.6 either.  As its now in 2.4
> (and has been there for some time), this is something that bootloaders
> will just have to live with.
> 

It was changed to memmap= I thought.  The command line suggested above, for 
example, WILL NOT boot with any correctly operating boot loader. 
Unfortunately, given its history I suspect GRUB is nowhere in that category.

I think telling people to use memmap= instead of mem= is the only sane way to 
deal with this.

What is even more puzzling is that the command line used by the user in that 
question is bogus, and should be *exactly* identical to "mem=512M", but the 
bug report indicates that doesn't work on that machine.  Thus, there is 
something more seriously wrong.

	-hpa

