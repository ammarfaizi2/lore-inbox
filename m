Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUJVRZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUJVRZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUJVRV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:21:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9704 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266578AbUJVROn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:14:43 -0400
Date: Fri, 22 Oct 2004 13:14:27 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift key-related error codes up and insert ECANCELED
Message-ID: <20041022171427.GN31909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20498.1098464262@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20498.1098464262@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 05:57:42PM +0100, David Howells wrote:
> 
> This patch shifts the key-related error codes up by one and inserts an
> ECANCELED error code where not already defined. It seems that has been defined
> in glibc without passing it back to the kernel:-/

Not sure what's the story behind ECANCELED not being in kernel headers,
certainly it is something only userland needs ATM.
It is a POSIX mandated errno code used in aio_* that glibc is using
since 1998, so it would be really bad to break all apps using aio.

The values you posted match exactly what glibc is using:

libc/sysdeps/unix/sysv/sysv4/solaris2/bits/errno.h:# define ECANCELED   47      /* Operation canceled.  */
libc/sysdeps/unix/sysv/aix/bits/errno.h:# define ECANCELED      117     /* Asynchronous i/o cancelled.  */
libc/sysdeps/unix/sysv/linux/alpha/bits/errno.h:#  define ECANCELED     131
libc/sysdeps/unix/sysv/linux/sparc/bits/errno.h:#  define ECANCELED     127
libc/sysdeps/unix/sysv/linux/bits/errno.h:#  define ECANCELED   125
libc/sysdeps/unix/sysv/linux/hppa/bits/errno.h:#  define ECANCELED      ECANCELLED
libc/sysdeps/mach/hurd/bits/errno.h:#define     ECANCELED       _HURD_ERRNO (118)/* Operation canceled */

just maybe asm-parisc/errno.h could have
#define ECANCELED ECANCELLED
added (ECANCELED is the POSIX mandated spelling, while asm-parisc/errno.h
for some reason defines ECANCELLED).

	Jakub
