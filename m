Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVIKAv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVIKAv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVIKAv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:51:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964778AbVIKAv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:51:58 -0400
Date: Sat, 10 Sep 2005 17:48:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
Message-Id: <20050910174818.579bc287.akpm@osdl.org>
In-Reply-To: <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
	<20050903064124.GA31400@codepoet.org>
	<4319BEF5.2070000@zytor.com>
	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
	<dfhs4u$1ld$1@terminus.zytor.com>
	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
	<20050910014543.1be53260.akpm@osdl.org>
	<4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
	<20050910150446.116dd261.akpm@osdl.org>
	<E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> > Have we worked out how it is to be done?
> 
>  Here's what we've got so far:
> 
>  1)  At some point the arch/driver/etc maintainers (for anything that
>  interacts with userspace), need to start converting things on their
>  own (such as moving ioctl and struct declarations to a <kabi/*.h>
>  header file), because the people working on it certainly don't have
>  all the varieties of hardware and userspace programs that would be
>  affected by this change.

This will be very disruptive.

>  2)  The goal is to minimize changes to kernel code.  I'm not out to
>  rename "struct list_head", that would be silly!  Instead, the header
>  <linux/list.h>  would be basically reduced to this:
> 
>  #ifndef  __LINUX_LIST_H
>  # define __LINUX_LIST_H 1
>  # ifdef __KERNEL__
> 
>  #  define __kcore_list_item list_head
>  #  include <kcore/list.h>
>  #  define list_add(x,y) __kcore_list_add(x,y)
> 
>  [...etc...]
> 
>  # endif /* __KERNEL__ */
>  #endif /* not __LINUX_LIST_H */

I hope list.h was a poorly-chosen example, and that there are no plans to
actually do anything like the above to list.h.

Surely the only files which need to be altered are those which we can
reasonably expect userspace to actually include.

>  3)  Another side effect of this project will be that we will have
>  the chance to clean up and merge some of the stuff currently in
>  the asm-* directories.

I'd suggest that you avoid side-effects.  Unrelated cleanups are unrelated
- do it as a separate project.

I'm very dubious about the whole idea, frankly.
