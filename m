Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTKHAdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTKGWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:05:51 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:13023 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S264618AbTKGT7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 14:59:14 -0500
Date: Fri, 7 Nov 2003 17:58:26 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Oops trying to use an USB Drive (was: Re: Problems with USB Drive)
Message-ID: <20031107195826.GA1343@ime.usp.br>
References: <20031105175609.GA967@ime.usp.br> <20031106022528.GA3636@ime.usp.br> <20031106224920.GA2638@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031106224920.GA2638@ime.usp.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06 2003, Rogério Brito wrote:
> On Nov 06 2003, Rogério Brito wrote:
> > Just as some extra information, when I try to shutdown the hotplug
> > service (via /etc/init.d/hotplug stop), the program hangs and I get
> > processes in the D state in the output of ps.
> (...)
> 
> Please feel free to ask me whatever you feel is important and I will do
> my best to answer to get this working correctly.

Unfortunately, when using a kernel from the 2.4 series, I am still not
able to use my USB Drive.

Just as a reminder, I was having problems with various 2.4 kernels and
decided to try a 2.6 kernel (2.6.0-test9). Since I also had problems
there (with data available at http://www.ime.usp.br/~rbrito/usb/), I
decided to go back to a 2.4 kernel, 2.4.23-pre9 + the current packet
writing patch.

I got many errors when I booted my system. Then, I tried playing with
the hotplug scripts (disabling hotplug). And I got an Oops.

The decoded oops is here:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ksymoops 2.4.9 on i686 2.4.23-pre9-pkt-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre9-pkt-1/ (default)
     -m /boot/System.map-2.4.23-pre9-pkt-1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at slab.c:815!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012a6f3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c7feaae0   ecx: c7feaa6c   edx: c7feaa6c
esi: c7feaa66   edi: c8899a2a   ebp: c027b1d8   esp: c368deec
ds: 0018   es: 0018   ss: 0018
Process modprobe.moduti (pid: 1259, stackpage=c368d000)
Stack: fffffffc 0000001c fffffff4 00000001 00000001 ffffffea c88994b5 c8899a1c 
       0000003c 00000010 00000000 00000000 00000000 c8895000 c0116935 c889ab60 
       0808c6e0 00005a90 00000060 00000060 00000004 c61a3d00 c393a000 c38f4000 
Call Trace:    [<c88994b5>] [<c8899a1c>] [<c0116935>] [<c889ab60>] [<c8895060>]
  [<c0106e93>]
Code: 0f 0b 2f 03 62 fb 1f c0 8b 12 81 fa a4 78 22 c0 75 d3 8d 43 


>>EIP; c012a6f3 <kmem_cache_create+28b/338>   <=====

>>ebx; c7feaae0 <_end+7d4f0c8/859a648>
>>ecx; c7feaa6c <_end+7d4f054/859a648>
>>edx; c7feaa6c <_end+7d4f054/859a648>
>>esi; c7feaa66 <_end+7d4f04e/859a648>
>>edi; c8899a2a <[uhci].text.end+425/13db>
>>ebp; c027b1d8 <cache_chain_sem+0/10>
>>esp; c368deec <_end+33f24d4/859a648>

Trace; c88994b5 <[uhci]uhci_hcd_init+69/f4>
Trace; c8899a1c <[uhci].text.end+417/13db>
Trace; c0116935 <sys_init_module+4d1/62c>
Trace; c889ab60 <[uhci]__module_license+45/85>
Trace; c8895060 <[uhci]uhci_show_td+0/198>
Trace; c0106e93 <system_call+33/38>

Code;  c012a6f3 <kmem_cache_create+28b/338>
00000000 <_EIP>:
Code;  c012a6f3 <kmem_cache_create+28b/338>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a6f5 <kmem_cache_create+28d/338>
   2:   2f                        das    
Code;  c012a6f6 <kmem_cache_create+28e/338>
   3:   03 62 fb                  add    0xfffffffb(%edx),%esp
Code;  c012a6f9 <kmem_cache_create+291/338>
   6:   1f                        pop    %ds
Code;  c012a6fa <kmem_cache_create+292/338>
   7:   c0 8b 12 81 fa a4 78      rorb   $0x78,0xa4fa8112(%ebx)
Code;  c012a701 <kmem_cache_create+299/338>
   e:   22 c0                     and    %al,%al
Code;  c012a703 <kmem_cache_create+29b/338>
  10:   75 d3                     jne    ffffffe5 <_EIP+0xffffffe5>
Code;  c012a705 <kmem_cache_create+29d/338>
  12:   8d 43 00                  lea    0x0(%ebx),%eax


1 warning issued.  Results may not be reliable.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Please, can anybody help? :-(


Thanks in advance for any feedback, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
