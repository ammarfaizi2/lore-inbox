Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWHBDHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWHBDHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWHBDHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:07:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27336 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751090AbWHBDHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:07:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<115443023544-git-send-email-ebiederm@xmission.com>
	<p73zmeoz2l4.fsf@verdi.suse.de>
Date: Tue, 01 Aug 2006 21:06:19 -0600
In-Reply-To: <p73zmeoz2l4.fsf@verdi.suse.de> (Andi Kleen's message of "01 Aug
	2006 21:19:03 +0200")
Message-ID: <m1ejvzx2dw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>  			}
>> @@ -200,6 +224,178 @@ static void putstr(const char *s)
>>  	outb_p(0xff & (pos >> 1), vidport+1);
>>  }
>>  
>> +static void vid_console_init(void)
>
> Please just use early_printk instead of reimplementing this. 
> I think it should work in this context too.

There is certainly some value in that.  To do that I would
need to refactor early_printk to make it useable.

This comment from one of patches summaries the worst of the problems.

> /* WARNING!!
>  * This code is compiled with -fPIC and it is relocated dynamically
>  * at run time, but no relocation processing is performed.
>  * This means that it is not safe to place pointers in static structures.
>  */

lib/string.c might be useful.  The fact that the functions are not
static slightly concerns me.  I have a vague memory of non-static
functions generating relocations for no good reason.

Eric
