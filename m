Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRCLFIo>; Mon, 12 Mar 2001 00:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbRCLFIf>; Mon, 12 Mar 2001 00:08:35 -0500
Received: from turing.une.edu.au ([129.180.11.17]:56334 "EHLO
	turing.une.edu.au") by vger.kernel.org with ESMTP
	id <S129498AbRCLFIX>; Mon, 12 Mar 2001 00:08:23 -0500
Date: Mon, 12 Mar 2001 16:07:36 +1100
From: Norman Gaywood <norm@turing.une.edu.au>
To: linux-kernel@vger.kernel.org
Subject: How many dquots is enough?
Message-ID: <20010312160736.A11879@turing.une.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not been able to run quotas for several versions of 2.2.x now. I
always get stuff like:

Mar 11 18:56:17 turing kernel: Unable to handle kernel paging request at virtual address 6c206f8f 
Mar 11 18:56:17 turing kernel: current->tss.cr3 = 2b4e1000, %%cr3 = 2b4e1000 
Mar 11 18:56:17 turing kernel: *pde = 00000000 
Mar 11 18:56:17 turing kernel: Oops: 0002 
Mar 11 18:56:17 turing kernel: CPU:    0 
Mar 11 18:56:17 turing kernel: EIP:    0010:[kmem_cache_alloc+19/348] 
Mar 11 18:56:17 turing kernel: EFLAGS: 00010006 
Mar 11 18:56:17 turing kernel: eax: 6c206f6f   ebx: 00000000   ecx: 00000000   edx: f66cf208 
Mar 11 18:56:17 turing kernel: esi: 6c206f6f   edi: 00000080   ebp: 00000206   esp: b3381f08 
Mar 11 18:56:17 turing kernel: ds: 0018   es: 0018   ss: 0018 
Mar 11 18:56:17 turing kernel: Process in.ftpd (pid: 9193, process nr: 305, stackpage=b3381000) 
Mar 11 18:56:17 turing kernel: Stack: 00000080 f778ade0 8013b275 6c206f6f 00000015 00000000 00000000 00000080  
Mar 11 18:56:17 turing kernel:        00000000 8013b3fa 00000000 8013b571 00000000 00000001 08084580 fffffffd  
Mar 11 18:56:17 turing kernel:        0000027a 00000002 00000000 00000000 00000811 00000020 08110000 8013c086  
Mar 11 18:56:17 turing kernel: Call Trace: [grow_dquots+21/132] [get_empty_dquot+194/284] [dqget+285/660] [get_quota+130/272] [sys_quotactl+526/784] [system_call+52/56]  
Mar 11 18:56:17 turing kernel: Code: f0 0f ba 6e 20 00 0f 82 56 e5 0d 00 90 8b 06 89 c3 81 78 08  

The process in question will then hang in the D state. More and processes
get like this until the system becomes unusable. The Oops is always in
kmem_cache_alloc called from grow_dquots.

I solve it by turning off quotas with "quotaoff -a" after a reboot.

I thought that I probably didn't have enough dquots so I increased
dquot-max to 16384. But I still get these Oops-es.

In Documentation/proc.txt it tells me:

  dquot-nr and dquot-max
     ...
     If the number of free cached disk quotas is very low and you have
     a large number of simultaneous system users, you might want
     to raise the limit.

Problem is I have no handle on what "very low", "large number", and
whether I "might want to" mean. I'm not even sure how you define what a
"simultaneous system user" is.

Our system typically would have 20-100 ssh/rlogin/telnet sessions which
overlaps with 20-60 "Xterminal" sessions. Also < 10 ftp sessions,
< 20 samba connections and 10-50 WWW hits a minute.

The current kernel is a RedHat 6.2 rpm based install of 2.2.16, rebuilt
for PPro/6x86MX, with Bigmem set for 2Gig, CONFIG_UNIX98_PTY_COUNT=2048,
and SCSI_AIC7XXX built into the kernel (not a module).

I'm happy to supply more details if anyone is interested.

Cheers.
-- 
Norman Gaywood -- School of Mathematical and Computer Sciences
University of New England, Armidale, NSW 2351, Australia
norm@turing.une.edu.au     http://turing.une.edu.au/~norm
Phone: +61 2 6773 2412     Fax: +61 2 6773 3312

