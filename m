Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271125AbTGXH5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 03:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTGXH5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 03:57:55 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:20413 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271125AbTGXH5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 03:57:54 -0400
Message-ID: <3F1F9531.2050204@softhome.net>
Date: Thu, 24 Jul 2003 10:13:37 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
References: <cwQJ.3BO.29@gated-at.bofh.it> <cypH.5dM.35@gated-at.bofh.it> <cyza.5lN.13@gated-at.bofh.it> <cArg.74D.11@gated-at.bofh.it>
In-Reply-To: <cArg.74D.11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> On Wednesday 23 July 2003 22:27, Christoph Hellwig wrote:
> 
>>On Wed, Jul 23, 2003 at 01:22:56PM -0700, David S. Miller wrote:
>>>Drivers weren't audited much, and there's a lot of boneheaded
>>>stuff in this area.  But these should be mostly identical
>>>to what would happen on the 2.4.x side
>>
>>Please read the original message again - he stated that every single
>>module in fs/ got alot bigger - if it gets smaller or at least the
>>same size as 2.4 it's clearly a sign of inlines gone mad in the
>>filesystem/VM code and we need to look at that.  If not we have to look
>>elsewhere.
> 
> I have my humbling opinion:
> 
> In 2.4.20 (m68knommu):
> -------------------------------------------------------------------------
> #define current _current_task
> -------------------------------------------------------------------------
> 
> In 2.6.0-test1 (m68knommu):
> -------------------------------------------------------------------------
> static inline struct task_struct *get_current(void)
> {
    [cut]
> }
> static inline struct thread_info *current_thread_info(void)
> {
    [cut]
> }
> -------------------------------------------------------------------------
> 
> This takes 18*11 = 198 bytes just for invoking the 'current'
> macro so many times.
> 

    Just curious.

    Is there any way to guess inline from inline?

    I mean 'inline' which means 'this has to be inlined or it will 
break' and 'inline' which means 'inline this please - it adds only 10k 
of code bloat and improve performance in my suppa-puppa-bench by 0.000001%!'

    Strictly speaking - separate 'inline' to 'require_inline' and 
'better_inline'.
    So people who really care about image size - can turn 
'better_inline' into void, without harm to functionality.
    Actually I saw real performance improvements on my Pentium MMX 133 
(it has $i16k+$d16k of caches I beleive) when I was cutting some of 
inlines out. and I'm not talking about (cache poor) embedded systems...

