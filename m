Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWHCFGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWHCFGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWHCFGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:06:09 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46725 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932250AbWHCFGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:06:08 -0400
Message-ID: <44D1843F.9090309@vmware.com>
Date: Wed, 02 Aug 2006 22:06:07 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Subject: Re: [patch] espfix cleanup take 2
References: <44D0D643.6090108@aknet.ru> <20060802203336.c4f8a428.akpm@osdl.org>
In-Reply-To: <20060802203336.c4f8a428.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 02 Aug 2006 20:43:47 +0400
> Stas Sergeev <stsp@aknet.ru> wrote:
>
>   
>> Attached is a new espfix cleanup patch.
>>     
>
> Ho hum, this conflicts moderately with the hypervisor preparatory patches
> which Jeremy sent.
>
> So could I ask that you redo this patch in a couple of weeks time against
> the current -mm lineup?  I'd prefer not to merge it immediately because
> doing so would make it even harder than usual to work out who to blame if
> things break ;)
>   

That would be my preference as well - I don't really have the bandwidth 
to do a full review / test and integration of Stas's patch right now.  
Subtle isn't really the word for this change - NMIs, debug handling, 
sysenter, kernel stack copying, segment registers, interrupts, kernel 
exception fixup, 16-bit stacks, descriptor tables and now CFI 
annotations all come into play.  Basically, all the evil and tricky 
parts of i386 all come out to play together, and the control flow is 
non-linear in places.  Sadomasochistic is a more appropriate word.  But 
it is a very nice change, and I would like to see it merged into -mm 
eventually.  I actually have an ad-hoc test suite that tests most of 
these paths, but I've never gotten formal and rigorous enough with it to 
publish.  I'll see if I can do that sometime in the next two weeks ;)

Zach
