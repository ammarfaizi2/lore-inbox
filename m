Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266398AbRGBHcv>; Mon, 2 Jul 2001 03:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266400AbRGBHcl>; Mon, 2 Jul 2001 03:32:41 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:48240 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S266399AbRGBHcc>; Mon, 2 Jul 2001 03:32:32 -0400
Date: Mon, 2 Jul 2001 09:32:02 +0200
From: Cliff Albert <cliff@oisec.net>
To: linux-kernel@vger.kernel.org, meskes@debian.org, mvw@planets.elm.net,
        jack@atrey.karlin.mff.cuni.cz, Alan.Cox@linux.org
Subject: quotaoff OOPS (2.4.5-ac22)
Message-ID: <20010702093202.A26673@oisec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After issuing quotaoff -a the kernel oopses. All filesystems which have quotas are ext2 and are using the new quota system.

Oops:

Jul  2 09:08:49 girly kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000032a            
Jul  2 09:08:49 girly kernel:  printing eip:                                                                          
Jul  2 09:08:49 girly kernel: c0146886                                                                                
Jul  2 09:08:49 girly kernel: *pde = 00000000                                                                         
Jul  2 09:08:49 girly kernel: Oops: 0000                                                                              
Jul  2 09:08:49 girly kernel: CPU:    1                                                                               
Jul  2 09:08:49 girly kernel: EIP:    0010:[<c0146886>]                                                               
Jul  2 09:08:49 girly kernel: EFLAGS: 00010282                                                                        
Jul  2 09:08:49 girly kernel: eax: d0735f4c   ebx: ccdda800   ecx: 00000000   edx: d0735f4c                           
Jul  2 09:08:49 girly kernel: esi: ccdda87c   edi: 00000306   ebp: d0735fa4   esp: d0735f30                           
Jul  2 09:08:49 girly kernel: ds: 0018   es: 0018   ss: 0018                                                          
Jul  2 09:08:49 girly kernel: Process quotaoff (pid: 1892, stackpage=d0735000)                                        
Jul  2 09:08:49 girly kernel: Stack: ccdda800 ccdda87c 00000000 d0735fa4 00000000 d0735fa4 00005fa4 d0735f4c          
Jul  2 09:08:49 girly kernel:        d0735f4c c014a62c 00000306 00000000 ccdda800 00000200 00000000 d0735fa4          
Jul  2 09:08:49 girly kernel:        ccdda894 ccdda87c 00000000 c014ab8c ccdda800 00000000 d0734000 00000000          
Jul  2 09:08:49 girly kernel: Call Trace: [<c014a62c>] [<c014ab8c>] [<c0131953>] [<c0106cbb>]                         
Jul  2 09:08:49 girly kernel:                                                                                         
Jul  2 09:08:49 girly kernel: Code: 83 7f 24 00 0f 84 0f 01 00 00 f0 fe 0d d4 01 25 c0 0f 88 09                       

KSymoops:

>>EIP; c0146886 <remove_dquot_ref+22/14c>   <=====
Trace; c014a62c <quota_off+cc/154>
Trace; c014ab8c <sys_quotactl+268/3bc>
Trace; c0131953 <sys_read+bf/c8>
Trace; c0106cbb <system_call+33/38>
Code;  c0146886 <remove_dquot_ref+22/14c>
00000000 <_EIP>:
Code;  c0146886 <remove_dquot_ref+22/14c>   <=====
   0:   83 7f 24 00               cmpl   $0x0,0x24(%edi)   <=====
Code;  c014688a <remove_dquot_ref+26/14c>
   4:   0f 84 0f 01 00 00         je     119 <_EIP+0x119> c014699f <remove_dquot_ref+13b/14c>
Code;  c0146890 <remove_dquot_ref+2c/14c>
   a:   f0 fe 0d d4 01 25 c0      lock decb 0xc02501d4
Code;  c0146897 <remove_dquot_ref+33/14c>
  11:   0f 88 09 00 00 00         js     20 <_EIP+0x20> c01468a6 <remove_dquot_ref+42/14c>



Linux Version: 

Linux girly 2.4.5-ac22 #2 SMP Sun Jul 1 12:54:40 CEST 2001 i686 unknown

Distribution:

Debian SID

Quota Version:

ii  quota                   3.00pre01-8             An implementation of the diskquota system.
Jul  2 09:18:40 girly kernel: VFS: Diskquotas version dquot_6.5.0 initialized      

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
