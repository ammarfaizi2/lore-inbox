Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUIMQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUIMQsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUIMQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:46:57 -0400
Received: from hera.kernel.org ([63.209.29.2]:34210 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268404AbUIMQl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:41:57 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on
 Opteron machines
Date: Mon, 13 Sep 2004 09:41:48 -0700
Organization: Open Source Development Lab
Message-ID: <20040913094148.45509d9c@dell_ss3.pdx.osdl.net>
References: <4145A8E1.8010409@qlusters.com>
	<20040913153803.A27282@infradead.org>
	<4145B750.6060900@qlusters.com>
	<20040913161735.GC4180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1095093709 2085 172.20.1.60 (13 Sep 2004 16:41:49 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 13 Sep 2004 16:41:49 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 18:17:36 +0200
Andrea Arcangeli <andrea@novell.com> wrote:

> Hi Constantine,
> 
> On Mon, Sep 13, 2004 at 06:05:52PM +0300, Constantine Gavrilov wrote:
> > And BTW, kernel-space applications have their own place even if the 
> > concept seems foreign to you.
> 
> I avoided to do like i386 that inefficiently calls int 0x80 when you can
> call sys_read/sys_write etc.. by hand.
> 
> the syscall is only meaningful if you're not in kernel space. Once
> you're in kernel space if you ever try to invoke a syscall again (either
> via int 0x80, syscall, sysenter, call gate, whatever) then you're just
> going slower than you should for no good reason. 
> 
> The only point of calling int 0x80 and friends is to change mode from
> user space to kernel space, and you're in kernel space already so you
> should just call sys_read/sys_write etc.. by hand which will not waste
> precious cycles and it'll be a lot simpler too.
> 
> Note also that int 0x80 will bring you into the 32bit emulation layer,
> the only 64bit entry point is reacheable only via syscall.
> 
> Hope this helps.


Actually, the fact that system calls work in kernel space I would consider
a BUG.  The int 0x80 handler should oops or at least kill the offending
thread for security and robustness reasons.

-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
