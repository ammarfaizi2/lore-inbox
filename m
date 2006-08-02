Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWHBQQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWHBQQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWHBQQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:16:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29162 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932082AbWHBQQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:16:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sam Ravnborg <sam@ravnborg.org>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 4/33] i386: CONFIG_PHYSICAL_START cleanup
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302312298-git-send-email-ebiederm@xmission.com>
	<20060801190838.GB12573@mars.ravnborg.org>
Date: Wed, 02 Aug 2006 10:14:13 -0600
In-Reply-To: <20060801190838.GB12573@mars.ravnborg.org> (Sam Ravnborg's
	message of "Tue, 1 Aug 2006 21:08:38 +0200")
Message-ID: <m164hbru7e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Tue, Aug 01, 2006 at 05:03:19AM -0600, Eric W. Biederman wrote:
>> Defining __PHYSICAL_START and __KERNEL_START in asm-i386/page.h works but
>> it triggers a full kernel rebuild for the silliest of reasons.  This
>> modifies the users to directly use CONFIG_PHYSICAL_START and linux/config.h
>> which prevents the full rebuild problem, which makes the code much
>> more maintainer and hopefully user friendly.
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>>  arch/i386/boot/compressed/head.S |    8 ++++----
>>  arch/i386/boot/compressed/misc.c |    8 ++++----
>>  arch/i386/kernel/vmlinux.lds.S   |    3 ++-
>>  include/asm-i386/page.h          |    3 ---
>>  4 files changed, 10 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/i386/boot/compressed/head.S
> b/arch/i386/boot/compressed/head.S
>> index b5893e4..8f28ecd 100644
>> --- a/arch/i386/boot/compressed/head.S
>> +++ b/arch/i386/boot/compressed/head.S
>> @@ -23,9 +23,9 @@
>>   */
>>  .text
>>  
>> +#include <linux/config.h>
>
> You already have full access to all CONFIG_* symbols - kbuild includes
> it on the commandline. So please kill this include.

Stupid questions:
- Why do we still have a linux/config.h if it is totally redundant.
- Why don't we have at least a #warning in linux/config.h that would
  tell us not to include it.
- Why do we still have about 200 includes of linux/config.h in the
  kernel tree?

I would much rather have a compile error, or at least a compile
warning rather than needed a code review to notice this error.

We haven't needed this header since october of last year.

Eric
