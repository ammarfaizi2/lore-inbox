Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUFOQsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUFOQsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUFOQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:48:54 -0400
Received: from [213.13.117.218] ([213.13.117.218]:19637 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S265773AbUFOQsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:48:52 -0400
Date: Tue, 15 Jun 2004 17:48:48 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com
Subject: [2.4] build error with latest BK
Message-ID: <20040615164848.GA8276@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,


Just pulled latest bk of 2.4 and it appears to be broken. The recent  
rwsem race fixes seem to be the culprit (see  
http://linux.bkbits.net:8080/linux-2.4/cset@40cee86dCLGhZc1lEOWZV6K7FysQlw?nav=index.html| 
ChangeSet@-1d). Reversing it fixes the problem.


gcc -D__KERNEL__ -I/usr/local/src/linux-2.4/include -Wall -Wstrict- 
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit- 
frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   - 
nostdinc -iwithprefix include -DKBUILD_BASENAME=rwsem  -DEXPORT_SYMTAB -c  
rwsem.c
rwsem.c: In function `__rwsem_do_wake':
rwsem.c:67: warning: implicit declaration of function `put_task_struct'
rwsem.c: In function `rwsem_down_failed_common':
rwsem.c:131: error: `mem_map' undeclared (first use in this function)
rwsem.c:131: error: (Each undeclared identifier is reported only once
rwsem.c:131: error: for each function it appears in.)
make[2]: *** [rwsem.o] Error 1
make[2]: Leaving directory `/usr/local/src/linux-2.4/lib'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/local/src/linux-2.4/lib'
make: *** [_dir_lib] Error 2


x86 target, gcc 3.3.2 (or 2.95.4 prerelease). Ping me if you need .config  
or anything else.


[nuno@calvin] /usr/local/src/linux-2.4$ patch -Rp1 < fix-rwsem-race
patching file lib/rwsem-spinlock.c
patching file lib/rwsem.c
[nuno@calvin] /usr/local/src/linux-2.4$ cd lib
[nuno@calvin] ..src/linux-2.4/lib$ gcc -D__KERNEL__ -I/usr/local/src/ 
linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno- 
strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack- 
boundary=2 -march=athlon   -nostdinc -iwithprefix include - 
DKBUILD_BASENAME=rwsem  -DEXPORT_SYMTAB -c rwsem.c
[nuno@calvin] ..src/linux-2.4/lib$ echo $?
0



Regards,


		Nuno
