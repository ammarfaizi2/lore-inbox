Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTHaVfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTHaVfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:35:12 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:5050 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262681AbTHaVfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:35:01 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sun, 31 Aug 2003 23:34:59 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux@3ware.com
Subject: Bug Report: 2.4.22 3ware hang on dying drive
Message-Id: <20030831233459.42779a9a.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just experienced this freeze during a verify cycle of a 3ware raid 5 config with 3 drives.
Entries in logfiles:

3w-xxxx: scsi2: AEN: INFO: Verify started: Unit #0.
3w-xxxx: scsi2: Unit #0: Command (f72d7400) timed out, resetting card.

And then:

ksymoops 2.4.8 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

NMI Watchdog detected LOCKUP on CPU1, eip c02b3cd6, registers:
CPU:    1
EIP:    0010:[<c02b3cd6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000002
eax: 00466307   ebx: 006ab97c   ecx: 1152d298   edx: 00029ab9
esi: 00009004   edi: 00042000   ebp: f735ded4   esp: f735dec0
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_2 (pid: 69, stackpage=f735d000)
Stack: 00000000 f88dd2db 006ab97c 130055b2 00000000 3f522cb5 00064f95 3f522cb3 
       0008c524 f735407c 00000000 00009008 00000000 f88da29b f735407c 00042000
       0000001e 00155810 00155810 00000000 00000000 0000900c 00000000 f735407c
Call Trace:    [<f88dd2db>] [<f88da29b>] [<f88dd673>] [<f88dd543>] [<f88dd8e5>]
  [<c0213cef>] [<c021438e>] [<f88e3220>] [<c0214b66>] [<f88e3220>] [<c010592e>]
  [<c0214a50>]
Code: 39 d8 72 f6 5b c3 8d 74 26 00 8b 44 24 04 eb 0a 8d 76 00 8d


>>EIP; c02b3cd6 <__rdtsc_delay+16/20>   <=====

>>ebp; f735ded4 <_end+36f96874/38512a00>
>>esp; f735dec0 <_end+36f96860/38512a00>

Trace; f88dd2db <[3w-xxxx]tw_poll_status+6b/d0>
Trace; f88da29b <[3w-xxxx]tw_aen_drain_queue+4b/370>
Trace; f88dd673 <[3w-xxxx]tw_reset_sequence+23/e0>
Trace; f88dd543 <[3w-xxxx]tw_reset_device_extension+13/120>
Trace; f88dd8e5 <[3w-xxxx]tw_scsi_eh_abort+f5/1e0>
Trace; c0213cef <scsi_try_to_abort_command+4f/60>
Trace; c021438e <scsi_unjam_host+18e/850>
Trace; f88e3220 <[3w-xxxx]driver_template+0/6b>
Trace; c0214b66 <scsi_error_handler+116/180>
Trace; f88e3220 <[3w-xxxx]driver_template+0/6b>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; c0214a50 <scsi_error_handler+0/180>

Code;  c02b3cd6 <__rdtsc_delay+16/20>
00000000 <_EIP>:
Code;  c02b3cd6 <__rdtsc_delay+16/20>   <=====
   0:   39 d8                     cmp    %ebx,%eax   <=====
Code;  c02b3cd8 <__rdtsc_delay+18/20>
   2:   72 f6                     jb     fffffffa <_EIP+0xfffffffa>
Code;  c02b3cda <__rdtsc_delay+1a/20>
   4:   5b                        pop    %ebx
Code;  c02b3cdb <__rdtsc_delay+1b/20>
   5:   c3                        ret    
Code;  c02b3cdc <__rdtsc_delay+1c/20>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c02b3ce0 <__loop_delay+0/30>
   a:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c02b3ce4 <__loop_delay+4/30>
   e:   eb 0a                     jmp    1a <_EIP+0x1a>
Code;  c02b3ce6 <__loop_delay+6/30>
  10:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c02b3ce9 <__loop_delay+9/30>
  13:   8d 00                     lea    (%eax),%eax


1 warning issued.  Results may not be reliable.

After reboot drive 1 (from 0-2) was dead. Replacement and rebuild worked.
If you have further questions, feel free to ask.

Regards,
Stephan
