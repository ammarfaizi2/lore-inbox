Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUCDUxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUCDUxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:53:09 -0500
Received: from man-3.punkt.pl ([217.173.196.3]:50440 "EHLO prin.lo2.opole.pl")
	by vger.kernel.org with ESMTP id S262132AbUCDUxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:53:03 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Date: Thu, 4 Mar 2004 21:49:36 +0100
User-Agent: KMail/1.6.1
References: <200402291942.45392.mmazur@kernel.pl> <200403031829.41394.mmazur@kernel.pl> <m3brnc8zun.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3brnc8zun.fsf@defiant.pm.waw.pl>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200403042149.36604.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 of March 2004 15:13, Krzysztof Halasa wrote:
> Is it the kernel which is based on glibc, or is it glibc (and the rest of
> the userland as glibc isn't that special) using the kernel interface?
>
> The kernel doesn't need glibc at all, I don't know why do you want it
> to require some external headers to compile.
> Should the kernel behave differently when compiled with different glibc
> header sets? :-)

I never said kernel should require glibc - it shouldn't (mind you I don't do 
kernelland headers). But kernel does duplicate each and every structure 
provided by glibc. It has to. The Bad Thing (tm) is that all (well... allmost 
all - lots of linux headers don't parse correctly in userspace) of those 
structures get exported to userland. And programmers use them. They don't 
include <sys/resource.h>, but <linux/resource.h>. And that causes conflicts 
(and is bad practice).

> IMHO all the defines should be in the kernel tree. Glibc can and should
> use them, as it uses the ABI.

Parts of abi that are standardized 
(http://www.opengroup.org/onlinepubs/007904975/ - this thing; check the 
headers section), should be imho provided by C libs. These things do not 
change (they can't or everything would blow up) and I see no reason why glibc 
should rely on having additional headers available, just to do what it's 
supposed to.

> The open question (of much less importance) is if we want to keep
> the existing include/ layout or to move public parts to include/linux-abi
> etc. It still has to reside in the kernel tree, though. I'd go with the
> former for now as it requires less work. OTOH the latter might be
> cleaner.

Userland headers should be kept in /usr/include/{asm,linux}. I see no reason 
to change that (kernel headers have no business being in /usr/include btw). 
As to linux-common linux-kernelonly and linux-userland headers (linux-common 
used by both) - I just find it weird for userland to require kernel sources. 
Linux is supposed to have stable abi.

> > And we have to remember 2.4 compatibilities (which linux-libc-headers
> > have) -
> > is 2.6 kernel a place for them?
>
> Examples?
> If they are part of kernel API/ABI, then of course they are still used
> by 2.6 kernel and they need to be there. If they aren't used by the
> kernel (old #define names for instance) they should go to glibc headers
> (#ifndef xxx #define xxx etc.).

Additionall defines mostly. Probably some extra structures.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
