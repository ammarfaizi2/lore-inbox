Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWBQB3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWBQB3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWBQB3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:29:40 -0500
Received: from smtp.enter.net ([216.193.128.24]:55813 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750857AbWBQB3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:29:40 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.16-rc3-git7 build failure if sysfs disabled
Date: Thu, 16 Feb 2006 20:38:54 -0500
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <9a8748490602161542k1b282097ub754e6f0287780d2@mail.gmail.com>
In-Reply-To: <9a8748490602161542k1b282097ub754e6f0287780d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602162038.54871.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 February 2006 18:42, Jesper Juhl wrote:
> 2.6.16-rc3-git7 fails to build when sysfs is disabled with the
> attached .config .
>
> Without sysfs enabled :
>
>   LD      vmlinux
>
> lib/lib.a(kobject_uevent.o)(.text+0x1d5): In function `kobject_uevent':
> : undefined reference to `uevent_seqnum'
>
> lib/lib.a(kobject_uevent.o)(.text+0x1db): In function `kobject_uevent':
> : undefined reference to `uevent_seqnum'
>
> lib/lib.a(kobject_uevent.o)(.text+0x1e7): In function `kobject_uevent':
> : undefined reference to `uevent_seqnum'
>
> lib/lib.a(kobject_uevent.o)(.text+0x1ed): In function `kobject_uevent':
> : undefined reference to `uevent_seqnum'
>
> lib/lib.a(kobject_uevent.o)(.text+0x22c): In function `kobject_uevent':
> : undefined reference to `uevent_helper'
>
> lib/lib.a(kobject_uevent.o)(.text+0x2c0): In function `kobject_uevent':
> : undefined reference to `uevent_helper'
>
> lib/lib.a(kobject_uevent.o)(.text+0x2d3): In function `kobject_uevent':
> : undefined reference to `uevent_helper'
>
> make: *** [vmlinux] Error 1
>
> If sysfs is switched on the same config builds just fine.
>
> The .config is attached.

I've been looking at this for a few minutes now and wondering - since sysfs is 
an integrated part of the new module system there isn't an easy solution in 
the KConfig system. Perhaps providing a stub function that does nothing for 
builds that have sysfs turned off would be better...

Either that, or leave the function in and have its function depend, in some 
function, on whether sysfs was loaded as a module or isn't present at all. 
Truthfully, though, I don't know if that's possible.

DRH
