Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRBMOob>; Tue, 13 Feb 2001 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131620AbRBMOoL>; Tue, 13 Feb 2001 09:44:11 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:45696 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131728AbRBMOoB>; Tue, 13 Feb 2001 09:44:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk> 
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk> 
To: Tony Gale <gale@syntax.dera.gov.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Feb 2001 14:43:40 +0000
Message-ID: <21887.982075420@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gale@syntax.dera.gov.uk said:
> 
>    This is a long-standing problem with 2.3 and 2.4 SMP kernels.  I
> believe it is a kernel bug and isn't the XFree86 project's problem.
> The problem does not exist on 2.2 SMP kernels nor on 2.3/4 UP kernels.
>  The symptoms are random segfaults in perfectly fine XFree86 code.

> Anyone looking into this?

I had an XFree86 setup which was perfectly stable in RH6.2, and had been 
for some months. Upon upgrading to RH7 - with glibc-2.2 and new 
screensavers, it started falling over almost every night.

The crashes got less frequent when I started running X against glibc-2.1
(note _running_ against glibc-2.1, not just compiling against it and running
against glibc-2.2). But they were still happening. 

In the week or so since killing xscreensaver, neither of the boxen on which
I was seeing this have fallen over. Another box on which I killed 
xscreensaver but didn't run X against glibc-2.1 is still suffering, albeit 
less frequently. 

Looks like two separate bugs - I see no reason to expect that there's only 
one such bug causing X to fall over :)

If others can try these remedies and confirm that they really do help, and
it's not just the statistics playing silly buggers with my brain, that'd 
hopefully give us some lead on getting it fixed.


passion /etc/X11 $ cat X
#!/bin/sh

logger "X restarting"
free | logger
cp /var/log/XFree86.0.log /var/log/XFree86.0.log-old
sync
sync
sync

exec /usr/i386-glibc21-linux/lib/ld-linux.so.2 --library-path /usr/i386-glibc21-linux/lib /usr/X11R6/bin/XFree86-4.0.2-glibc2.1 -modulepath /usr/X11R6/lib/modules-4.0.2-glibc2.1/ "$@"


--
dwmw2


