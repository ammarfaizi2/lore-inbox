Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313864AbSDIMCj>; Tue, 9 Apr 2002 08:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313863AbSDIMCi>; Tue, 9 Apr 2002 08:02:38 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25349 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313864AbSDIMCg>;
	Tue, 9 Apr 2002 08:02:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 problems with netfilter linking 
In-Reply-To: Your message of "Sun, 07 Apr 2002 17:36:46 +1000."
             <20020407173646.40d7c0b7.rusty@rustcorp.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Apr 2002 22:02:25 +1000
Message-ID: <17932.1018353745@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002 17:36:46 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>On Sat, 06 Apr 2002 14:48:02 +1000
>Keith Owens <kaos@ocs.com.au> wrote:
>> * Change kbuild 2.5 to detect multi linked objects and not set
>>   KBUILD_OBJECT for those objects.  It follows that multi linked
>>   objects cannot have module or boot parameters, so change modules.h to
>>   barf on MODULE_PARM() and __setup() when KBUILD_OBJECT is not
>>   defined.
>> 
>> I am tending towards the second solution.
>
>You missed "#include "foo.c"" as a possible workaround.  Note that it's
>a waste of disk space, not memory, since these cannot be loaded at the
>same time.

I have implemented the second solution.  Multi linked objects get no
value for KBUILD_OBJECT.  I had to do this anyway, depending on which
order the objects were compiled, kbuild was registering different
values for KBUILD_OBJECT.  That was causing spurious rebuilds and the
command appeared to change.

