Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263128AbTCTBZS>; Wed, 19 Mar 2003 20:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCTBZS>; Wed, 19 Mar 2003 20:25:18 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:56504 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263128AbTCTBZR>; Wed, 19 Mar 2003 20:25:17 -0500
Message-Id: <200303200136.h2K1aDsD001827@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
To: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Date: Thu, 20 Mar 2003 02:35:30 +0100
References: <20030320001013$67af@gated-at.bofh.it> <20030320001013$68b4@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Shouldn't you put the include files needed for all that in there too?
> 
> Otherwise you have another ugly list to duplicate. The includes
> cannot be put inside the ioctl list, because in some extreme 
> case they can generate code (e.g. when gcc decides to ignore inline
> again and emits functions for includes)

Why not simply move the common COMPATIBLE_IOCTLs and includes into
kernel/compat_ioctl.c or similar? That would IMHO be cleaner and
it does not need more preprocessing hacks.
There can still be a second init_sys32_ioctl() copy to handle the arch
specific list with additional translations.

        Arnd <><
