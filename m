Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRFTFPE>; Wed, 20 Jun 2001 01:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbRFTFOx>; Wed, 20 Jun 2001 01:14:53 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264841AbRFTFOn>; Wed, 20 Jun 2001 01:14:43 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Date: 19 Jun 2001 22:14:19 -0700
Organization: Transmeta Corporation
Message-ID: <9gpbfb$vlu$1@cesium.transmeta.com>
In-Reply-To: <15152.4073.812901.656882@pizda.ninka.net> <20010619205924.H5679@stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010619205924.H5679@stanford.edu>,
Zack Weinberg <zackw@Stanford.EDU> wrote:
>On Tue, Jun 19, 2001 at 07:52:25PM -0700, David S. Miller wrote:
>> 
>> Zack Weinberg writes:
>>  > It *has* been fixed in 2.4, though.  Some sort of compatibility issue?
>> 
>> No, some kind of "it doesn't matter" issue.
>
>I can demonstrate user code that behaves differently under 2.2 than
>2.4.  The example I have (appended) doesn't suffer data loss, but I
>bet I could make one that did.

Hey, I can demonstrate user code that behaves differently depending on
what compiler options were used etc.

Hint: "undefined behaviour".

If somebody passes in a bad pointer to a system call, you've just
invoced the rule of "the kernel _may_ be nice to you, but the kernel
might just consider you a moron and tell you it worked". 

There is no "lost data" or anything else. You've screwed yourself, and
you threw the data away. Don't blame the kernel.

And before you say "it has to return EFAULT", check the standards, and
think about the case of libraries vs system calls - and how do you tell
them apart?

		Linus
