Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUHWUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUHWUYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUHWUXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:23:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39826 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266905AbUHWTdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:33:32 -0400
Subject: Re: 2.6.8.1-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz Torcz <zdzichu@irc.pl>, akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823182113.GA30882@irc.pl>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <20040823182113.GA30882@irc.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093285874.29822.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 19:31:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 19:21, Tomasz Torcz wrote:
> >- This kernel has an x86 patch which alters the copy_*_user() functions so
> >  they will return -EFAULT on a fault rather than the number of bytes which
> >  remain to be copied.  This is a bit of an experiment, because this seems to
> >  be the preferred API for those functions.   It's a see-what-breaks thing.
> >
> 
>  Things appear to broke. Sometimes kernel starts to spit page allocation
> failures into log for few minutes, despite memory beeing available:

The kernel relies on copy_from_user returning the number of bytes copied
so no suprise there. In fact if it returns -EFAULT and you've not
reworked all the drivers (including out of kernel serial drivers in
particular) you get a security hole because you can move the buffer
pointers backwards.

Other code uses it to decide what object was passed for compatibility
too.

Alan


