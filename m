Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285317AbRLNJyW>; Fri, 14 Dec 2001 04:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285316AbRLNJyD>; Fri, 14 Dec 2001 04:54:03 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:15890 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S285315AbRLNJxz>;
	Fri, 14 Dec 2001 04:53:55 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: fd_setsize
Date: Fri, 14 Dec 2001 09:53:54 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9vci7i$8eh$2@ncc1701.cistron.net>
In-Reply-To: <OFB046FAEF.D6FAB48A-ON86256B22.00075ECB@3com.com>
X-Trace: ncc1701.cistron.net 1008323634 8657 195.64.65.67 (14 Dec 2001 09:53:54 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <OFB046FAEF.D6FAB48A-ON86256B22.00075ECB@3com.com>,
 <Hui_Ning@3com.com> wrote:
>I am using 2.4 kernel. How can I increase the fd_setsize so that I can use
>select to check more than 1024 file descriptors?

That's more a glibc question. On many systems, you can set
FD_SETSIZE before including <sys/select.h> and the libs will
use that FD_SETSIZE from that point on.

With glibc, you can't do that. Well that's not entirely true, the
following works but is not portable and an unbelievable hack.

BTW, why not use poll() - it has no fd_set imposed limit.

BTW2 don't forget to increase the ulimit filedescriptor max,
and perhaps /proc/sys/fs/{file-max,inode-max}

/*
 * Cannot increase FD_SETSIZE on Linux, but we can increase __FD_SETSIZE
 * with glibc 2.2 (or later? remains to be seen). We do this by including
 * bits/types.h which defines __FD_SETSIZE first, then we redefine
 * __FD_SETSIZE. Ofcourse a user program may NEVER include bits/whatever.h
 * directly, so this is a dirty hack!
 */
#include <features.h>
#if (__GLIBC__ > 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 2)
#    include <bits/types.h>
#    undef __FD_SETSIZE
#    define __FD_SETSIZE 8192
#endif

Mike.
-- 
Deadlock, n.:
        Deceased rastaman.

