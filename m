Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTJKPsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJKPsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:48:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:37328 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262671AbTJKPsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:48:11 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 11 Oct 2003 17:52:06 +0200
To: Manfred Spraul <manfred@colorfullife.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3F87F234.1060704@colorfullife.com>
References: <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
 <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_34246187==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_34246187==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 02:06 PM 10/11/2003 +0200, Manfred Spraul wrote:

>I'd increase kstack_depth_to_print to 140. Do not increase it too much, 
>otherwise it will oops due to the misaligned stack.
>Then check the EBP values: They are pushed after the return address. The 
>return addresses are listed in the Call Trace section.
>Example:
>0xc01316aa8 pushes 0xc0349dd6 -> odd.
>0xc0131b6c pushes 0xc0349de6 -> odd.
>
>0xc0131b3e pushes c0349e02 -> odd.
>
>Proper values for EBP are multiples of 4. One you find where the stack got 
>misaligned, disassemble the offending function (or send me the .o file)

Ok, you want do_IRQ assembler, correct?

fwiw, building with gcc-3.3 didn't help, nor did disabling frame pointers.

         -Mike 
--=====================_34246187==_
Content-Type: text/plain; charset="us-ascii"

Unable to handle kernel paging request at virtual address c034a000
 printing eip:
c0134d5a
*pde = 00102027
*pte = 0034a000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0134d5a>]    Not tainted
EFLAGS: 00010002
EIP is at store_stackinfo+0x4e/0x80
eax: 00000000   ebx: c7436f88   ecx: c0301390   edx: c030138c
esi: c0349ffe   edi: 017e0008   ebp: c0349d46   esp: c0349d36
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0348000 task=c02fcbe0)
Stack: c74b59c4 c1173488 c7436000 00000070 c0349d76 c0136aa8 c1173488 c7436000 
       0000006b c72b1bb4 c72b1bb4 c7fecafc 00001000 c0131b6c c7f75f78 00000086 
       c0349d86 c0131b6c c1173488 c7436f38 c0349da2 c0131b3e c7436f38 c1173488 
       c72b1bb4 c72b1bb4 00000001 c0349db6 c014cf76 c7436f38 c7fecafc c7436f2c 
       c0349dc2 c014d158 c72b1bb4 c0349dda c016548a c72b1bb4 c72b1bb4 00000000 
       c04a070c c0349df6 c014d830 c72b1bb4 00010000 00000000 00010000 c72b1bb4 
       c0349e26 c01e45af c72b1bb4 00010000 00000000 c7467f58 00000080 c04a070c 
       00000000 00000000 00000000 00000000 c0349e3a c01e4697 c7467f58 00000001 
       00010000 c0349e62 c01f0b7d c7467f58 00000001 00000080 c04a070c 00000000 
       c04a070c 00000001 00000296 c0349e76 c01f9f68 c04a070c 00000001 00000080 
       c0349e96 c0201df8 c04a070c 00000001 00000080 c0348000 c7af5ef8 50005ef8 
       c0349eba c01f2024 c04a070c c7b2ca48 04000001 00000000 c0201d98 c04a0660 
       00000292 c0349eda c010a423 0000000e c7af5ef8 c0349f0a c0348000 c0348000 
       0000000e c0349f02 c010a70e 0000000e c0349f0a c7b2ca48 00000000 00000010 
       c0348000 c7b2ca48 c0346bc0 000000c0 c0109014 00000000 00000000 00000000 
       00000010 c0348000 000000c0 00005305 9f280000 9f280000 ffffff0e 00008026 
       000000b8 00000216 803600c0 9f8800b8 2a13c034 0060c011 9f880000 8000c034 
       007bc034 007b0000 9c2c0000 0010fffb 
Call Trace:
 [<c0136aa8>] kmem_cache_free+0x218/0x294
 [<c0131b6c>] mempool_free_slab+0x10/0x14
 [<c0131b6c>] mempool_free_slab+0x10/0x14
 [<c0131b3e>] mempool_free+0x7a/0x84
 [<c014cf76>] bio_destructor+0x36/0x4c
 [<c014d158>] bio_put+0x2c/0x30
 [<c016548a>] mpage_end_io_read+0x6a/0x78
 [<c014d830>] bio_endio+0x50/0x5c
 [<c01e45af>] __end_that_request_first+0xef/0x1c0
 [<c01e4697>] end_that_request_first+0x17/0x1c
 [<c01f0b7d>] ide_end_request+0x8d/0x124
 [<c01f9f68>] default_end_request+0x14/0x18
 [<c0201df8>] ide_dma_intr+0x60/0x98
 [<c01f2024>] ide_intr+0x108/0x17c
 [<c0201d98>] ide_dma_intr+0x0/0x98
 [<c010a423>] handle_IRQ_event+0x2b/0x58
 [<c010a70e>] do_IRQ+0x92/0x130
 [<c0109014>] common_interrupt+0x18/0x20


000004ec <do_IRQ>:
 4ec:	55                   	push   %ebp
 4ed:	89 e5                	mov    %esp,%ebp
 4ef:	83 ec 08             	sub    $0x8,%esp
 4f2:	57                   	push   %edi
 4f3:	56                   	push   %esi
 4f4:	53                   	push   %ebx
 4f5:	be 00 e0 ff ff       	mov    $0xffffe000,%esi
 4fa:	0f b6 7d 2c          	movzbl 0x2c(%ebp),%edi
 4fe:	21 e6                	and    %esp,%esi
 500:	89 fb                	mov    %edi,%ebx
 502:	c1 e3 05             	shl    $0x5,%ebx
 505:	8d 83 00 00 00 00    	lea    0x0(%ebx),%eax
 50b:	89 45 fc             	mov    %eax,0xfffffffc(%ebp)
 50e:	81 46 14 00 00 01 00 	addl   $0x10000,0x14(%esi)
 515:	ff 04 bd 1c 00 00 00 	incl   0x1c(,%edi,4)
 51c:	ff 46 14             	incl   0x14(%esi)
 51f:	8b 83 04 00 00 00    	mov    0x4(%ebx),%eax
 525:	57                   	push   %edi
 526:	8b 40 14             	mov    0x14(%eax),%eax
 529:	ff d0                	call   *%eax
 52b:	8b 83 00 00 00 00    	mov    0x0(%ebx),%eax
 531:	83 c4 04             	add    $0x4,%esp
 534:	24 d7                	and    $0xd7,%al
 536:	c7 45 f8 00 00 00 00 	movl   $0x0,0xfffffff8(%ebp)
 53d:	0c 04                	or     $0x4,%al
 53f:	a8 03                	test   $0x3,%al
 541:	75 0d                	jne    550 <do_IRQ+0x64>
 543:	8b 93 08 00 00 00    	mov    0x8(%ebx),%edx
 549:	24 fb                	and    $0xfb,%al
 54b:	89 55 f8             	mov    %edx,0xfffffff8(%ebp)
 54e:	0c 01                	or     $0x1,%al
 550:	89 83 00 00 00 00    	mov    %eax,0x0(%ebx)
 556:	83 7d f8 00          	cmpl   $0x0,0xfffffff8(%ebp)
 55a:	74 60                	je     5bc <do_IRQ+0xd0>
 55c:	89 f3                	mov    %esi,%ebx
 55e:	89 f6                	mov    %esi,%esi
 560:	ff 4b 14             	decl   0x14(%ebx)
 563:	8b 43 08             	mov    0x8(%ebx),%eax
 566:	a8 08                	test   $0x8,%al
 568:	74 06                	je     570 <do_IRQ+0x84>
 56a:	e8 fc ff ff ff       	call   56b <do_IRQ+0x7f>
 56f:	90                   	nop    
 570:	8b 45 f8             	mov    0xfffffff8(%ebp),%eax
 573:	8d 55 08             	lea    0x8(%ebp),%edx
 576:	50                   	push   %eax
 577:	52                   	push   %edx
 578:	57                   	push   %edi
 579:	e8 fc ff ff ff       	call   57a <do_IRQ+0x8e>
 57e:	83 c4 0c             	add    $0xc,%esp
 581:	ff 43 14             	incl   0x14(%ebx)
 584:	83 3d 04 00 00 00 00 	cmpl   $0x0,0x4
 58b:	75 13                	jne    5a0 <do_IRQ+0xb4>
 58d:	50                   	push   %eax
 58e:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
 591:	50                   	push   %eax
 592:	57                   	push   %edi
 593:	e8 e0 fd ff ff       	call   378 <note_interrupt>
 598:	83 c4 0c             	add    $0xc,%esp
 59b:	90                   	nop    
 59c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
 5a0:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
 5a3:	8b 02                	mov    (%edx),%eax
 5a5:	89 c2                	mov    %eax,%edx
 5a7:	a8 04                	test   $0x4,%al
 5a9:	74 0a                	je     5b5 <do_IRQ+0xc9>
 5ab:	83 e2 fb             	and    $0xfffffffb,%edx
 5ae:	8b 45 fc             	mov    0xfffffffc(%ebp),%eax
 5b1:	89 10                	mov    %edx,(%eax)
 5b3:	eb ab                	jmp    560 <do_IRQ+0x74>
 5b5:	24 fe                	and    $0xfe,%al
 5b7:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
 5ba:	89 02                	mov    %eax,(%edx)
 5bc:	8b 55 fc             	mov    0xfffffffc(%ebp),%edx
 5bf:	8b 42 04             	mov    0x4(%edx),%eax
 5c2:	57                   	push   %edi
 5c3:	8b 40 18             	mov    0x18(%eax),%eax
 5c6:	ff d0                	call   *%eax
 5c8:	83 c4 04             	add    $0x4,%esp
 5cb:	bb 00 e0 ff ff       	mov    $0xffffe000,%ebx
 5d0:	21 e3                	and    %esp,%ebx
 5d2:	ff 4b 14             	decl   0x14(%ebx)
 5d5:	8b 43 08             	mov    0x8(%ebx),%eax
 5d8:	a8 08                	test   $0x8,%al
 5da:	74 05                	je     5e1 <do_IRQ+0xf5>
 5dc:	e8 fc ff ff ff       	call   5dd <do_IRQ+0xf1>
 5e1:	8b 43 14             	mov    0x14(%ebx),%eax
 5e4:	05 01 00 ff ff       	add    $0xffff0001,%eax
 5e9:	89 43 14             	mov    %eax,0x14(%ebx)
 5ec:	a9 00 ff ff 00       	test   $0xffff00,%eax
 5f1:	75 0e                	jne    601 <do_IRQ+0x115>
 5f3:	83 3d 00 00 00 00 00 	cmpl   $0x0,0x0
 5fa:	74 05                	je     601 <do_IRQ+0x115>
 5fc:	e8 fc ff ff ff       	call   5fd <do_IRQ+0x111>
 601:	b8 00 e0 ff ff       	mov    $0xffffe000,%eax
 606:	21 e0                	and    %esp,%eax
 608:	ff 48 14             	decl   0x14(%eax)
 60b:	b8 01 00 00 00       	mov    $0x1,%eax
 610:	8d 65 ec             	lea    0xffffffec(%ebp),%esp
 613:	5b                   	pop    %ebx
 614:	5e                   	pop    %esi
 615:	5f                   	pop    %edi
 616:	89 ec                	mov    %ebp,%esp
 618:	5d                   	pop    %ebp
 619:	c3                   	ret    

--=====================_34246187==_--

