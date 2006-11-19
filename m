Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756435AbWKSFvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbWKSFvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 00:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756436AbWKSFvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 00:51:15 -0500
Received: from ns1.suse.de ([195.135.220.2]:706 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1756434AbWKSFvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 00:51:14 -0500
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: reiserfs NET=n build error
Date: Sun, 19 Nov 2006 06:50:49 +0100
User-Agent: KMail/1.9.5
Cc: lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org, Jeff Mahoney <jeffm@suse.com>,
       Al Viro <viro@ftp.linux.org.uk>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
In-Reply-To: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611190650.49282.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 November 2006 05:22, Randy Dunlap wrote:
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

iirc Al Viro has been cleaning that up. Essentially reiserfs should
use its own C copy of the checksum functions. Using csum_partial() is not
safe because its output varies by architecture.

I would copy a relatively simple C implementation, like arch/h8300/lib/checksum.c

-Andi
