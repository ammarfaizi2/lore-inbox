Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVBJJty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVBJJty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVBJJtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:49:47 -0500
Received: from village.ehouse.ru ([193.111.92.18]:33296 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262084AbVBJJth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:49:37 -0500
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10 devfs oops without devfs mounted at all
Date: Thu, 10 Feb 2005 12:49:29 +0300
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
References: <200502082013.50959.rathamahata@ehouse.ru> <20050209163624.44557750.akpm@osdl.org>
In-Reply-To: <20050209163624.44557750.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101249.30878.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 February 2005 03:36, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@ehouse.ru> wrote:
> >
> > Here is an oops I've just get on my smp system:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> >  printing eip:
> > c01afe5b
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT SMP
> > Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter
> > CPU:    2
> > EIP:    0060:[<c01afe5b>]    Not tainted VLI
> > EFLAGS: 00010286   (2.6.10)
> > EIP is at devfsd_close+0x1b/0xc8
> > eax: f7440a00   ebx: 00000000   ecx: c01afe40   edx: ed395280
> > esi: 00000000   edi: f7f17800   ebp: f74f96c8   esp: cdc70f84
> > ds: 007b   es: 007b   ss: 0068
> > Process megamgr.bin (pid: 12844, threadinfo=cdc70000 task=dd81e520)
> > Stack: ed395280 ed395280 00000000 f7f17800 c0150c76 ee9e87f8 ed395280 00000000
> >        f1985c80 cdc70000 c014f50f 00000003 00000003 080caa60 00000000 c01024df
> >        00000003 080cc700 bfffe4f8 080caa60 00000000 bfffe4fc 00000006 0000007b
> > Call Trace:
> >  [<c0150c76>] __fput+0x106/0x120
> >  [<c014f50f>] filp_close+0x4f/0x80
> >  [<c01024df>] syscall_call+0x7/0xb
> 
> Can you work out what file is being closed?  One way of doing that would be
> to work out how megamgr.bin is being invoked and to then run it by hand:
> 
>  strace -f -o log megamgr.bin <args>
> 
> and we can then use the strace output to work out the pathname of the
> offending file.

rathamahata@terror rathamahata $ grep 'open(' mg.log
5255  open("/usr/share/terminfo/l/linux", O_RDONLY) = 3
5255  open("/dev/megadev0", O_RDONLY)   = 3
rathamahata@terror rathamahata $ 

I guess it's /dev/megadev0 (manually created character device)

rathamahata@terror rathamahata $ ls -la /dev/megadev0
crw-r--r--  1 root root 253, 0 Feb  8 16:26 /dev/megadev0
rathamahata@terror rathamahata 

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
