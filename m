Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJaWFq>; Wed, 31 Oct 2001 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJaWFh>; Wed, 31 Oct 2001 17:05:37 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:33497 "EHLO gin")
	by vger.kernel.org with ESMTP id <S273854AbRJaWFc>;
	Wed, 31 Oct 2001 17:05:32 -0500
Date: Wed, 31 Oct 2001 23:06:08 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-smp oops.
Message-ID: <20011031230608.C6285@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I got lots of oopses yesterday on my dual-pII-server running 2.4.13-lvm101rc4.
The problem are that the oopses from the different proccesors are
interleaved and cant easily be decoded. should i try to decode them?
intresting things are that "VFS: Close: file count is 0" messages and a
"eth0: card reports no resources." apprears between the oopses too.

the oopsen are available at http://0x63.nu/oops20011030.txt

the first calltrace decodes to:

>>EIP; c0124c70 <lock_vma_mappings+10/28>   <=====
Trace; c0125ec0 <exit_mmap+80/118>
Trace; c0115dd6 <mmput+4a/64>
Trace; c011a18a <do_exit+ba/250>
Trace; c011a346 <sys_exit+e/10>
Trace; c0106d7a <system_call+32/38>
Code;  c0124c70 <lock_vma_mappings+10/28>
00000000 <_EIP>:
Code;  c0124c70 <lock_vma_mappings+10/28>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  c0124c72 <lock_vma_mappings+12/28>
   3:   8b 90 ac 00 00 00         mov    0xac(%eax),%edx
Code;  c0124c78 <lock_vma_mappings+18/28>
   9:   85 d2                     test   %edx,%edx
Code;  c0124c7a <lock_vma_mappings+1a/28>
   b:   74 0a                     je     17 <_EIP+0x17> c0124c86 <lock_vma_mappings+26/28>
Code;  c0124c7c <lock_vma_mappings+1c/28>
   d:   f0 fe 4a 2c               lock decb 0x2c(%edx)
Code;  c0124c80 <lock_vma_mappings+20/28>
  11:   0f 88 b7 00 00 00         js     ce <_EIP+0xce> c0124d3e <sys_brk+92/e8>

And the first on the other cpu to:

>>EIP; c01338b0 <sys_read+28/c4>   <=====
Trace; c0106d7a <system_call+32/38>
Code;  c01338b0 <sys_read+28/c4>
00000000 <_EIP>:
Code;  c01338b0 <sys_read+28/c4>   <=====
   0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
Code;  c01338b2 <sys_read+2a/c4>
   3:   8b 73 20                  mov    0x20(%ebx),%esi
Code;  c01338b6 <sys_read+2e/c4>
   6:   8b 7b 24                  mov    0x24(%ebx),%edi
Code;  c01338b8 <sys_read+30/c4>
   9:   83 ba a8 00 00 00 00      cmpl   $0x0,0xa8(%edx)
Code;  c01338c0 <sys_read+38/c4>
  10:   74 2e                     je     40 <_EIP+0x40> c01338f0 <sys_read+68/c4>
Code;  c01338c2 <sys_read+3a/c4>
  12:   8b 82 00 00 00 00         mov    0x0(%edx),%eax
  
  

-- 

//anders/g

