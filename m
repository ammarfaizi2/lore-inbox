Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUIMQUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUIMQUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268304AbUIMQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:20:06 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:22699 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268655AbUIMQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:17:49 -0400
Date: Mon, 13 Sep 2004 18:17:36 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: Christoph Hellwig <hch@infradead.org>, bugs@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
Message-ID: <20040913161735.GC4180@dualathlon.random>
References: <4145A8E1.8010409@qlusters.com> <20040913153803.A27282@infradead.org> <4145B750.6060900@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145B750.6060900@qlusters.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Constantine,

On Mon, Sep 13, 2004 at 06:05:52PM +0300, Constantine Gavrilov wrote:
> And BTW, kernel-space applications have their own place even if the 
> concept seems foreign to you.

I avoided to do like i386 that inefficiently calls int 0x80 when you can
call sys_read/sys_write etc.. by hand.

the syscall is only meaningful if you're not in kernel space. Once
you're in kernel space if you ever try to invoke a syscall again (either
via int 0x80, syscall, sysenter, call gate, whatever) then you're just
going slower than you should for no good reason. 

The only point of calling int 0x80 and friends is to change mode from
user space to kernel space, and you're in kernel space already so you
should just call sys_read/sys_write etc.. by hand which will not waste
precious cycles and it'll be a lot simpler too.

Note also that int 0x80 will bring you into the 32bit emulation layer,
the only 64bit entry point is reacheable only via syscall.

Hope this helps.
