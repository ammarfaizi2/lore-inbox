Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422932AbWBCUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWBCUtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWBCUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:49:22 -0500
Received: from mail.gmx.net ([213.165.64.21]:3298 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422932AbWBCUtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:49:22 -0500
Date: Fri, 3 Feb 2006 21:49:20 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: matthias.andree@gmx.de
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, Joerg Schilling <schilling@fokus.fraunhofer.de>,
       michael.kerrisk@gmx.net
MIME-Version: 1.0
Subject: Re: Rationale for RLIMIT_MEMLOCK?
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <7554.1138999760@www048.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Matthias Andree <matthias.andree@gmx.de> wrote:

[...]

> The complete story is, condensed, and with return values, for a
> setuid-root application:
> 
>   geteuid() == 0;
>   mlockall(MLC_CURRENT|MLC_FUTURE) == (success);
>   seteuid(500) == (success);
>   valloc(64512 + pagesize) == NULL (failure);

[...]

A late follow-up to this thread. I've added the following text
to the mlockall() manual pag under BUGS:

    Since kernel 2.6.9, if a privileged process calls 
    mlockall(MCL_FUTURE) and later drops privileges
    (CAP_IPC_LOCK), then subsequent memory allocations
    (e.g., mmap(2), sbrk(2)) will fail if the 
    RLIMIT_MEMLOCK resource limit is encountered.
    
The change will be in man-pages 2.23.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
