Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbQLYQf1>; Mon, 25 Dec 2000 11:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbQLYQfS>; Mon, 25 Dec 2000 11:35:18 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:21222 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130194AbQLYQfG>; Mon, 25 Dec 2000 11:35:06 -0500
Message-ID: <3A477014.CE908BFC@haque.net>
Date: Mon, 25 Dec 2000 11:04:36 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: test13-pre4... udf problem with dvd access vs test12
In-Reply-To: <3A47212D.F9F119C3@xmission.com> <3A476C7D.1952EDB4@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, I made sure to reverse the udf patch I mentioned in another thread
(all it really is merging changes from linux-udf cvs into the current
kernel). So this is from a clean test13-pre4 w/ some netfilter fixes.

ksymoops 0.7c on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Oops: 0000
CPU:    0
EIP:    0010:[<c019c017>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000000   ebx: 00000000   ecx: d5efc610   edx: d3efc610 
esi: 00000001   edi: c02fa0a4   ebp: 00000003   esp: c0297e84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0297000)
Stack: c02fa0a4 c019c088 c02fa0a4 00000000 d3efc610 d3efc650 00000001
c02fa0a4 
       00000003 c1578078 c019269e c019d2d5 c02fa0a4 00000012 c019d260
c019d4d8 
       c02fa0a4 00000000 c02fa0a4 d3efc650 c0192a09 c02fa0a4 d3efc650
00000000 
Call Trace: [<0019c08b>] [<c019269e>] [<c019d2d5>] [<c019d260>]
[<c019d4d8>] [<c0192a09>] [<c019c464>] 
       [<c019d173>] [<c011ccd2>] [<c0193127>] [<c019d0ac>] [<c010a04f>]
[<c010a1ac>] [<c01071f0>] [<c01071f0>] 
       [<c0108e94>] [<c01071f0>] [<c01071f0>] [<c0100018>] [<c0107213>]
[<c0107279>] [<c0105000>] [<c0100191>] 
Code: 83 78 0c 00 74 04 31 c0 eb 4a 8a 42 02 24 0f 0f b6 c0 83 f8 

>>EIP; c019c017 <cdrom_log_sense+f/68>   <=====
Trace; 0019c08b Before first symbol
Trace; c019269e <ide_wait_stat+8a/f8>
Trace; c019d2d5 <cdrom_do_packet_command+39/40>
Trace; c019d260 <cdrom_do_pc_continuation+0/3c>
Trace; c019d4d8 <ide_do_rw_cdrom+f0/12c>
Trace; c0192a09 <start_request+18d/204>
Trace; c019c464 <cdrom_end_request+3c/70>
Trace; c019d173 <cdrom_pc_intr+c7/1b4>
Trace; c011ccd2 <timer_bh+222/25c>
Trace; c0193127 <ide_intr+fb/150>
Trace; c019d0ac <cdrom_pc_intr+0/1b4>
Trace; c010a04f <handle_IRQ_event+2f/58>
Trace; c010a1ac <do_IRQ+6c/b0>
Trace; c01071f0 <default_idle+0/28>
Trace; c01071f0 <default_idle+0/28>
Trace; c0108e94 <ret_from_intr+0/20>
Trace; c01071f0 <default_idle+0/28>
Trace; c01071f0 <default_idle+0/28>
Trace; c0100018 <startup_32+18/139>
Trace; c0107213 <default_idle+23/28>
Trace; c0107279 <cpu_idle+41/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c019c017 <cdrom_log_sense+f/68>
00000000 <_EIP>:
Code;  c019c017 <cdrom_log_sense+f/68>   <=====
   0:   83 78 0c 00               cmpl   $0x0,0xc(%eax)   <=====
Code;  c019c01b <cdrom_log_sense+13/68>
   4:   74 04                     je     a <_EIP+0xa> c019c021
<cdrom_log_sense+19/68>
Code;  c019c01d <cdrom_log_sense+15/68>
   6:   31 c0                     xor    %eax,%eax
Code;  c019c01f <cdrom_log_sense+17/68>
   8:   eb 4a                     jmp    54 <_EIP+0x54> c019c06b
<cdrom_log_sense+63/68>
Code;  c019c021 <cdrom_log_sense+19/68>
   a:   8a 42 02                  mov    0x2(%edx),%al
Code;  c019c024 <cdrom_log_sense+1c/68>
   d:   24 0f                     and    $0xf,%al
Code;  c019c026 <cdrom_log_sense+1e/68>
   f:   0f b6 c0                  movzbl %al,%eax
Code;  c019c029 <cdrom_log_sense+21/68>
  12:   83 f8 00                  cmp    $0x0,%eax



"Mohammad A. Haque" wrote:
> 
> I just captured the oops.
> 
> It happens when you try to mount (mount -t udf /dev/foo /mnt/bar) an
> encrypted dvd. At least it does on my end. Unencrypted dvds mount fine.
> 
> ksymoops coming soon.
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
