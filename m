Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312515AbSCUVvL>; Thu, 21 Mar 2002 16:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312516AbSCUVvC>; Thu, 21 Mar 2002 16:51:02 -0500
Received: from gherkin.frus.com ([192.158.254.49]:12160 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S312515AbSCUVuv>;
	Thu, 21 Mar 2002 16:50:51 -0500
Message-Id: <m16oASN-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: 2.5.7: acct.c oops
In-Reply-To: <20020321092526.A11399@doc.pdx.osdl.net> "from Bob Miller at Mar
 21, 2002 09:25:27 am"
To: Bob Miller <rem@osdl.org>
Date: Thu, 21 Mar 2002 15:50:47 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Miller wrote:
> On Thu, Mar 21, 2002 at 09:50:10AM -0600, Bob_Tracy wrote:
> > Running "accton" (with or without arguments) consistently generates
> > an oops at linux/kernel/acct.c:169
> > 	BUG_ON(!spin_is_locked(&acct_globals.lock));
> 
> Do you have the rest of the of oops message passed through ksymoops?
> I'll also try to reproduce here.  TIA.

Synopsis: after a fresh boot, ran "accton" with no arguments.  It died
with a segmentation violation, and generated an "oops".

Here's the ksymoops output.  Since this involves the libc acct() function,
you'll probably be interested in the C library version as well: 2.2.3.
Compiler is "gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)".

====--CUT HERE--====
ksymoops 2.4.5 on i586 2.5.7.  Options used
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

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
kernel BUG at acct.c:169!
invalid operand: 0000
CPU:    0
EIP:    0010:[acct_file_reopen+8/224]    Not tainted
EFLAGS: 00010246
eax: d644d200   ebx: 00000000   ecx: 00000001   edx: 00000000
esi: 00000000   edi: d2d1e000   ebp: bffffa2c   esp: d2d1ffa4
ds: 0018   es: 0018   ss: 0018
Stack: d2d1e000 00000000 c011cd89 00000000 d2d1e000 00000001 00000000 c0107007 
       00000000 00000001 bffffa94 00000001 00000000 bffffa2c 00000033 0000002b 
       0000002b 00000033 400e4e6d 00000023 00000246 bffffa14 0000002b 
Call Trace: [sys_acct+197/232] [syscall_call+7/11] 
Code: 0f 0b a9 00 ff dd 22 c0 a1 2c cb 2c c0 85 c0 74 2f 89 c6 68 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; d644d200 <END_OF_CODE+16150ed4/????>
>>edi; d2d1e000 <END_OF_CODE+12a21cd4/????>
>>ebp; bffffa2c Before first symbol
>>esp; d2d1ffa4 <END_OF_CODE+12a23c78/????>

Code;  00000000 Before first symbol
0000000000000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   a9 00 ff dd 22            test   $0x22ddff00,%eax
Code;  00000007 Before first symbol
   7:   c0 a1 2c cb 2c c0 85      shlb   $0x85,0xc02ccb2c(%ecx)
Code;  0000000e Before first symbol
   e:   c0                        (bad)  
Code;  0000000f Before first symbol
   f:   74 2f                     je     40 <_EIP+0x40> 00000040 Before first symbol
Code;  00000011 Before first symbol
  11:   89 c6                     mov    %eax,%esi
Code;  00000013 Before first symbol
  13:   68 00 00 00 00            push   $0x0


2 warnings issued.  Results may not be reliable.
====--TUC EREH--====

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
