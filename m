Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVCAUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVCAUYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVCAUYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:24:23 -0500
Received: from colin2.muc.de ([193.149.48.15]:18451 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262016AbVCAUYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:24:19 -0500
Date: 1 Mar 2005 21:24:17 +0100
Date: Tue, 1 Mar 2005 21:24:17 +0100
From: Andi Kleen <ak@muc.de>
To: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net, bernd-schubert@gmx.de
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050301202417.GA40466@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 32bit:
> ------
> hitchcock:/home/bernd/src/tests# strace32 ./test_stat32 /mnt/test/yp
> execve("./test_stat32", ["./test_stat32", "/mnt/test/yp"], [/* 39 vars */]) = 
> 0
> uname({sys="Linux", node="hitchcock", ...}) = 0
> brk(0)                                  = 0x80ad000
> brk(0x80ce000)                          = 0x80ce000
> stat64("/mnt/test/yp", {st_mode=S_IFDIR|0755, st_size=2704, ...}) = 0

It returns 0 which is success. How can it match this code? 

	if (stat (dir, &buf) == -1)
                 fprintf(stderr, "stat for %s failed \n", dir);

It is most likely some kind of user space problem.  I would change
it to int err = stat(dir, &buf);
and then go through it with gdb and see what value err gets assigned.

I cannot see any kernel problem.

> write(2, "stat for /mnt/test/yp failed \n", 30stat for /mnt/test/yp failed 
> ) = 30
> exit_group(0)                           = ?

-Andi

