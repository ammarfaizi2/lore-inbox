Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291874AbSBAR2p>; Fri, 1 Feb 2002 12:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291875AbSBAR2f>; Fri, 1 Feb 2002 12:28:35 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:1530 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S291874AbSBAR2T>; Fri, 1 Feb 2002 12:28:19 -0500
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v199.8 available
In-Reply-To: <200201210635.g0L6ZjA22202@vindaloo.ras.ucalgary.ca>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200201210635.g0L6ZjA22202@vindaloo.ras.ucalgary.ca>
Date: 01 Feb 2002 18:18:18 +0100
Message-ID: <m2it9h3yud.fsf@localhost.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "richard" == Richard Gooch <rgooch@ras.ucalgary.ca> writes:

richard> Hi, all. Version 199.8 of my devfs patch is now available from:
richard> http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
richard> The devfs FAQ is also available here.

richard> Patch directly available from:
richard> ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

richard> AND:
richard> ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

richard> This is against 2.4.18-pre4. Highlights of this release:

richard> - Fixed deadlock bug in <devfs_d_revalidate_wait>



I still has that bug with 2.4.18-pre7, and it has this patch applied.

stack traces are:

p1:
        schedule()
        devfs_de_revalidate_wait()
        cached_lookup()
        lookup_hash()
        sys_unlink()
        system_call()

p2:

        schedule()
        wait_for_devfsd_finished()
        devfs_lookup(()
        lookup_hash()
        unix_bind()
        sys_bind()
        sys_socketcall()
        system_call()

the thing that they are tring to create/remove is /dev/log.

And devfsd is already running in that state:

    __schedule()
    __down()
    __down_failed()
    __text_lock_namei()

This has worked normally until now, it has beggining to fail yesterday.

Later, Juan.




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
