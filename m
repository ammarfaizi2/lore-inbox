Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSDIW7B>; Tue, 9 Apr 2002 18:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSDIW7A>; Tue, 9 Apr 2002 18:59:00 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:14992 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S312119AbSDIW7A>; Tue, 9 Apr 2002 18:59:00 -0400
Message-ID: <3CB37230.66DEEA4A@delusion.de>
Date: Wed, 10 Apr 2002 00:58:56 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: perex@suse.cz
Subject: OOPS: Alsa with FM801
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following oops repeatedly crashes a Linux-2.5.7 box here.

Let me know if you need further info.

-Udo.


ksymoops 2.4.5 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000050
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c023d246>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 0000a85a
esi: 07e10000   edi: c7e5d640   ebp: 00002100   esp: c37f5f5c
ds: 0018   es: 0018   ss: 0018
Stack: 0000a800 07e10000 c0256d03 00000000 c7e26a40 24000001 0000000a c37f5fc4 
       c010863a 0000000a c7e5d640 c37f5fc4 c37f4000 0000000a c7e26a40 c037da40 
       c010882c 0000000a c37f5fc4 c7e26a40 c7e26a40 c37f4000 08079fcc 08079fd4 
Call Trace: [<c0256d03>] [<c010863a>] [<c010882c>] [<c010acd2>] 
Code: 8b 73 50 8b 86 a8 01 00 00 85 c0 74 04 53 ff d0 5a b8 00 e0 


>>EIP; c023d246 <snd_pcm_period_elapsed+6/c0>   <=====

>>edx; 0000a85a Before first symbol
>>esi; 07e10000 Before first symbol
>>edi; c7e5d640 <END_OF_CODE+7aa9e84/????>
>>ebp; 00002100 Before first symbol
>>esp; c37f5f5c <END_OF_CODE+34427a0/????>

Trace; c0256d03 <snd_fm801_interrupt+b3/1d0>
Trace; c010863a <handle_IRQ_event+3a/80>
Trace; c010882c <do_IRQ+8c/110>
Trace; c010acd2 <call_do_IRQ+5/b>

Code;  c023d246 <snd_pcm_period_elapsed+6/c0>
00000000 <_EIP>:
Code;  c023d246 <snd_pcm_period_elapsed+6/c0>   <=====
   0:   8b 73 50                  mov    0x50(%ebx),%esi   <=====
Code;  c023d249 <snd_pcm_period_elapsed+9/c0>
   3:   8b 86 a8 01 00 00         mov    0x1a8(%esi),%eax
Code;  c023d24f <snd_pcm_period_elapsed+f/c0>
   9:   85 c0                     test   %eax,%eax
Code;  c023d251 <snd_pcm_period_elapsed+11/c0>
   b:   74 04                     je     11 <_EIP+0x11> c023d257 <snd_pcm_period_elapsed+17/c0>
Code;  c023d253 <snd_pcm_period_elapsed+13/c0>
   d:   53                        push   %ebx
Code;  c023d254 <snd_pcm_period_elapsed+14/c0>
   e:   ff d0                     call   *%eax
Code;  c023d256 <snd_pcm_period_elapsed+16/c0>
  10:   5a                        pop    %edx
Code;  c023d257 <snd_pcm_period_elapsed+17/c0>
  11:   b8 00 e0 00 00            mov    $0xe000,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning and 1 error issued.  Results may not be reliable.
