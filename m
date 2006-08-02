Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWHBCbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWHBCbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWHBCbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:31:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1929 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751076AbWHBCbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:31:50 -0400
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
Date: Tue, 01 Aug 2006 20:30:17 -0600
In-Reply-To: <p73zmeoz2l4.fsf@verdi.suse.de> (Andi Kleen's message of "01 Aug
	2006 21:19:03 +0200")
Message-ID: <m1r6zzx41y.fsf@ebiederm.dsl.xmission.com>
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

It doesn't or at least it didn't.  I can look again though.

>> +static inline int tolower(int ch)
>> +{
>> +	return ch | 0x20;
>> +}
>> +
>> +static inline int isdigit(int ch)
>> +{
>> +	return (ch >= '0') && (ch <= '9');
>> +}
>> +
>> +static inline int isxdigit(int ch)
>> +{
>> +	ch = tolower(ch);
>> +	return isdigit(ch) || ((ch >= 'a') && (ch <= 'f'));
>> +}
>
> And please reuse the Linux code here.

Reuse is hard because we really are a separate executable,
in a slightly different environment.

> Actually the best way to reuse would be to first do 64bit uncompressor
> and linker directly, but short of that #includes would be fine too.

> Would be better to just pull in lib/string.c

Maybe.  Size is fairly important here so I am concerned that I
will pull in more than I need.  But look and see if I can pull
in just a subset of what is needed.

Eric
