Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270495AbRHUBOz>; Mon, 20 Aug 2001 21:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270460AbRHUBOq>; Mon, 20 Aug 2001 21:14:46 -0400
Received: from member.michigannet.com ([207.158.188.18]:4112 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S270451AbRHUBO3>; Mon, 20 Aug 2001 21:14:29 -0400
Date: Mon, 20 Aug 2001 21:14:10 -0400
From: Paul <set@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
Message-ID: <20010820211410.B218@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com> <m166bjokre.fsf@frodo.biederman.org> <20010819214322.D1315@squish.home.loc> <m1snenmfe0.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1snenmfe0.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Aug 20, 2001 at 12:09:27AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com>, on Mon Aug 20, 2001 [12:09:27 AM] said:

> If you can rule out X stracing dosemu might be of some help.   The
> challenge now is to track down what dosemu is doing that is triggering
> the problem. 
> 
> As an interrupt handler is where the oops is occuring.  Finding an
> immediate cause and effect could be tricky.
> 
> Eric

	Dear Eric;

	Ok. I oopsed/locked the machine running 'dos' in a vt,
without X in single user mode. Then I did it again, stracing the
session.  Unfortunately, the fs was left in such a state, that
fsck completely chucked the logfile out. Then I booted 2.2.18, and
tried.  I could not make it oops.
	I need to setup a test machine to persue this farther, as
locking and fscking my main box is no fun:) Ill try to get that
strace...

Paul
set@pobox.com

Here are the oopsen, even though I suspect they dont shed any
light:

ksymoops 2.4.1 on i586 2.4.8-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac7/ (default)
     -m /boot/System.map-2.4.8-ac7 (specified)

CPU:    0
EIP:    0010:[<c89a0417>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: 00000010
esi: c269f800   edi: c1e910e6   ebp: c1e910c0   esp: c7a93c74
ds: 0018   es: 0000   ss: 0018
Process dos (pid: 11215, stackpage=c7a93000)
Stack: 00000000 c1e910c0 00000e29 0000006e c1e910e6 006e0028 00690e29 c89a0b2e 
       c1e910c0 c269f800 c269fa9c 00000000 00000e29 0000006e 00000000 c7a93d98 
       00000001 c7a93d2a 00000004 00000000 00000000 00000003 00000007 000bdd7c 
Call Trace: [<c89a0b2e>] [<c89a1b92>] [<c899c1d4>] [<c89a2e28>] [<c01d8d5c>] 
   [<c01d0f48>] [<c01d8d5c>] [<c01d8d5c>] [<c01d11fd>] [<c01d8d5c>] [<c89a2778>] 
   [<c01d7a32>] [<c01d8d5c>] [<c01d7dd8>] [<c01e9bc6>] [<c01e52b9>] [<c01e5362>] 
   [<c01e7712>] [<c01e7fc5>] [<c01e7e88>] [<c0116a42>] [<c0116abb>] [<c010aa4a>] 
   [<c010762c>] [<c0106c0d>] [<c0106af3>] 
Code: f2 ae f7 d1 49 8b 7c 24 10 49 78 08 ac ae 75 08 84 c0 75 f5 

>>EIP; c89a0417 <[ipchains]ip_rule_match+a7/244>   <=====
Trace; c89a0b2e <[ipchains]ip_fw_check+21e/488>
Trace; c89a1b92 <[ipchains]ipfw_output_check+5a/60>
Trace; c899c1d4 <[ipchains]fw_in+118/254>
Trace; c89a2e28 <[ipchains]ipfw_ops+0/17>
Trace; c01d8d5c <ip_finish_output2+0/c8>
Trace; c01d0f48 <nf_iterate+30/84>
Trace; c01d8d5c <ip_finish_output2+0/c8>
Trace; c01d8d5c <ip_finish_output2+0/c8>
Trace; c01d11fd <nf_hook_slow+b1/140>
Trace; c01d8d5c <ip_finish_output2+0/c8>
Trace; c89a2778 <[ipchains]postroute_ops+0/18>
Trace; c01d7a32 <ip_output+10a/110>
Trace; c01d8d5c <ip_finish_output2+0/c8>
Trace; c01d7dd8 <ip_queue_xmit+3a0/4f0>
Trace; c01e9bc6 <tcp_v4_send_check+6a/a8>
Trace; c01e52b9 <tcp_transmit_skb+3a9/4f0>
Trace; c01e5362 <tcp_transmit_skb+452/4f0>
Trace; c01e7712 <tcp_send_ack+c2/c8>
Trace; c01e7fc5 <tcp_delack_timer+13d/180>
Trace; c01e7e88 <tcp_delack_timer+0/180>
Trace; c0116a42 <timer_bh+212/24c>
Trace; c0116abb <do_timer+3f/70>
Trace; c010aa4a <timer_interrupt+ba/174>
Trace; c010762c <do_general_protection+0/6c>
Trace; c0106c0d <error_code+2d/40>
Trace; c0106af3 <system_call+33/40>
Code;  c89a0417 <[ipchains]ip_rule_match+a7/244>
00000000 <_EIP>:
Code;  c89a0417 <[ipchains]ip_rule_match+a7/244>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c89a0419 <[ipchains]ip_rule_match+a9/244>
   2:   f7 d1                     not    %ecx
Code;  c89a041b <[ipchains]ip_rule_match+ab/244>
   4:   49                        dec    %ecx
Code;  c89a041c <[ipchains]ip_rule_match+ac/244>
   5:   8b 7c 24 10               mov    0x10(%esp,1),%edi
Code;  c89a0420 <[ipchains]ip_rule_match+b0/244>
   9:   49                        dec    %ecx
Code;  c89a0421 <[ipchains]ip_rule_match+b1/244>
   a:   78 08                     js     14 <_EIP+0x14> c89a042b <[ipchains]ip_rule_match+bb/244>
Code;  c89a0423 <[ipchains]ip_rule_match+b3/244>
   c:   ac                        lods   %ds:(%esi),%al
Code;  c89a0424 <[ipchains]ip_rule_match+b4/244>
   d:   ae                        scas   %es:(%edi),%al
Code;  c89a0425 <[ipchains]ip_rule_match+b5/244>
   e:   75 08                     jne    18 <_EIP+0x18> c89a042f <[ipchains]ip_rule_match+bf/244>
Code;  c89a0427 <[ipchains]ip_rule_match+b7/244>
  10:   84 c0                     test   %al,%al
Code;  c89a0429 <[ipchains]ip_rule_match+b9/244>
  12:   75 f5                     jne    9 <_EIP+0x9> c89a0420 <[ipchains]ip_rule_match+b0/244>

 >Kernel panic: Aiee, killing interrupt handler!


ksymoops 2.4.1 on i586 2.4.8-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac7/ (default)
     -m /boot/System.map-2.4.8-ac7 (specified)

CPU:    0
EIP:    0010:[<c01a4bf0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000003   edx: c251cbc0
esi: 00001000   edi: c7f9b000   ebp: c1df8000   esp: c19cfd7c
ds: 0018   es: 0000   ss: 0018
Process dos (pid: 271, stackpage=c19cf000)
Stack: c7f9c000 00000001 c02a5e80 00000000 00000000 c7f9b000 00000001 c7f9b000 
       c01a4c4d c02a5e40 c7f92140 0000d000 00000001 c02a5e80 c02a5e40 c01a4a8f 
       c01a5140 c02a5e80 00000001 000001f6 c02a5e40 c7f92140 c02a5e80 0032a000 
Call Trace: [<c01a4c4d>] [<c01a4a8f>] [<c01a5140>] [<c01a4a8f>] [<c01a85e0>] 
   [<c01a07ca>] [<c01a0825>] [<c01a0b76>] [<c01a100b>] [<c01a4aa0>] [<c0107d5c>] 
   [<c0107ebe>] [<c010762c>] [<c0109d1e>] [<c010762c>] [<c0106c0d>] [<c0106b7f>] 
Code: f3 ab 8b 44 24 14 89 28 8b 4c 24 10 8b 7c 24 1c 89 74 0f 08 

>>EIP; c01a4bf0 <ide_build_sglist+a8/e0>   <=====
Trace; c01a4c4d <ide_build_dmatable+25/148>
Trace; c01a4a8f <ali15x3_dmaproc+3f/50>
Trace; c01a5140 <ide_dmaproc+e8/210>
Trace; c01a4a8f <ali15x3_dmaproc+3f/50>
Trace; c01a85e0 <do_rw_disk+184/308>
Trace; c01a07ca <start_request+12e/204>
Trace; c01a0825 <start_request+189/204>
Trace; c01a0b76 <ide_do_request+27e/2c4>
Trace; c01a100b <ide_intr+12b/14c>
Trace; c01a4aa0 <ide_dma_intr+0/a8>
Trace; c0107d5c <handle_IRQ_event+30/5c>
Trace; c0107ebe <do_IRQ+6e/b0>
Trace; c010762c <do_general_protection+0/6c>
Trace; c0109d1e <call_do_IRQ+5/17>
Trace; c010762c <do_general_protection+0/6c>
Trace; c0106c0d <error_code+2d/40>
Trace; c0106b7f <tracesys+1f/23>
Code;  c01a4bf0 <ide_build_sglist+a8/e0>
00000000 <_EIP>:
Code;  c01a4bf0 <ide_build_sglist+a8/e0>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c01a4bf2 <ide_build_sglist+aa/e0>
   2:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01a4bf6 <ide_build_sglist+ae/e0>
   6:   89 28                     mov    %ebp,(%eax)
Code;  c01a4bf8 <ide_build_sglist+b0/e0>
   8:   8b 4c 24 10               mov    0x10(%esp,1),%ecx
Code;  c01a4bfc <ide_build_sglist+b4/e0>
   c:   8b 7c 24 1c               mov    0x1c(%esp,1),%edi
Code;  c01a4c00 <ide_build_sglist+b8/e0>
  10:   89 74 0f 08               mov    %esi,0x8(%edi,%ecx,1)

 <0>Kernel panic: Aiee, killing interrupt handler!

13 warnings issued.  Results may not be reliable.
