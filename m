Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTIDIvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264806AbTIDIvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:51:12 -0400
Received: from hell.org.pl ([212.244.218.42]:65034 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264786AbTIDIvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:51:06 -0400
Date: Thu, 4 Sep 2003 10:53:15 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Brown, Len" <len.brown@intel.com>
Cc: Martin Mokrejs <mmokrejs@natur.cuni.cz>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Message-ID: <20030904085315.GA29773@hell.org.pl>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	Martin Mokrejs <mmokrejs@natur.cuni.cz>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Brown, Len:
> Martin,
> Does this still happen with 2.4.22?
> If yes, can I trouble you to drop the info into bugzilla so we can put
> it in the queue?

FYI, I just had it *after* boot, i.e. some 30 seconds after the swsusp 
resume (trace below), and _again_ _after_ I warm-rebooted the machine using
SysRq+B. The subsequent warm-reboot went OK.

Linux 2.4.21 + ACPI 20030619

ksymoops 2.4.9 on i686 2.4.21-xacs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-xacs/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c01d7600
Oops: 0000
8139too mii snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-page-alloc
snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore ppp_deflate
zlib_inflate zlib_deflate ppp_async ppp_generic slhc ptserial pctel sr_mod
scsi_mod cdrom radeon agpgart asus_acpi mousedev hid input uhci usbcore ds
yenta_socket pcmcia_core
CPU:    0
EIP:    0010:[<c01d7600>]    Tainted: P Z
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210293
eax: 00000627   ebx: 872d3184   ecx: cff0fe08   edx: 00000000
esi: 872d3184   edi: cff0fe70   ebp: c01e6bcc   esp: cff0fe10
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=cff0f000)
Stack: 00000000 c01d837d 872d3184 cff0fe48 cff0fe70 872d3184 872d3184
c01e6c6f
       872d3184 c01e6bcc cff0fe70 872d3184 cff0fe74 cff0fea0 00010000
c02912cb
       c0291280 c01ee511 872d3184 cff0fe70 872d3184 cff0fea4 cff12e00
00000000
Call Trace: [<c01d837d>]  [<c01e6c6f>]  [<c01e6bcc>]  [<c01ee511>]
[<c01ee964>]  [<c01eed14>]  [<c01e70bc>]  [<c01f2c73>]  [<c01f2f10>]
[<c01bdc09>]  [<c0118d5c>]  [<c011fecd>]  [<c0105668>]
Code: 80 3b aa 75 0b 89 d8 eb 09 8d b4 26 00 00 00 00 31 c0 5b c3


>>EIP; c01d7600 <acpi_ns_map_handle_to_node+1c/30>   <=====

>>ecx; cff0fe08 <_end+fbda4b0/124de708>
>>edi; cff0fe70 <_end+fbda518/124de708>
>>ebp; c01e6bcc <acpi_bus_data_handler+0/44>
>>esp; cff0fe10 <_end+fbda4b8/124de708>

Trace; c01d837d <acpi_get_data+39/6a>
Trace; c01e6c6f <acpi_bus_get_device+5f/b4>
Trace; c01e6bcc <acpi_bus_data_handler+0/44>
Trace; c01ee511 <acpi_power_get_context+61/cc>
Trace; c01ee964 <acpi_power_off_device+4c/1e0>
Trace; c01eed14 <acpi_power_transition+100/15c>
Trace; c01e70bc <acpi_bus_set_power+1b0/29c>
Trace; c01f2c73 <acpi_thermal_active+d3/1cc>
Trace; c01f2f10 <acpi_thermal_check+18c/2ac>
Trace; c01bdc09 <acpi_os_execute_deferred+5d/7c>
Trace; c0118d5c <__run_task_queue+50/5c>
Trace; c011fecd <context_thread+121/1a0>
Trace; c0105668 <arch_kernel_thread+28/38>

Code;  c01d7600 <acpi_ns_map_handle_to_node+1c/30>
00000000 <_EIP>:
Code;  c01d7600 <acpi_ns_map_handle_to_node+1c/30>   <=====
   0:   80 3b aa                  cmpb   $0xaa,(%ebx)   <=====
Code;  c01d7603 <acpi_ns_map_handle_to_node+1f/30>
   3:   75 0b                     jne    10 <_EIP+0x10>
Code;  c01d7605 <acpi_ns_map_handle_to_node+21/30>
   5:   89 d8                     mov    %ebx,%eax
Code;  c01d7607 <acpi_ns_map_handle_to_node+23/30>
   7:   eb 09                     jmp    12 <_EIP+0x12>
Code;  c01d7609 <acpi_ns_map_handle_to_node+25/30>
   9:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01d7610 <acpi_ns_map_handle_to_node+2c/30>
  10:   31 c0                     xor    %eax,%eax
Code;  c01d7612 <acpi_ns_map_handle_to_node+2e/30>
  12:   5b                        pop    %ebx
Code;  c01d7613 <acpi_ns_map_handle_to_node+2f/30>
  13:   c3                        ret


1 warning issued.  Results may not be reliable.

[the kernel is tainted by swsusp and pctel module, but it shouldn't really
 matter since this oops happens mainly at boot]

I'll have yet to see if it still happens with 2.4.22.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
