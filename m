Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUGMUbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUGMUbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbUGMUbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:31:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29653 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265823AbUGMUaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:30:52 -0400
Date: Tue, 13 Jul 2004 13:30:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: panic from isp1020
Message-ID: <133950000.1089750625@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7-mm4

Unable to handle kernel NULL pointer dereference at virtual address 00000154
 printing eip:
c01eb588
*pde = 26549001
*pte = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c01eb588>]    Not tainted VLI
EFLAGS: 00010046   (2.6.7-mm4) 
EIP is at isp1020_intr_handler+0x23c/0x2e0
eax: 00000000   ebx: f0c78000   ecx: 00000000   edx: 00000050
esi: 00000000   edi: 00000001   ebp: f13c8000   esp: c0343f30
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0342000 task=c02b9980)
Stack: f0c78000 00000002 f13c8000 00000000 00000013 00000001 f13c81cc c01eb339 
       00000013 f13c8000 c0343fac f13d1bc0 24000001 c0105a37 00000013 f13c8000 
       c0343fac c033ba60 00000260 00000013 c0343fa4 c0105d42 00000013 c0343fac 
Call Trace:
 [<c01eb339>] do_isp1020_intr_handler+0x25/0x38
 [<c0105a37>] handle_IRQ_event+0x2b/0x50
 [<c0105d42>] do_IRQ+0xa2/0x124
 [<c010451c>] common_interrupt+0x18/0x20
 [<c0101ffc>] default_idle+0x2c/0x34
 [<c010207c>] cpu_idle+0x30/0x40
 [<c01002e9>] rest_init+0x49/0x4c
 [<c03448c6>] start_kernel+0x172/0x178
Code: 00 01 00 00 00 f6 43 0d 20 74 15 8d 96 c0 00 00 00 8d 43 20 6a 60 50 52 e8 d6 8f fc ff 83 c4 0c 80 3b 03 75 11 53 e8 a4 00 00 00 <89> 86 54 01 00 00 83 c4 04 eb 0a c7 86 54 01 00 00 00 00 07 00 


The EIP according to addr2line is:
Cmnd->result = isp1020_return_status(sts);
	(drivers/scsi/qlogicisp.c:1048)

0xc01eb588 <isp1020_intr_handler+572>:  mov    %eax,0x154(%esi)

but esi is 0 ....


Dump of assembler code for function isp1020_intr_handler:
0xc01eb34c <isp1020_intr_handler+0>:    sub    $0x8,%esp
0xc01eb34f <isp1020_intr_handler+3>:    push   %ebp
0xc01eb350 <isp1020_intr_handler+4>:    push   %edi
0xc01eb351 <isp1020_intr_handler+5>:    push   %esi
0xc01eb352 <isp1020_intr_handler+6>:    push   %ebx
0xc01eb353 <isp1020_intr_handler+7>:    mov    0x20(%esp,1),%ebp
0xc01eb357 <isp1020_intr_handler+11>:   lea    0x1cc(%ebp),%eax
0xc01eb35d <isp1020_intr_handler+17>:   mov    %eax,0x14(%esp,1)
0xc01eb361 <isp1020_intr_handler+21>:   mov    0x1cc(%ebp),%eax
0xc01eb367 <isp1020_intr_handler+27>:   test   %eax,%eax
0xc01eb369 <isp1020_intr_handler+29>:   je     0xc01eb371 <isp1020_intr_handler+37>
0xc01eb36b <isp1020_intr_handler+31>:   movzwl 0xa(%eax),%eax
0xc01eb36f <isp1020_intr_handler+35>:   jmp    0xc01eb392 <isp1020_intr_handler+70>
0xc01eb371 <isp1020_intr_handler+37>:   mov    0xb4(%ebp),%edx
0xc01eb377 <isp1020_intr_handler+43>:   mov    0xc039e538,%eax
0xc01eb37c <isp1020_intr_handler+48>:   add    $0xa,%edx
0xc01eb37f <isp1020_intr_handler+51>:   test   %eax,%eax
0xc01eb381 <isp1020_intr_handler+53>:   je     0xc01eb390 <isp1020_intr_handler+68>
0xc01eb383 <isp1020_intr_handler+55>:   movzwl (%edx,%eax,1),%eax
0xc01eb387 <isp1020_intr_handler+59>:   jmp    0xc01eb392 <isp1020_intr_handler+70>
0xc01eb389 <isp1020_intr_handler+61>:   lea    0x0(%esi,1),%esi
0xc01eb390 <isp1020_intr_handler+68>:   in     (%dx),%ax
0xc01eb392 <isp1020_intr_handler+70>:   test   $0x4,%al
0xc01eb394 <isp1020_intr_handler+72>:   je     0xc01eb624 <isp1020_intr_handler+728>
0xc01eb39a <isp1020_intr_handler+78>:   mov    0x1cc(%ebp),%eax
0xc01eb3a0 <isp1020_intr_handler+84>:   test   %eax,%eax
0xc01eb3a2 <isp1020_intr_handler+86>:   je     0xc01eb3b0 <isp1020_intr_handler+100>
0xc01eb3a4 <isp1020_intr_handler+88>:   movzwl 0x7a(%eax),%eax
0xc01eb3a8 <isp1020_intr_handler+92>:   jmp    0xc01eb3ca <isp1020_intr_handler+126>
0xc01eb3aa <isp1020_intr_handler+94>:   lea    0x0(%esi),%esi
0xc01eb3b0 <isp1020_intr_handler+100>:  mov    0xb4(%ebp),%edx
0xc01eb3b6 <isp1020_intr_handler+106>:  mov    0xc039e538,%eax
0xc01eb3bb <isp1020_intr_handler+111>:  add    $0x7a,%edx
0xc01eb3be <isp1020_intr_handler+114>:  test   %eax,%eax
0xc01eb3c0 <isp1020_intr_handler+116>:  je     0xc01eb3c8 <isp1020_intr_handler+124>
0xc01eb3c2 <isp1020_intr_handler+118>:  movzwl (%edx,%eax,1),%eax
0xc01eb3c6 <isp1020_intr_handler+122>:  jmp    0xc01eb3ca <isp1020_intr_handler+126>
0xc01eb3c8 <isp1020_intr_handler+124>:  in     (%dx),%ax
0xc01eb3ca <isp1020_intr_handler+126>:  movzwl %ax,%eax
0xc01eb3cd <isp1020_intr_handler+129>:  mov    %eax,0x10(%esp,1)
0xc01eb3d1 <isp1020_intr_handler+133>:  mov    0x1cc(%ebp),%eax
 0xc01eb3d7 <isp1020_intr_handler+139>:  mov    $0x7000,%ecx
0xc01eb3dc <isp1020_intr_handler+144>:  test   %eax,%eax
0xc01eb3de <isp1020_intr_handler+146>:  je     0xc01eb3f0 <isp1020_intr_handler+164>
0xc01eb3e0 <isp1020_intr_handler+148>:  mov    %cx,0xc0(%eax)
0xc01eb3e7 <isp1020_intr_handler+155>:  jmp    0xc01eb414 <isp1020_intr_handler+200>
0xc01eb3e9 <isp1020_intr_handler+157>:  lea    0x0(%esi,1),%esi
0xc01eb3f0 <isp1020_intr_handler+164>:  mov    0xb4(%ebp),%edx
0xc01eb3f6 <isp1020_intr_handler+170>:  mov    0xc039e538,%eax
0xc01eb3fb <isp1020_intr_handler+175>:  add    $0xc0,%edx
0xc01eb401 <isp1020_intr_handler+181>:  test   %eax,%eax
0xc01eb403 <isp1020_intr_handler+183>:  je     0xc01eb410 <isp1020_intr_handler+196>
0xc01eb405 <isp1020_intr_handler+185>:  mov    %cx,(%edx,%eax,1)
0xc01eb409 <isp1020_intr_handler+189>:  jmp    0xc01eb414 <isp1020_intr_handler+200>
0xc01eb40b <isp1020_intr_handler+191>:  nop    
0xc01eb40c <isp1020_intr_handler+192>:  lea    0x0(%esi,1),%esi
0xc01eb410 <isp1020_intr_handler+196>:  mov    %ecx,%eax
0xc01eb412 <isp1020_intr_handler+198>:  out    %ax,(%dx)
0xc01eb414 <isp1020_intr_handler+200>:  mov    0x1cc(%ebp),%eax
0xc01eb41a <isp1020_intr_handler+206>:  test   %eax,%eax
0xc01eb41c <isp1020_intr_handler+208>:  je     0xc01eb424 <isp1020_intr_handler+216>
0xc01eb41e <isp1020_intr_handler+210>:  movzwl 0xc(%eax),%eax
0xc01eb422 <isp1020_intr_handler+214>:  jmp    0xc01eb442 <isp1020_intr_handler+246>
0xc01eb424 <isp1020_intr_handler+216>:  mov    0xb4(%ebp),%edx
0xc01eb42a <isp1020_intr_handler+222>:  mov    0xc039e538,%eax
0xc01eb42f <isp1020_intr_handler+227>:  add    $0xc,%edx
0xc01eb432 <isp1020_intr_handler+230>:  test   %eax,%eax
0xc01eb434 <isp1020_intr_handler+232>:  je     0xc01eb440 <isp1020_intr_handler+244>
0xc01eb436 <isp1020_intr_handler+234>:  movzwl (%edx,%eax,1),%eax
0xc01eb43a <isp1020_intr_handler+238>:  jmp    0xc01eb442 <isp1020_intr_handler+246>
0xc01eb43c <isp1020_intr_handler+240>:  lea    0x0(%esi,1),%esi
0xc01eb440 <isp1020_intr_handler+244>:  in     (%dx),%ax
0xc01eb442 <isp1020_intr_handler+246>:  test   $0x1,%al
0xc01eb444 <isp1020_intr_handler+248>:  je     0xc01eb504 <isp1020_intr_handler+440>
0xc01eb44a <isp1020_intr_handler+254>:  mov    0x1cc(%ebp),%eax
0xc01eb450 <isp1020_intr_handler+260>:  test   %eax,%eax
0xc01eb452 <isp1020_intr_handler+262>:  je     0xc01eb460 <isp1020_intr_handler+276>
0xc01eb454 <isp1020_intr_handler+264>:  movzwl 0x70(%eax),%eax
0xc01eb458 <isp1020_intr_handler+268>:  jmp    0xc01eb47a <isp1020_intr_handler+302>
0xc01eb45a <isp1020_intr_handler+270>:  lea    0x0(%esi),%esi
0xc01eb460 <isp1020_intr_handler+276>:  mov    0xb4(%ebp),%edx
0xc01eb466 <isp1020_intr_handler+282>:  mov    0xc039e538,%eax
0xc01eb46b <isp1020_intr_handler+287>:  add    $0x70,%edx
0xc01eb46e <isp1020_intr_handler+290>:  test   %eax,%eax
0xc01eb470 <isp1020_intr_handler+292>:  je     0xc01eb478 <isp1020_intr_handler+300>
0xc01eb472 <isp1020_intr_handler+294>:  movzwl (%edx,%eax,1),%eax
0xc01eb476 <isp1020_intr_handler+298>:  jmp    0xc01eb47a <isp1020_intr_handler+302>
0xc01eb478 <isp1020_intr_handler+300>:  in     (%dx),%ax
0xc01eb47a <isp1020_intr_handler+302>:  movzwl %ax,%eax
0xc01eb47d <isp1020_intr_handler+305>:  cmp    $0x4006,%eax
0xc01eb482 <isp1020_intr_handler+310>:  jg     0xc01eb4a0 <isp1020_intr_handler+340>
0xc01eb484 <isp1020_intr_handler+312>:  cmp    $0x4005,%eax
0xc01eb489 <isp1020_intr_handler+317>:  jge    0xc01eb4c0 <isp1020_intr_handler+372>
0xc01eb48b <isp1020_intr_handler+319>:  cmp    $0x4002,%eax
0xc01eb490 <isp1020_intr_handler+324>:  jg     0xc01eb4cd <isp1020_intr_handler+385>
0xc01eb492 <isp1020_intr_handler+326>:  cmp    $0x4001,%eax
0xc01eb497 <isp1020_intr_handler+331>:  jl     0xc01eb4cd <isp1020_intr_handler+385>
0xc01eb499 <isp1020_intr_handler+333>:  jmp    0xc01eb4c0 <isp1020_intr_handler+372>
0xc01eb49b <isp1020_intr_handler+335>:  nop    
0xc01eb49c <isp1020_intr_handler+336>:  lea    0x0(%esi,1),%esi
0xc01eb4a0 <isp1020_intr_handler+340>:  cmp    $0x8001,%eax
0xc01eb4a5 <isp1020_intr_handler+345>:  je     0xc01eb4ae <isp1020_intr_handler+354>
0xc01eb4a7 <isp1020_intr_handler+347>:  cmp    $0x8006,%eax
0xc01eb4ac <isp1020_intr_handler+352>:  jne    0xc01eb4cd <isp1020_intr_handler+385>
0xc01eb4ae <isp1020_intr_handler+354>:  mov    0x14(%esp,1),%eax
0xc01eb4b2 <isp1020_intr_handler+358>:  movl   $0x1,0xf8(%eax)
0xc01eb4bc <isp1020_intr_handler+368>:  jmp    0xc01eb4cd <isp1020_intr_handler+385>
0xc01eb4be <isp1020_intr_handler+370>:  mov    %esi,%esi
0xc01eb4c0 <isp1020_intr_handler+372>:  push   $0xc02954a0
0xc01eb4c5 <isp1020_intr_handler+377>:  call   0xc0118814 <printk>
0xc01eb4ca <isp1020_intr_handler+382>:  add    $0x4,%esp
0xc01eb4cd <isp1020_intr_handler+385>:  mov    0x1cc(%ebp),%eax
0xc01eb4d3 <isp1020_intr_handler+391>:  test   %eax,%eax
0xc01eb4d5 <isp1020_intr_handler+393>:  je     0xc01eb4e0 <isp1020_intr_handler+404>
0xc01eb4d7 <isp1020_intr_handler+395>:  movw   $0x0,0xc(%eax)
0xc01eb4dd <isp1020_intr_handler+401>:  jmp    0xc01eb504 <isp1020_intr_handler+440>
0xc01eb4df <isp1020_intr_handler+403>:  nop    
0xc01eb4e0 <isp1020_intr_handler+404>:  mov    0xb4(%ebp),%edx
0xc01eb4e6 <isp1020_intr_handler+410>:  mov    0xc039e538,%eax
0xc01eb4eb <isp1020_intr_handler+415>:  add    $0xc,%edx
0xc01eb4ee <isp1020_intr_handler+418>:  test   %eax,%eax
0xc01eb4f0 <isp1020_intr_handler+420>:  je     0xc01eb500 <isp1020_intr_handler+436>
0xc01eb4f2 <isp1020_intr_handler+422>:  movw   $0x0,(%edx,%eax,1)
0xc01eb4f8 <isp1020_intr_handler+428>:  jmp    0xc01eb504 <isp1020_intr_handler+440>
0xc01eb4fa <isp1020_intr_handler+430>:  lea    0x0(%esi),%esi
0xc01eb500 <isp1020_intr_handler+436>:  xor    %eax,%eax
0xc01eb502 <isp1020_intr_handler+438>:  out    %ax,(%dx)
0xc01eb504 <isp1020_intr_handler+440>:  mov    0x14(%esp,1),%eax
0xc01eb508 <isp1020_intr_handler+444>:  mov    0xf4(%eax),%edi
0xc01eb50e <isp1020_intr_handler+450>:  cmp    0x10(%esp,1),%edi
0xc01eb512 <isp1020_intr_handler+454>:  je     0xc01eb61a <isp1020_intr_handler+718>
0xc01eb518 <isp1020_intr_handler+460>:  mov    0x14(%esp,1),%eax
0xc01eb51c <isp1020_intr_handler+464>:  mov    %edi,%ebx
0xc01eb51e <isp1020_intr_handler+466>:  shl    $0x6,%ebx
0xc01eb521 <isp1020_intr_handler+469>:  inc    %edi
0xc01eb522 <isp1020_intr_handler+470>:  add    0xe8(%eax),%ebx
0xc01eb528 <isp1020_intr_handler+476>:  and    $0x7,%edi
0xc01eb52b <isp1020_intr_handler+479>:  add    $0xfc,%eax
0xc01eb530 <isp1020_intr_handler+484>:  mov    0x4(%ebx),%edx
0xc01eb533 <isp1020_intr_handler+487>:  shl    $0x2,%edx
0xc01eb536 <isp1020_intr_handler+490>:  mov    (%edx,%eax,1),%esi
0xc01eb539 <isp1020_intr_handler+493>:  movl   $0x0,(%edx,%eax,1)
0xc01eb540 <isp1020_intr_handler+500>:  movzwl 0xa(%ebx),%eax
0xc01eb544 <isp1020_intr_handler+504>:  add    $0xfffffffc,%ax
0xc01eb548 <isp1020_intr_handler+508>:  cmp    $0x1,%ax
0xc01eb54c <isp1020_intr_handler+512>:  jbe    0xc01eb554 <isp1020_intr_handler+520>
0xc01eb54e <isp1020_intr_handler+514>:  testb  $0x8,0xe(%ebx)
0xc01eb552 <isp1020_intr_handler+518>:  je     0xc01eb562 <isp1020_intr_handler+534>
0xc01eb554 <isp1020_intr_handler+520>:  mov    0x14(%esp,1),%eax
0xc01eb558 <isp1020_intr_handler+524>:  movl   $0x1,0xf8(%eax)
0xc01eb562 <isp1020_intr_handler+534>:  testb  $0x20,0xd(%ebx)
0xc01eb566 <isp1020_intr_handler+538>:  je     0xc01eb57d <isp1020_intr_handler+561>
0xc01eb568 <isp1020_intr_handler+540>:  lea    0xc0(%esi),%edx
0xc01eb56e <isp1020_intr_handler+546>:  lea    0x20(%ebx),%eax
0xc01eb571 <isp1020_intr_handler+549>:  push   $0x60
0xc01eb573 <isp1020_intr_handler+551>:  push   %eax
0xc01eb574 <isp1020_intr_handler+552>:  push   %edx
0xc01eb575 <isp1020_intr_handler+553>:  call   0xc01b4550 <memcpy>
0xc01eb57a <isp1020_intr_handler+558>:  add    $0xc,%esp
0xc01eb57d <isp1020_intr_handler+561>:  cmpb   $0x3,(%ebx)
0xc01eb580 <isp1020_intr_handler+564>:  jne    0xc01eb593 <isp1020_intr_handler+583>
0xc01eb582 <isp1020_intr_handler+566>:  push   %ebx
0xc01eb583 <isp1020_intr_handler+567>:  call   0xc01eb62c <isp1020_return_status>
0xc01eb588 <isp1020_intr_handler+572>:  mov    %eax,0x154(%esi)
0xc01eb58e <isp1020_intr_handler+578>:  add    $0x4,%esp
0xc01eb591 <isp1020_intr_handler+581>:  jmp    0xc01eb59d <isp1020_intr_handler+593>
0xc01eb593 <isp1020_intr_handler+583>:  movl   $0x70000,0x154(%esi)
0xc01eb59d <isp1020_intr_handler+593>:  cmpw   $0x0,0x9e(%esi)
0xc01eb5a5 <isp1020_intr_handler+601>:  je     0xc01eb5b7 <isp1020_intr_handler+619>
0xc01eb5a7 <isp1020_intr_handler+603>:  cmpl   $0x3,0x4c(%esi)
0xc01eb5ab <isp1020_intr_handler+607>:  jne    0xc01eb5d0 <isp1020_intr_handler+644>
0xc01eb5ad <isp1020_intr_handler+609>:  ud2a   
0xc01eb5af <isp1020_intr_handler+611>:  dec    %edx
0xc01eb5b0 <isp1020_intr_handler+612>:  add    %dl,%al
0xc01eb5b2 <isp1020_intr_handler+614>:  aam    $0x28
0xc01eb5b4 <isp1020_intr_handler+616>:  shr    $0x19,%bl
0xc01eb5b7 <isp1020_intr_handler+619>:  cmpl   $0x0,0x64(%esi)
0xc01eb5bb <isp1020_intr_handler+623>:  je     0xc01eb5d0 <isp1020_intr_handler+644>
0xc01eb5bd <isp1020_intr_handler+625>:  cmpl   $0x3,0x4c(%esi)
0xc01eb5c1 <isp1020_intr_handler+629>:  jne    0xc01eb5d0 <isp1020_intr_handler+644>
0xc01eb5c3 <isp1020_intr_handler+631>:  ud2a   
0xc01eb5c5 <isp1020_intr_handler+633>:  and    %eax,(%eax)
0xc01eb5c7 <isp1020_intr_handler+635>:  rcl    %ah
0xc01eb5c9 <isp1020_intr_handler+637>:  sub    %al,%al
0xc01eb5cb <isp1020_intr_handler+639>:  nop    
0xc01eb5cc <isp1020_intr_handler+640>:  lea    0x0(%esi,1),%esi
0xc01eb5d0 <isp1020_intr_handler+644>:  mov    0x1cc(%ebp),%eax
0xc01eb5d6 <isp1020_intr_handler+650>:  mov    %edi,%ecx
0xc01eb5d8 <isp1020_intr_handler+652>:  test   %eax,%eax
0xc01eb5da <isp1020_intr_handler+654>:  je     0xc01eb5e2 <isp1020_intr_handler+662>
0xc01eb5dc <isp1020_intr_handler+656>:  mov    %di,0x7a(%eax)
0xc01eb5e0 <isp1020_intr_handler+660>:  jmp    0xc01eb604 <isp1020_intr_handler+696>
0xc01eb5e2 <isp1020_intr_handler+662>:  mov    0xb4(%ebp),%edx
0xc01eb5e8 <isp1020_intr_handler+668>:  mov    0xc039e538,%eax
0xc01eb5ed <isp1020_intr_handler+673>:  add    $0x7a,%edx
0xc01eb5f0 <isp1020_intr_handler+676>:  test   %eax,%eax
0xc01eb5f2 <isp1020_intr_handler+678>:  je     0xc01eb600 <isp1020_intr_handler+692>
0xc01eb5f4 <isp1020_intr_handler+680>:  mov    %di,(%edx,%eax,1)
0xc01eb5f8 <isp1020_intr_handler+684>:  jmp    0xc01eb604 <isp1020_intr_handler+696>
0xc01eb5fa <isp1020_intr_handler+686>:  lea    0x0(%esi),%esi
0xc01eb600 <isp1020_intr_handler+692>:  mov    %ecx,%eax
0xc01eb602 <isp1020_intr_handler+694>:  out    %ax,(%dx)
0xc01eb604 <isp1020_intr_handler+696>:  push   %esi
0xc01eb605 <isp1020_intr_handler+697>:  mov    0x120(%esi),%eax
0xc01eb60b <isp1020_intr_handler+703>:  call   *%eax
0xc01eb60d <isp1020_intr_handler+705>:  add    $0x4,%esp
0xc01eb610 <isp1020_intr_handler+708>:  cmp    0x10(%esp,1),%edi
0xc01eb614 <isp1020_intr_handler+712>:  jne    0xc01eb518 <isp1020_intr_handler+460>
0xc01eb61a <isp1020_intr_handler+718>:  mov    0x14(%esp,1),%eax
0xc01eb61e <isp1020_intr_handler+722>:  mov    %edi,0xf4(%eax)
0xc01eb624 <isp1020_intr_handler+728>:  pop    %ebx
0xc01eb625 <isp1020_intr_handler+729>:  pop    %esi
0xc01eb626 <isp1020_intr_handler+730>:  pop    %edi
0xc01eb627 <isp1020_intr_handler+731>:  pop    %ebp
0xc01eb628 <isp1020_intr_handler+732>:  pop    %ecx
0xc01eb629 <isp1020_intr_handler+733>:  pop    %edx
0xc01eb62a <isp1020_intr_handler+734>:  ret    


