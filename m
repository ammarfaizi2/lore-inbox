Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUCDN2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUCDN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:28:17 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:37761 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261895AbUCDN2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:28:02 -0500
To: linuxabi@zytor.com
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<200402292130.55743.mmazur@kernel.pl>
	<c1tk26$c1o$1@terminus.zytor.com>
	<200402292221.41977.mmazur@kernel.pl> <yw1xn0711sgw.fsf@kth.se>
	<40434BD7.9060301@nortelnetworks.com>
	<m37jy4cuaw.fsf@defiant.pm.waw.pl>
	<20040303152213.GA2148@mars.ravnborg.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 03 Mar 2004 17:49:28 +0100
In-Reply-To: <20040303152213.GA2148@mars.ravnborg.org> (Sam Ravnborg's
 message of "Wed, 3 Mar 2004 16:22:13 +0100")
Message-ID: <m3u115zxif.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> IIRC the current agreed scheme is something along the lines of this:
>
> abi/abi-linux/* Userspace relevant parts of include/linux
> abi/abi-asm/ symlink to abi/abi-$(ARCH)
> abi/abi-i386 i386 specific userland abi
> abi/abi-ppc  ppc ....

More efforts, no real effects.
I don't think we need such an infrastructure.
The normal headers should just be usable for user-space inclusion.

However I realize that the difference isn't that important, as long
as we don't duplicate the definitions etc.

> So a header file in include/linux with a counterpart in abi could look
> like this:
>
> include/linux/wait.h:
> #include <abi-linux/wait.h>
>
> #include <linux/config.h>
> typedef struct __wait_queue wait_queue_t;
> ...
>
>
> abi/abi-linux/wait.h:
> #define WNOHANG         0x00000001
> #define WUNTRACED       0x00000002

why not:

include/linux/wait.h:

#define WNOHANG         0x00000001
#define WUNTRACED       0x00000002

#ifdef __KERNEL__

#include <linux/config.h>
...

#endif /* __KERNEL__ */

> But in the end the gain from a scheme like this outweights the drawbacks
> - IMHO.

Such as? In comparison to a (fixed) present situation?
-- 
Krzysztof Halasa, B*FH
