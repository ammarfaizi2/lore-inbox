Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUKZXG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUKZXG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUKZTtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:49:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262394AbUKZT3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:15 -0500
Date: Thu, 25 Nov 2004 18:45:53 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041125184553.GB2849@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19865.1101395592@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 03:13:12PM +0000, David Howells wrote:
>  (2) Take each file from the shadowed directory. If it has any userspace
>      relevant stuff, then:
> 
>      (b) Make kernel file #include the user file. So:
> 
> 		[include/asm-i386/unistd.h]
> 		...
> 		#include <user-i386/unistd.h>
> 		...

We may also want a user-asm symlink pointing to user-$ARCH.
If <linux/foo.h> wants a definition from <user-$ARCH/foo.h> then it has
to include <asm/foo.h> which includes <user-$ARCH/foo.h>.  If asm/foo.h
is empty other than the include, then it'd be nice to delete it and have
<linux/foo.h> include <user-asm/foo.h> directly.

>      (c) Where a user header file requires something from another header file
> 	 (such as a type), that file should include a suitable user header file
> 	 directly:
> 
> 		[include/user-i386/termio.h]
> 		...
> 		#include <user/types.h>
> 		...

It's occasionally been on my mind that the transition from linux -> asm
should be one way and that asm files should not include linux files.
I'm not sure this is necessarily a worthy goal, but it seems worth
mentioning.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
