Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264371AbRFHVty>; Fri, 8 Jun 2001 17:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264374AbRFHVtp>; Fri, 8 Jun 2001 17:49:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:1291 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264371AbRFHVtg>; Fri, 8 Jun 2001 17:49:36 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux kernel headers violate RFC2553
Date: 8 Jun 2001 14:49:29 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9frh99$7bi$1@penguin.transmeta.com>
In-Reply-To: <20010608195719.A4862@fefe.de> <15137.8668.590390.10485@pizda.ninka.net> <20010608211247.A12925@codeblau.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010608211247.A12925@codeblau.de>,
Felix von Leitner  <leitner@fefe.de> wrote:
>Thus spake David S. Miller (davem@redhat.com):
>>  > glibc works around this, but the diet libc uses the kernel headers and
>>  > thus exports the wrong API to user land.
>> Don't user kernel headers for userspace.
>
>What choice do I have?
>Duplicate everything and then be out of sync when the specs change?

Yes.

Even more preferably - write user-space headers that have _only_ the
minimum amount of code in them. The kernel headers have a lot of cruft
that is kernel-only, and that means that if you compile user space using
them, your compiles will be slower than they should be.

The basic issue is that the kernel will _refuse_ to follow the
"namespace of the day" rules of C89, C99, POSIX, BSD, SuS, GNU .. the
list goes on. The kernel headers are not meant to be used in user space,
and will not have the strict namespace rules that a lot of standards
spend so much time playing with.

There aren't that many things that are actually useful in the kernel
headers anyway.  Most of them (like the IPv6 stuff) are really specified
in other places in the first place. 

		Linus
