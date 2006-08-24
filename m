Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWHXSvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWHXSvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWHXSvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:51:15 -0400
Received: from khc.piap.pl ([195.187.100.11]:59776 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030448AbWHXSvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:51:14 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Stuart MacDonald <stuartm@connecttech.com>,
       linux-serial@vger.kernel.org, "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
	<1156411101.3012.15.camel@pmac.infradead.org>
	<m3bqqap09a.fsf@defiant.localdomain>
	<1156441293.3007.184.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 24 Aug 2006 20:51:12 +0200
In-Reply-To: <1156441293.3007.184.camel@localhost.localdomain> (Alan Cox's message of "Thu, 24 Aug 2006 18:41:33 +0100")
Message-ID: <m31wr6otlr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Does that mean that standard things like termios will use:
>> #define B9600   9600
>> #define B19200 19200
>
> That would have been very smart when Linus did Linux 0.12, unfortunately
> he didn't and we've also got no spare bits. Worse still if we exported
> them that way glibc has now way to map new speeds onto the old ones for
> applications.

Hmm... I'm not sure if I understand this correctly. Can't we just
create the 3 new ioctls in the kernel and teach glibc to use it?

The compatibility ioctls would talk to new ioctls only and translate
things. Anything (userspace) wanting non-traditional speeds would
have to use new interface (i.e., be compiled against the new glibc)
and the speeds would show as EXTA or EXTB or something when queried
using old ioctl.

Yes, the binary interface between glibc and userland would change
(with compatibility calls translated by glibc to new ioctls, or to
old ones on older kernels).

The old ioctls would be optional in the kernel (and perhaps in glibc,
sometime).

Not sure if we want int, uint, or long long for speed values :-)
-- 
Krzysztof Halasa
