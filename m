Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVINRBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVINRBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVINRBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:01:39 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:59614 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1030284AbVINRBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:01:38 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <43285762.7070300@zytor.com>
Date: Wed, 14 Sep 2005 10:01:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <4328299C.9020904@tmr.com> <20050914170107.GB9096@mars.ravnborg.org>
In-Reply-To: <20050914170107.GB9096@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>  
> 
>>The kernel predates C99, sort of, and it would be a massive but valuable 
>> task to figure out where a type is really, for instance, 32 bits 
>>rather than "size of default int" in length, etc, and use POSIX types 
>>where they are correct. Fewer things to maintain, and would make it 
>>clear when something is 32 bits by default and when it really must be 32 
>>bits.
> 
> This has been discussed several times on lkml.
> Ask google...
> In short - the kernel provide its own namespace, and here __u32 etc is
> used. And starting to change that would be a noisy effort with no or
> limited gain neither for the kernel nor userspace.
> 

More specifically, replacing u32 with uint32_t as the kernel-internal 
type would be fine and arguably useful; in fact, a handful of drivers I 
believe already use it.

Replacing __u32 with uint32_t would be wrong, because it would require 
some user space headers that cannot include <stdint.h> to have to do so. 
  POSIX has *very* specific rules for namespace pollution, and most 
libcs have to care about that (klibc doesn't, but it's an exception, not 
the rule.)

	-hpa
