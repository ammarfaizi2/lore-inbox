Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286528AbRL0Ton>; Thu, 27 Dec 2001 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286532AbRL0Toc>; Thu, 27 Dec 2001 14:44:32 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:55541 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S286528AbRL0ToV>; Thu, 27 Dec 2001 14:44:21 -0500
Date: Thu, 27 Dec 2001 13:50:37 -0600
From: Mark J Roberts <mjr@znex.org>
To: linux-kernel@vger.kernel.org
Subject: Framebuffer, mmap(), hanging in D state, root FS unmount failure.
Message-ID: <20011227195037.GA229@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <assert.h>
#include <sys/mman.h>
#include <fcntl.h>
int main(void)
{
	char *p;
	assert((p = mmap(0, 1, PROT_READ|PROT_WRITE, MAP_SHARED, open("/dev/fb/0", O_RDWR), 0)) != MAP_FAILED);
	p[4096] = 0; /* this hangs */
	return 0;
}

When I run this on my 2.4.17rc2aa2 kernel with a Voodoo3000
framebuffer, the process hangs forever in D state. ps and top will
then hang the same way when they read the /proc/pid files for the
hung process. And my root filesystem won't unmount.

It only happens when PROT_READ|PROT_WRITE is specified - when I use
only PROT_WRITE, the program segfaults like you'd expect.... but
once the PROT_READ|PROT_WRITE version has hung, PROT_WRITE-only
versions will also hang.
