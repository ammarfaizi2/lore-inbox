Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTEHKad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 06:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTEHKac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 06:30:32 -0400
Received: from mxout3.netvision.net.il ([194.90.9.24]:239 "EHLO
	mxout3.netvision.net.il") by vger.kernel.org with ESMTP
	id S261265AbTEHKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 06:30:30 -0400
Date: Thu, 08 May 2003 13:43:14 +0300
From: Nir Livni <nirl@cyber-ark.com>
Subject: RE: shared objects, ELFs and memory usage
To: linux-kernel@vger.kernel.org
Message-id: <E1298E981AEAD311A98D0000E89F45134B55FD@ORCA>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.
Thanks,
I am beginning to see the full picture now.
But I guess I am still missing something.
In the following "top" output,

Mem:   512396K av,  509208K used,    3188K free,       0K shrd,   10248K
buff
Swap:  522072K av,       0K used,  522072K free                  417244K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME 
 1538 unt033     9   0  4528 4524  4128 S     8.9  0.8   0:04 
 1596 unt006    16   0  4540 4536  4132 S     3.1  0.8   0:04 
 1509 unt004    11   0  4528 4524  4128 S     2.9  0.8   0:03 

I understand that about 4MB from each process is shared using copy_on_write.

What does the "cached" portion of the output means ?
I see that almost all the "used" memory is also "cached".
(please CC me)

Thanks,
Nir

> 
> 
> On Thu, May 08, 2003 at 12:54:23PM +0300, Nir Livni wrote:
> > After compiling and linking my .so with the -shared option, I've 
> > inspected strace output. I can clearly see that the shared object 
> > (which is 2MB size) is NOT being
> > shared:
> > 1395  open("/usr/local/sharedclient.so", O_RDONLY) = 6
> > 1395  read(6, 
> > "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\200"...,
> > 1024) = 1024
> > 1395  fstat64(6, {st_mode=S_IFREG|0644, st_size=2079700, ...}) = 0
> > 1395  old_mmap(NULL, 2118824, PROT_READ|PROT_EXEC, 
> MAP_PRIVATE, 6, 0) =
> > 0x401ea000
> > Any idea why ?
> > (Please CC me because I am not subscribed)
> 
> It's called copy-on-write sharing. It is shared with the 
> proviso that all modified pages are privatized and not 
> committed to disk.
> 
> 
> -- wli
> 
