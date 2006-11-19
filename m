Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756687AbWKSON5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbWKSON5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756688AbWKSON5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:13:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38665 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756687AbWKSON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:13:57 -0500
Date: Sun, 19 Nov 2006 15:13:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org, ak@suse.de, discuss@x86-64.org
Subject: Re: reiserfs NET=n build error
Message-ID: <20061119141355.GH31879@stusta.de>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 08:22:06PM -0800, Randy Dunlap wrote:
> With CONFIG_NET=n and REISERFS_FS=m (randconfig), kernel build ends with
> 
> Kernel: arch/x86_64/boot/bzImage is ready  (#15)
>   Building modules, stage 2.
>   MODPOST 137 modules
> WARNING: "csum_partial" [fs/reiserfs/reiserfs.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> on both 2.6.19-rc6 and 2.6.19-rc6-git2.
> 
> Looks like arch/x86_64/lib/lib.a is not being linked into the
> final kernel image for some reason.  lib.a does contain csum_partial.

The bug is in arch/x86_64/lib/Makefile:

The problem is that lib-y objects only get linked into the kernel image 
when they are used in the kernel image.

Therefore, an EXPORT_SYMBOL in a lib-y object is a bug.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

