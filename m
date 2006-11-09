Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWKIOnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWKIOnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423712AbWKIOnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:43:08 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:24542 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S1422690AbWKIOnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:43:05 -0500
Message-ID: <45533F08.3040508@acm.org>
Date: Thu, 09 Nov 2006 08:45:28 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi_si_intf.c: fix "&& 0xff" typos
References: <20061108220925.GB4972@martell.zuzino.mipt.ru>            <45525712.8020103@acm.org> <200611090449.kA94nqsZ007282@turing-police.cc.vt.edu>
In-Reply-To: <200611090449.kA94nqsZ007282@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 08 Nov 2006 16:15:46 CST, Corey Minyard said:
>   
>> Ouch, I guess we've never had a system with these address types.  Thanks.
>>     
>
> If we never had a system with these address types..
>
>   
>>>  static unsigned char intf_mem_inw(struct si_sm_io *io, unsigned int offset)
>>>  {
>>>  	return (readw((io->addr)+(offset * io->regspacing)) >> io->regshift)
>>> -		&& 0xff;
>>> +		& 0xff;
>>>  }
>>>       
>
> Is this dead code that isn't called by anybody?
>   
Well, not exactly.  The SMBIOS or ACPI tables that report these interfaces
have various options for the size of the device registers.  The driver
implements all the options, but there may or may not be systems with
every option available.  But I can't exactly guess what is available in the
field.

-Corey

