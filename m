Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbTCSX5b>; Wed, 19 Mar 2003 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCSX5b>; Wed, 19 Mar 2003 18:57:31 -0500
Received: from ns.suse.de ([213.95.15.193]:28165 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263299AbTCSX5a>;
	Wed, 19 Mar 2003 18:57:30 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
References: <20030319232157.GA13415@elf.ucw.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Mar 2003 01:08:27 +0100
In-Reply-To: Pavel Machek's message of "20 Mar 2003 00:48:29 +0100"
Message-ID: <p7365qe5284.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> --- linux-test/include/linux/compat_ioctl.h	2003-03-20 00:08:12.000000000 +0100
> +++ linux/include/linux/compat_ioctl.h	2003-03-19 23:36:24.000000000 +0100
> @@ -0,0 +1,641 @@
> +/* List here explicitly which ioctl's are known to have
> + * compatible types passed or none at all...
> + */
> +/* Big T */
> +COMPATIBLE_IOCTL(TCGETA)

Shouldn't you put the include files needed for all that in there too?

Otherwise you have another ugly list to duplicate. The includes
cannot be put inside the ioctl list, because in some extreme 
case they can generate code (e.g. when gcc decides to ignore inline
again and emits functions for includes)

It could be done with a special symbol like:

#ifdef DO_INCLUDES
#include foo1
#include foo2
#else
COMPATIBLE_IOCTL(...)
#endif

-Andi
