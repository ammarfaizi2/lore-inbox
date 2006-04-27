Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWD0Gcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWD0Gcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWD0Gcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:32:51 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:28115 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S964964AbWD0Gcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:32:50 -0400
Date: Thu, 27 Apr 2006 08:32:49 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060427063249.GH761@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I don't know if the patch to backport O_DIRECT support for ext3
under kernel 2.4.3x was finally accepted or not, but I'm having what
I consider inconsistent behaviour due to O_DIRECT under ext3fs and
kernel 2.4.32.

    I can understand that ext3 doesn't support O_DIRECT, and that's
not a problem for me. In fact, if an app really needs O_DIRECT and
the underlying filesystem doesn't support it, the app should fail, no
more and no less.

    The problem I'm having is with dvd+rw-tools. Apart from all the
problems regarding DVD writing, I have another problem: the open64
call with the O_DIRECT flag succeeds, but any subsequent read
operation fails. IMHO, if the filesystem is going to return EINVAL
for any read/write operation over an O_DIRECT'ed filehandle, it
should return an error when opening, too.

    The growisofs program tries to open a file using O_DIRECT and the
call succeeds, so it tries to read from that filehandle and the
result is always EINVAL. I've tried a test program, just in case the
problem was memory alignment of the buffer, but nothing is solved (I
used posix_memalign and some recipe I found in this list, using the
st_blksize and the st_size of the file). The problem seems to be in
the O_DIRECT flag, because removing it from the open call makes all
work.

    Shouldn't ext3fs return an error when the O_DIRECT flag is used
in the open call? Is the open call userspace only and thus only libc
can return such error? Am I misunderstanding the entire issue and
this is a perfectly legal behaviour (allowing the open, failing in
the read operation)?

    Thanks a lot in advance :)))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
