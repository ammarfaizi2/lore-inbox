Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTIIH3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 03:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbTIIH3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 03:29:23 -0400
Received: from hell.org.pl ([212.244.218.42]:14354 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262378AbTIIH3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 03:29:20 -0400
Date: Tue, 9 Sep 2003 09:32:21 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, acpi-devel@lists.sourceforge.net,
       mmokrejs@natur.cuni.cz
Subject: Re: [ACPI] RE: [patch] 2.4.x ACPI updates
Message-ID: <20030909073221.GA1947@hell.org.pl>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	"Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	acpi-devel@lists.sourceforge.net, mmokrejs@natur.cuni.cz
References: <BF1FE1855350A0479097B3A0D2A80EE009FCCA@hdsmsx402.hd.intel.com> <Pine.LNX.4.55L.0308231826470.5824@freak.distro.conectiva> <20030823223340.GA7129@hell.org.pl> <20030902143756.GH1358@openzaurus.ucw.cz> <20030908132933.GA23269@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030908132933.GA23269@hell.org.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Karol Kozimor:
> > You should be able to do echo ? > /proc/acpi/*/fan/state to stress this manually...
> Of course. It prints the messages, but doesn't oops. I'm waiting to
> reproduce it on 2.4.23-pre here right now.

Gotcha! (see bug http://65.172.181.4/show_bug.cgi?id=1185 for reference)
2.4.23-pre3 (with some patches): first, the messages are printed: 

acpi_power-0363 [28] acpi_power_transition : Error transitioning device [CFAN] to D0
acpi_bus-0496 [27] acpi_bus_set_power    : Error transitioning device [CFAN] to D0
acpi_thermal-0549 [26] acpi_thermal_active   : Unable to turn cooling device [c12d24a8] 'on'

And then, 4 seconds after:

ksymoops 2.4.9 on i686 2.4.23-pre3-xcs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre3-xcs/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 876c33c4
*pde = 00000000
c01fd497
Oops: 0000
CPU:    0
EIP:    0010:[<c01fd497>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 876c33c4   ecx: cff0fd94   edx: 00000006
esi: 876c33c4   edi: cff0fdf0   ebp: c020c608   esp: cff0fd9c
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=cff0f000)
Stack: 00001001 c01fe17f 876c33c4 cff0fdc8 cff0fdf0 876c33c4 cff0fe2c c020c686
       876c33c4 c020c608 cff0fdf0 00010000 c02cd715 c02cd6ca 00000050 cff0fdf4
       cff0fdf4 876c33c4 c0213efe 876c33c4 cff0fdf0 00000000 00800000 c02ce900
Call Trace: [<c01fe17f>]  [<c020c686>]  [<c020c608>]  [<c0213efe>]  [<c02142f5>]  [<c0214651>]  [<c020ca83>]  [<c0208e00>]  [<c0218342>]  [<c02186bf>]  [<c0219402>]  [<c01ecaa4>]  [<c01e484d>]  [<c011d02a>]  [<c01256b3>]  [<c0125580>]  [<c0105000>]  [<c01058ee>]  [<c0125580>]
Code: 80 3b aa 0f 44 c3 5b c3 a1 d4 6b 3d c0 eb f7 8b 44 24 04 c3


>>EIP; c01fd497 <acpi_ns_map_handle_to_node+17/26>   <=====

>>ecx; cff0fd94 <_end+fb19fbc/1241e288>
>>edi; cff0fdf0 <_end+fb1a018/1241e288>
>>ebp; c020c608 <acpi_bus_data_handler+0/39>
>>esp; cff0fd9c <_end+fb19fc4/1241e288>

Trace; c01fe17f <acpi_get_data+38/5d>
Trace; c020c686 <acpi_bus_get_device+45/ae>
Trace; c020c608 <acpi_bus_data_handler+0/39>
Trace; c0213efe <acpi_power_get_context+4a/ae>
Trace; c02142f5 <acpi_power_off_device+4a/1a7>
Trace; c0214651 <acpi_power_transition+113/13c>
Trace; c020ca83 <acpi_bus_set_power+170/298>
Trace; c0208e00 <acpi_ut_track_stack_ptr+1f/26>
Trace; c0218342 <acpi_thermal_active+c4/190>
Trace; c02186bf <acpi_thermal_check+29d/2ec>
Trace; c0219402 <acpi_thermal_notify+a9/10a>
Trace; c01ecaa4 <acpi_ev_notify_dispatch+52/75>
Trace; c01e484d <acpi_os_execute_deferred+39/75>
Trace; c011d02a <__run_task_queue+5a/70>
Trace; c01256b3 <context_thread+133/1d0>
Trace; c0125580 <context_thread+0/1d0>
Trace; c0105000 <_stext+0/0>
Trace; c01058ee <arch_kernel_thread+2e/40>
Trace; c0125580 <context_thread+0/1d0>

Code;  c01fd497 <acpi_ns_map_handle_to_node+17/26>
00000000 <_EIP>:
Code;  c01fd497 <acpi_ns_map_handle_to_node+17/26>   <=====
   0:   80 3b aa                  cmpb   $0xaa,(%ebx)   <=====
Code;  c01fd49a <acpi_ns_map_handle_to_node+1a/26>
   3:   0f 44 c3                  cmove  %ebx,%eax
Code;  c01fd49d <acpi_ns_map_handle_to_node+1d/26>
   6:   5b                        pop    %ebx
Code;  c01fd49e <acpi_ns_map_handle_to_node+1e/26>
   7:   c3                        ret
Code;  c01fd49f <acpi_ns_map_handle_to_node+1f/26>
   8:   a1 d4 6b 3d c0            mov    0xc03d6bd4,%eax
Code;  c01fd4a4 <acpi_ns_map_handle_to_node+24/26>
   d:   eb f7                     jmp    6 <_EIP+0x6>
Code;  c01fd4a6 <acpi_ns_convert_entry_to_handle+0/5>
   f:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c01fd4aa <acpi_ns_convert_entry_to_handle+4/5>
  13:   c3                        ret

Hope that helps.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
