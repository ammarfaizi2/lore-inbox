Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278491AbRJZOgd>; Fri, 26 Oct 2001 10:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278490AbRJZOgO>; Fri, 26 Oct 2001 10:36:14 -0400
Received: from pluto.ricis.com ([64.244.234.16]:261 "EHLO pluto.ricis.com")
	by vger.kernel.org with ESMTP id <S278483AbRJZOgK>;
	Fri, 26 Oct 2001 10:36:10 -0400
Message-Id: <5.0.0.25.2.20011026092202.00a6ceb0@pluto>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Fri, 26 Oct 2001 09:36:37 -0500
To: linux-kernel@vger.kernel.org
From: Lee Leahu <lee@ricis.com>
Subject: Oops in 2.2.19 swap_count error
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting to all kernel coders!

I'm sure you're all busy working on the latest kernel, but I was wondering 
if you would spare a few minutes to look at my problem.  I came to work 
this morning and my server had crashed.  I was still able to ping it and 
type in a username at the text console, but no proccess seemed to be 
running or want to start.  I was forced to power-cycle the server.  When it 
came back up, I looked in the syslog file and noticed the following errors, 
which were repeated maybe ten times before I power-cycled the server.


<< snip >>
Unable to handle kernel paging request at virtual address 0a707565
current->tss.cr3 = 0d8e5000, %%cr3 = 0d8e5000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0123557>]
EFLAGS: 00010002
eax: cffaf620   ebx: cf113f80   ecx: 0a707565   edx: 746a88b8
esi: cffaf620   edi: c4ebe4a4   ebp: 00000282   esp: ccaabe9c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 527, process nr: 48, stackpage=ccaab000)
Stack: c4ebe4a4 c182d2c0 c981c740 cf3312a0 00000000 c0136237 cffaf620 00000015
        00000009 00000009 00000000 c4ebe4f4 c4ebe4a4 c182d2c0 cff75d18 cf53c000
        746a88b8 0000000b cf53c000 cf53c000 cf53c000 c0130510 c182d2c0 ccaabf48
Call Trace: [<c0136237>] [<c0130510>] [<c01303ee>] [<c013076c>] 
[<c013029b>] [<c0130865>] [<c0132c0c>]
        [<c012e378>] [<c0109184>]
Code: 8b 01 89 03 85 c0 74 29 8b 53 04 85 d2 75 0e 89 19 89 c8 2b
<< snip >>

So from what I learned from more knowledgable people, I ran ksymoops and 
pasted the above error into it.  I listed the output below.

<< snip >>
 >>EIP; c0123557 <swap_count+83/94>   <=====
Trace; c0136237 <load_elf_binary+3b7/af4>
Trace; c0130510 <sys_getdents+34/ec>
Trace; c01303ee <old_readdir+52/b8>
Trace; c013076c <max_select_fd+38/a0>
Trace; c013029b <sys_ioctl+f7/188>
Trace; c0130865 <do_select+91/200>
Trace; c0132c0c <lock_get_status+8c/118>
Trace; c012e378 <open_namei+1a4/378>
Trace; c0109184 <system_call+34/40>
Code;  c0123557 <swap_count+83/94>
00000000 <_EIP>:
Code;  c0123557 <swap_count+83/94>   <=====
    0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0123559 <swap_count+85/94>
    2:   89 03                     mov    %eax,(%ebx)
Code;  c012355b <swap_count+87/94>
    4:   85 c0                     test   %eax,%eax
Code;  c012355d <swap_count+89/94>
    6:   74 29                     je     31 <_EIP+0x31> c0123588 
<delete_from_swap_cache+20/bc>
Code;  c012355f <swap_count+8b/94>
    8:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c0123562 <swap_count+8e/94>
    b:   85 d2                     test   %edx,%edx
Code;  c0123564 <swap_count+90/94>
    d:   75 0e                     jne    1d <_EIP+0x1d> c0123574 
<delete_from_swap_cache+c/bc>
Code;  c0123566 <swap_count+92/94>
    f:   89 19                     mov    %ebx,(%ecx)
Code;  c0123568 <delete_from_swap_cache+0/bc>
   11:   89 c8                     mov    %ecx,%eax
Code;  c012356a <delete_from_swap_cache+2/bc>
   13:   2b 00                     sub    (%eax),%eax
<< snip >>

 From what I can determine, it appears that is a bug is my kernel, the swap 
partition got corrupted, or the data in the swap partition was corrupt.  My 
server is back up now, but I still would like to determine the underlying 
cause of this. Unfortuanatly, I am not very knowledgable is kernel / crash 
debugging and I would like to learn more.

Do you think my server may have been comprimised?  I have just upgraded to 
2.2.19 from 2.2.16 with SuSEs kernel rpm upgrade. AFAIK, I am currently 
up-to-date on my SuSE Linux patches for this box.

Thankyou,
Lee Leahu
RICIS, Inc.
Phone: (708) 444-2690
Fax: (708) 444-2697
Cell: (708) 363-6860
Pager: (708) 467-2044
lee@ricis.com
http://www.ricis.com/

