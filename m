Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSLMTdT>; Fri, 13 Dec 2002 14:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSLMTdT>; Fri, 13 Dec 2002 14:33:19 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:55992 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265306AbSLMTdS> convert rfc822-to-8bit; Fri, 13 Dec 2002 14:33:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_epoll for 2.4
Date: Fri, 13 Dec 2002 20:40:45 +0100
User-Agent: KMail/1.4.3
References: <200212122303.gBCN3O721003@eng2.beaverton.ibm.com>
In-Reply-To: <200212122303.gBCN3O721003@eng2.beaverton.ibm.com>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Janet Morgan <janetmor@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212132038.23469.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 December 2002 00:03, Janet Morgan wrote:

Hi Janet,

> The attached patch is a port of Davide's sys_epoll from 2.5.51 to 2.4.20.
I get this while make modules:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include  -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DSMBFS_PARANOIA -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=sock  -c -o sock.o sock.c
sock.c: In function `smb_receive_poll':
sock.c:323: warning: passing arg 1 of `poll_initwait' from incompatible 
pointer type
sock.c:328: warning: passing arg 1 of `poll_freewait' from incompatible 
pointer type
sock.c:334: warning: passing arg 1 of `poll_freewait' from incompatible 
pointer type
sock.c:337: structure has no member named `error'
sock.c:338: structure has no member named `error'
make[2]: *** [sock.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.20/fs/smbfs'
make[1]: *** [_modsubdir_smbfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/fs'
make: *** [_mod_fs] Error 2

This is SMBfs as module.

The code is this starting at line 333:

                timeout = schedule_timeout(timeout);
                poll_freewait(&wait_table);
                set_current_state(TASK_RUNNING);

                if (wait_table.error) {
                        result = wait_table.error;
                        break;
                }

                if (signal_pending(current)) {


ciao, Marc
