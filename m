Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272745AbTHENY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272752AbTHENY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:24:27 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:6810 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272745AbTHENYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:24:24 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 15:24:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: decoded problem in 2.4.22-pre10
Message-Id: <20030805152421.12de6d0b.skraw@ithnet.com>
In-Reply-To: <94429E25D11@vcnet.vc.cvut.cz>
References: <94429E25D11@vcnet.vc.cvut.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 14:57:43 +0200
"Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:

> [Petr on ftruncate]

I can tell you this for sure: I don't need to start the app, only loading the
modules with their usual script is enough to shoot the box during heavy network
load.

At the moment I only have a partly decoded oops at hand where all the
vmware-modules symbols are missing (network action is Gig btw):


ksymoops 2.4.8 on i686 2.4.22-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre10/ (default)
     -m /boot/System.map-2.4.22-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 80f00064
c01d428b
*pde = 00000000   
Oops: 0000
CPU:    1
EIP:    0010:[<c01d428b>]    Tainted: PF  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000642   ebx: 00010000   ecx: 275da012   edx: 00000000
esi: 80f00000   edi: 00000090   ebp: f5dd5200   esp: f5603cb8   
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 2049, stackpage=f5603000)
Stack: c34e3d60 00010000 00000090 007c3758 000003be c34e3da0 000003ba 00000001
       00000291 007c3690 00010000 00000040 c34e3d60 00000292 c34e3c00 c01d457e
       c34e3d60 0000003f 00000001 c34e3cc0 c34e3c00 c034ffdc c034ffc0 c02539d2
Call Trace:    [<c01d457e>] [<c02539d2>] [<c01222d6>] [<c0109508>] [<c010c048>]
  [<c0130018>] [<c0138d70>] [<c0130c86>] [<c0133d4a>] [<c013431a>] [<f8c92419>]
  [<f8c98a3a>] [<f8c9f1fc>] [<f8c8d699>] [<f8c72938>] [<f8c9f1fc>] [<f8c9ea38>]
  [<f8c9ea58>] [<f8c8d411>] [<c010592e>] [<f8c8d210>]
Code: 8b 5e 64 85 db 0f 85 48 02 00 00 8b 44 24 18 8b 8e 88 00 00


>>EIP; c01d428b <tg3_rx+14b/3b0>   <=====

>>ebp; f5dd5200 <_end+35a29fe0/3852ee40>
>>esp; f5603cb8 <_end+35258a98/3852ee40>

Trace; c01d457e <tg3_poll+8e/150>
Trace; c02539d2 <net_rx_action+e2/160>
Trace; c01222d6 <do_softirq+76/e0>
Trace; c0109508 <do_IRQ+d8/f0>
Trace; c010c048 <call_do_IRQ+5/d>
Trace; c0130018 <.text.lock.mmap+b7/cf>
Trace; c0138d70 <lru_cache_add+10/70>
Trace; c0130c86 <add_to_page_cache_unique+56/90>
Trace; c0133d4a <do_generic_file_write+1ba/4b0>
Trace; c013431a <generic_file_write+8a/150>
Trace; f8c92419 <[nfsd]nfsd_procedures3+319/320>
Trace; f8c98a3a <.data.end+65db/????>
Trace; f8c9f1fc <END_OF_CODE+cd9d/????>
Trace; f8c8d699 <[nfsd]nfs3svc_decode_readargs+a9/100>
Trace; f8c72938 <[lockd]nlmclnt_lookup_host+18/30>
Trace; f8c9f1fc <END_OF_CODE+cd9d/????>
Trace; f8c9ea38 <END_OF_CODE+c5d9/????>
Trace; f8c9ea58 <END_OF_CODE+c5f9/????>
Trace; f8c8d411 <[nfsd]nfs3svc_decode_sattrargs+c1/f0>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; f8c8d210 <[nfsd]encode_wcc_data+50/f0>

Code;  c01d428b <tg3_rx+14b/3b0>
00000000 <_EIP>:
Code;  c01d428b <tg3_rx+14b/3b0>   <=====
   0:   8b 5e 64                  mov    0x64(%esi),%ebx   <=====
Code;  c01d428e <tg3_rx+14e/3b0>
   3:   85 db                     test   %ebx,%ebx
Code;  c01d4290 <tg3_rx+150/3b0>
   5:   0f 85 48 02 00 00         jne    253 <_EIP+0x253>
Code;  c01d4296 <tg3_rx+156/3b0>
   b:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c01d429a <tg3_rx+15a/3b0>
   f:   8b 8e 88 00 00 00         mov    0x88(%esi),%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


Regards,
Stephan

