Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312423AbSCTLfI>; Wed, 20 Mar 2002 06:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312424AbSCTLer>; Wed, 20 Mar 2002 06:34:47 -0500
Received: from [195.157.147.30] ([195.157.147.30]:45061 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S312423AbSCTLeg>; Wed, 20 Mar 2002 06:34:36 -0500
Date: Wed, 20 Mar 2002 11:38:42 +0000
From: Sean Hunter <sean@uncarved.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at audio.c:1474 (2.4.19-pre3-ac3)
Message-ID: <20020320113842.H10376@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

Since upgrading to 2.4.19-pre3-ac3, I get this problem when accessing my
soundcard (an Sb Live).  2.4.19-pre3-ac1 also had this problem, but 2.4.17 (my
previous kernel) didn't.

The snippet of code (I think) that is triggering the bug call is this:

        buffer->numfrags = buffer->size / buffer->fragment_size;
        buffer->pages =  buffer->size / PAGE_SIZE + ((buffer->size % PAGE_SIZE) ? 1 : 0);
        if (buffer->size % buffer->fragment_size)
                BUG();

...from ./drivers/sound/emu10k1/audio.c .  What I'm doing when this occurs is
attempting to set the soundcard input channels up and read from them.


Please let me know if you need more information

Thanks

Sean

kernel BUG at audio.c:1474!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0207295>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001c   ebx: dfe593c8   ecx: c02ed640   edx: 000034a8
esi: 00000002   edi: 00000007   ebp: 0000ffff   esp: dcf09f2c
ds: 0018   es: 0018   ss: 0018
Process aed (pid: 1465, stackpage=dcf09000)
Stack: c02c65c7 000005c2 00018000 0001c000 00010000 00014000 00000246 dfe59380 
       dcf08000 00002000 c0204c70 dfe59380 00000800 00000000 df1056c0 0000ac44 
       00000000 dd26ee60 ffffffea 00002000 c013e756 dd26ee60 bfffd5b0 00002000 
Call Trace: [<c0204c70>] [<c013e756>] [<c014def3>] [<c010708b>] 
Code: 0f 0b 5a 59 83 c4 10 5b 5e 5f 5d c3 eb 0d 90 90 90 90 90 90 


>>EIP; c0207295 <ahc_rem_wscb+135/1c0>   <=====

>>ebx; dfe593c8 <END_OF_CODE+1fa25a2c/????>
>>ecx; c02ed640 <quota_versions+63ec/11dbc>
>>edx; 000034a8 Before first symbol
>>ebp; 0000ffff Before first symbol
>>esp; dcf09f2c <END_OF_CODE+1cad6590/????>

Trace; c0204c70 <ahc_init+f20/10d0>
Trace; c013e756 <do_readv_writev+76/300>
Trace; c014def3 <dcache_readdir+113/150>
Trace; c010708b <system_call+33/38>

Code;  c0207295 <ahc_rem_wscb+135/1c0>
00000000 <_EIP>:
Code;  c0207295 <ahc_rem_wscb+135/1c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0207297 <ahc_rem_wscb+137/1c0>
   2:   5a                        pop    %edx
Code;  c0207298 <ahc_rem_wscb+138/1c0>
   3:   59                        pop    %ecx
Code;  c0207299 <ahc_rem_wscb+139/1c0>
   4:   83 c4 10                  add    $0x10,%esp
Code;  c020729c <ahc_rem_wscb+13c/1c0>
   7:   5b                        pop    %ebx
Code;  c020729d <ahc_rem_wscb+13d/1c0>
   8:   5e                        pop    %esi
Code;  c020729e <ahc_rem_wscb+13e/1c0>
   9:   5f                        pop    %edi
Code;  c020729f <ahc_rem_wscb+13f/1c0>
   a:   5d                        pop    %ebp
Code;  c02072a0 <ahc_rem_wscb+140/1c0>
   b:   c3                        ret    
Code;  c02072a1 <ahc_rem_wscb+141/1c0>
   c:   eb 0d                     jmp    1b <_EIP+0x1b> c02072b0 <ahc_rem_wscb+150/1c0>
Code;  c02072a3 <ahc_rem_wscb+143/1c0>
   e:   90                        nop    
Code;  c02072a4 <ahc_rem_wscb+144/1c0>
   f:   90                        nop    
Code;  c02072a5 <ahc_rem_wscb+145/1c0>
  10:   90                        nop    
Code;  c02072a6 <ahc_rem_wscb+146/1c0>
  11:   90                        nop    
Code;  c02072a7 <ahc_rem_wscb+147/1c0>
  12:   90                        nop    
Code;  c02072a8 <ahc_rem_wscb+148/1c0>
  13:   90                        nop    


