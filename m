Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130754AbQLECAK>; Mon, 4 Dec 2000 21:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130589AbQLECAB>; Mon, 4 Dec 2000 21:00:01 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:26373
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129547AbQLEB7u>; Mon, 4 Dec 2000 20:59:50 -0500
Date: Mon, 4 Dec 2000 20:39:29 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre4 boot failure (better than pre3 and lower)
Message-ID: <20001204203929.A10058@animx.eu.org>
In-Reply-To: <20001204162642.A5553@animx.eu.org> <3906.975966211@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3906.975966211@ocs3.ocs-net>; from Keith Owens on Tue, Dec 05, 2000 at 08:43:31AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most architectures dump their code as a string of bytes and print the
> code after the registers and trace back.  Alpha dumps the code before
> the trace and also decodes the instructions which really confuses
> ksymoops.  Somebody changed 'Trace: ' to 'Trace:' between 2.2 and 2.4
> kernels so ksymoops no longer picks the trace data.
> 
> Is there any chance of changing arch/alpha/kernel/traps.c to print
> registers, trace and _raw_ code, in that order so it is more like other
> architectures?  You can print the decoded instructions as well (prefix
> Decode:, not Code:) as long as the raw code bytes are also available.
> 
> In the meantime, this patch to ksymoops 2.3.5 will pick up the change
> to the trace lines.  It will still complain about a bad code line,
> ksymoops is built for raw data.

Didn't help much:
[wakko@kakarot:/home/wakko/ksymoops-2.3.4] ./ksymoops -v /usr/src/2.4.0-test12-pre4/vmlinux -K -L -O -m /usr/src/2.4.0-test12-pre4/System.map < /rod/home/wakko/240t12p4-boot 
ksymoops 2.3.4 on alpha 2.2.17-LVM-RAID.  Options used
     -v /usr/src/2.4.0-test12-pre4/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/2.4.0-test12-pre4/System.map (specified)

Unable to handle kernel paging request at virtual address 0000000000000010
swapper(53): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 40203001  addl t0,1,t0'
  Garbage: 'l t0,1,t0'
Error (Oops_code_values): invalid value 0xadd in Code line, must be 2, 4, 8 or 16 digits, value ignored

>>PC;  fffffc0000323270 <exec_usermodehelper+f0/480>   <=====
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
0000000000000000 <_PC>:
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
   0:   01 30 20 40       addl t0,0x1,t0

 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
 a52a0028  ldq s0,40(s1)
Trace:323658 323600 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(54): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 40203001  addl t0,1,t0'
  Garbage: 'l t0,1,t0'
Error (Oops_code_values): invalid value 0xadd in Code line, must be 2, 4, 8 or 16 digits, value ignored

Trace; 0000000000323658 Before first symbol
Trace; 0000000000323600 Before first symbol
>>PC;  fffffc0000323270 <exec_usermodehelper+f0/480>   <=====
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
0000000000000000 <_PC>:
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
   0:   01 30 20 40       addl t0,0x1,t0

 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
 a52a0028  ldq s0,40(s1)
Trace:323658 323600 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(56): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 40203001  addl t0,1,t0'
  Garbage: 'l t0,1,t0'
Error (Oops_code_values): invalid value 0xadd in Code line, must be 2, 4, 8 or 16 digits, value ignored

Trace; 0000000000323658 Before first symbol
Trace; 0000000000323600 Before first symbol
>>PC;  fffffc0000323270 <exec_usermodehelper+f0/480>   <=====
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
0000000000000000 <_PC>:
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
   0:   01 30 20 40       addl t0,0x1,t0

 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
 a52a0028  ldq s0,40(s1)
Trace:323658 323600 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(57): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 40203001  addl t0,1,t0'
  Garbage: 'l t0,1,t0'
Error (Oops_code_values): invalid value 0xadd in Code line, must be 2, 4, 8 or 16 digits, value ignored

Trace; 0000000000323658 Before first symbol
Trace; 0000000000323600 Before first symbol
>>PC;  fffffc0000323270 <exec_usermodehelper+f0/480>   <=====
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
0000000000000000 <_PC>:
Code;  fffffc0000323270 <exec_usermodehelper+f0/480>
   0:   01 30 20 40       addl t0,0x1,t0

 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
 a52a0028  ldq s0,40(s1)
Trace:323658 323600 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; 0000000000323658 Before first symbol
Trace; 0000000000323600 Before first symbol


5 warnings and 4 errors issued.  Results may not be reliable.
[wakko@kakarot:/home/wakko/ksymoops-2.3.4] 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
