Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWENH2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWENH2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWENH2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:28:08 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:3200 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751362AbWENH2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:28:07 -0400
Message-ID: <4466DC03.6050003@gmail.com>
Date: Sun, 14 May 2006 08:28:03 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 4/6] Add kmemleak support for i386
References: <20060513155757.8848.11980.stgit@localhost.localdomain>  <20060513160612.8848.95311.stgit@localhost.localdomain> <9a8748490605131124i236227a9s3a47a070cfc308a7@mail.gmail.com> <Pine.LNX.4.61.0605132315370.11638@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605132315370.11638@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>[snip]
>>
>>>+static inline unsigned long arch_call_address(void *frame)
>>>+{
>>>+       return *(unsigned long *) (frame + 4);
>>
>>     return *(unsigned long *)(frame + 4);
> 
> 
> I would like to point out that a __bulitin_return_address(immediate int) 
> and __builtin_frame_address(immediate int) exist (but they can 
> unfortunately not be used with variables even though that would not pose 
> much of a problem on x86).

The code already uses __builtin_frame_address(0) and
__builtin_return_address(0) (the latter only if CONFIG_FRAME_POINTER is
not defined) but using these with a variable doesn't work on all
architectures (ARM being one of them, where I did the initial development).

Catalin
