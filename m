Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbTCRASm>; Mon, 17 Mar 2003 19:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbTCRASm>; Mon, 17 Mar 2003 19:18:42 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:33802 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262033AbTCRASk>;
	Mon, 17 Mar 2003 19:18:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: [patch] 2.4.21-pre5 kksymoops for i386/ia64 
In-reply-to: Your message of "17 Mar 2003 15:20:15 -0000."
             <1047914414.28282.91.camel@passion.cambridge.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Mar 2003 11:29:23 +1100
Message-ID: <31927.1047947363@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2003 15:20:15 +0000, 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Mon, 2003-03-17 at 08:02, Keith Owens wrote:
>> Automatic decoding of oops on 2.5 has been very useful, so this patch
>> adds kksymoops support to 2.4.21-pre5.  Currently only for i386 and
>> ia64, other architectures are easy to add.
>
>> +KALLSYMS	= /sbin/kallsyms
>
>Kallsyms is arch-specific, isn't it? So shouldn't that be
>$(CROSS_COMPILE)kallsyms?

kallsyms does not build in cross compile mode.  There are hacked up
versions of kallsyms for specific cross compile environments and the
user selects them by make KALLSYMS=...  I was going to make modutils
fully cross compile compatible but now it has moved into the kernel
there is no point.  Pity that the kernel version is incomplete.

>How does one go about making non-native kallsyms? 

Google for kallsyms i386 ia64.

>The 2.5 kallsyms doesn't break cross-compilation, does it?

No, but neither does it support the section data that is needed for kdb
(and possibly kgdb).  The removal of section data in 2.5 is one of the
reasons that I no longer do kdb patches for 2.5 kernels.  If you want
to destroy kdb for 2.4 kernels as well, go ahead and use the 2.5
kallsyms.  It will actually make my life easier if I no longer have to
support kdb on standard kernels.

This patch does not break cross compilation either.  It is a
restriction that you cannot use kallsyms in cross compile mode unless
you have a version like kallsyms_i386_ia64.

