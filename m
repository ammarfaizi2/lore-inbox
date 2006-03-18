Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWCRWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWCRWJN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWCRWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:09:13 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:52933 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751081AbWCRWJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:09:11 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Date: Sat, 18 Mar 2006 17:09:12 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com,
       Dave Jones <davej@redhat.com>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603181709.12175.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 16:40, Linus Torvalds wrote:
> Anyway, I _think_ it's this one:
>
>                 for_each_online_cpu(j) {
>                         dbs_info = &per_cpu(cpu_dbs_info, j);
>                         requested_freq[j] = dbs_info->cur_policy->cur;
>                 }
Here is the disassembly of cpufrequency_conservative.o:dbs_check_cpu() from my 
setup, if it is of any help.

000004b0 <dbs_check_cpu>:
 4b0:   55                      push   %ebp
 4b1:   bd 00 00 00 00          mov    $0x0,%ebp
 4b6:   89 e8                   mov    %ebp,%eax
 4b8:   57                      push   %edi
 4b9:   56                      push   %esi
 4ba:   53                      push   %ebx
 4bb:   83 ec 10                sub    $0x10,%esp
 4be:   8b 54 24 24             mov    0x24(%esp),%edx
 4c2:   8b 0c 95 00 00 00 00    mov    0x0(,%edx,4),%ecx
 4c9:   01 c8                   add    %ecx,%eax
 4cb:   8b 50 0c                mov    0xc(%eax),%edx
 4ce:   85 d2                   test   %edx,%edx
 4d0:   0f 84 ba 01 00 00       je     690 <dbs_check_cpu+0x1e0>
 4d6:   66 83 3d 10 00 00 00    cmpw   $0x0,0x10
 4dd:   00
 4de:   8b 00                   mov    (%eax),%eax
 4e0:   89 44 24 0c             mov    %eax,0xc(%esp)
 4e4:   0f 84 ae 01 00 00       je     698 <dbs_check_cpu+0x1e8>
 4ea:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 4ee:   bf ff ff ff ff          mov    $0xffffffff,%edi
 4f3:   8b 01                   mov    (%ecx),%eax
 4f5:   85 c0                   test   %eax,%eax
 4f7:   0f 85 23 02 00 00       jne    720 <dbs_check_cpu+0x270>
 4fd:   b8 20 00 00 00          mov    $0x20,%eax
 502:   eb 52                   jmp    556 <dbs_check_cpu+0xa6>
 504:   8b 14 9d 00 00 00 00    mov    0x0(,%ebx,4),%edx
 50b:   89 e8                   mov    %ebp,%eax
 50d:   8b 0d 60 00 00 00       mov    0x60,%ecx
 513:   8d 34 02                lea    (%edx,%eax,1),%esi
 516:   b8 00 00 00 00          mov    $0x0,%eax
 51b:   8d 04 02                lea    (%edx,%eax,1),%eax
 51e:   8b 50 30                mov    0x30(%eax),%edx
 521:   03 50 28                add    0x28(%eax),%edx
 524:   85 c9                   test   %ecx,%ecx
 526:   74 03                   je     52b <dbs_check_cpu+0x7b>
 528:   03 50 08                add    0x8(%eax),%edx
 52b:   8b 4e 04                mov    0x4(%esi),%ecx
 52e:   89 d0                   mov    %edx,%eax
 530:   89 56 04                mov    %edx,0x4(%esi)
 533:   29 c8                   sub    %ecx,%eax
 535:   39 f8                   cmp    %edi,%eax
 537:   0f 42 f8                cmovb  %eax,%edi
 53a:   8d 43 01                lea    0x1(%ebx),%eax
 53d:   89 44 24 08             mov    %eax,0x8(%esp)
541:   b8 02 00 00 00          mov    $0x2,%eax
 546:   89 44 24 04             mov    %eax,0x4(%esp)
 54a:   8b 44 24 0c             mov    0xc(%esp),%eax
 54e:   89 04 24                mov    %eax,(%esp)
 551:   e8 fc ff ff ff          call   552 <dbs_check_cpu+0xa2>
 556:   83 f8 03                cmp    $0x3,%eax
 559:   bb 02 00 00 00          mov    $0x2,%ebx
 55e:   0f 4c d8                cmovl  %eax,%ebx
 561:   83 fb 01                cmp    $0x1,%ebx
 564:   76 9e                   jbe    504 <dbs_check_cpu+0x54>
 566:   8d 04 bf                lea    (%edi,%edi,4),%eax
 569:   8b 35 50 00 00 00       mov    0x50,%esi
 56f:   b9 64 00 00 00          mov    $0x64,%ecx
 574:   8d 04 80                lea    (%eax,%eax,4),%eax
 577:   ba fe ff ff 7f          mov    $0x7ffffffe,%edx
 57c:   8d 1c 85 00 00 00 00    lea    0x0(,%eax,4),%ebx
 583:   a1 58 00 00 00          mov    0x58,%eax
 588:   29 c1                   sub    %eax,%ecx
 58a:   81 fe c0 e0 ff ff       cmp    $0xffffe0c0,%esi
 590:   77 10                   ja     5a2 <dbs_check_cpu+0xf2>
 592:   8d 96 9f 0f 00 00       lea    0xf9f(%esi),%edx
 598:   b8 d3 4d 62 10          mov    $0x10624dd3,%eax
 59d:   f7 e2                   mul    %edx
 59f:   c1 ea 08                shr    $0x8,%edx
 5a2:   0f af ca                imul   %edx,%ecx
 5a5:   39 cb                   cmp    %ecx,%ebx
 5a7:   0f 83 7b 01 00 00       jae    728 <dbs_check_cpu+0x278>
 5ad:   8b 54 24 24             mov    0x24(%esp),%edx
 5b1:   31 c0                   xor    %eax,%eax
 5b3:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 5b7:   89 04 95 00 00 00 00    mov    %eax,0x0(,%edx,4)
 5be:   8b 01                   mov    (%ecx),%eax
 5c0:   85 c0                   test   %eax,%eax
 5c2:   0f 84 ca 02 00 00       je     892 <dbs_check_cpu+0x3e2>
 5c8:   0f bc c0                bsf    %eax,%eax
 5cb:   83 f8 03                cmp    $0x3,%eax
 5ce:   bb 02 00 00 00          mov    $0x2,%ebx
 5d3:   0f 4c d8                cmovl  %eax,%ebx
 5d6:   83 fb 01                cmp    $0x1,%ebx
 5d9:   77 40                   ja     61b <dbs_check_cpu+0x16b>
 5db:   89 ee                   mov    %ebp,%esi
 5dd:   8d 76 00                lea    0x0(%esi),%esi
 5e0:   8b 14 9d 00 00 00 00    mov    0x0(,%ebx,4),%edx
 5e7:   01 f2                   add    %esi,%edx
5e9:   8b 42 04                mov    0x4(%edx),%eax
 5ec:   89 42 08                mov    %eax,0x8(%edx)
 5ef:   8d 43 01                lea    0x1(%ebx),%eax
 5f2:   bb 02 00 00 00          mov    $0x2,%ebx
 5f7:   89 44 24 08             mov    %eax,0x8(%esp)
 5fb:   b8 02 00 00 00          mov    $0x2,%eax
 600:   89 44 24 04             mov    %eax,0x4(%esp)
 604:   8b 44 24 0c             mov    0xc(%esp),%eax
 608:   89 04 24                mov    %eax,(%esp)
 60b:   e8 fc ff ff ff          call   60c <dbs_check_cpu+0x15c>
 610:   83 f8 03                cmp    $0x3,%eax
 613:   0f 4c d8                cmovl  %eax,%ebx
 616:   83 fb 01                cmp    $0x1,%ebx
 619:   76 c5                   jbe    5e0 <dbs_check_cpu+0x130>
 61b:   8b 54 24 24             mov    0x24(%esp),%edx
 61f:   8b 0c 95 08 00 00 00    mov    0x8(,%edx,4),%ecx
 626:   8b 54 24 0c             mov    0xc(%esp),%edx
 62a:   8b 42 18                mov    0x18(%edx),%eax
 62d:   39 c1                   cmp    %eax,%ecx
 62f:   74 5f                   je     690 <dbs_check_cpu+0x1e0>
 631:   8b 15 64 00 00 00       mov    0x64,%edx
 637:   0f af d0                imul   %eax,%edx
 63a:   b8 1f 85 eb 51          mov    $0x51eb851f,%eax
 63f:   f7 e2                   mul    %edx
 641:   b8 05 00 00 00          mov    $0x5,%eax
 646:   c1 ea 05                shr    $0x5,%edx
 649:   0f 44 d0                cmove  %eax,%edx
 64c:   8d 04 11                lea    (%ecx,%edx,1),%eax
 64f:   8b 4c 24 24             mov    0x24(%esp),%ecx
 653:   89 04 8d 08 00 00 00    mov    %eax,0x8(,%ecx,4)
 65a:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 65e:   8b 51 18                mov    0x18(%ecx),%edx
 661:   39 d0                   cmp    %edx,%eax
 663:   76 0d                   jbe    672 <dbs_check_cpu+0x1c2>
 665:   89 d0                   mov    %edx,%eax
 667:   8b 54 24 24             mov    0x24(%esp),%edx
 66b:   89 04 95 08 00 00 00    mov    %eax,0x8(,%edx,4)
 672:   89 44 24 04             mov    %eax,0x4(%esp)
 676:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 67a:   ba 01 00 00 00          mov    $0x1,%edx
 67f:   89 54 24 08             mov    %edx,0x8(%esp)
 683:   89 0c 24                mov    %ecx,(%esp)
 686:   e8 fc ff ff ff          call   687 <dbs_check_cpu+0x1d7>
 68b:   90                      nop
68c:   8d 74 26 00             lea    0x0(%esi),%esi
 690:   83 c4 10                add    $0x10,%esp
 693:   5b                      pop    %ebx
 694:   5e                      pop    %esi
 695:   5f                      pop    %edi
 696:   5d                      pop    %ebp
 697:   c3                      ret
 698:   a1 00 00 00 00          mov    0x0,%eax
 69d:   85 c0                   test   %eax,%eax
 69f:   0f 84 e3 01 00 00       je     888 <dbs_check_cpu+0x3d8>
 6a5:   0f bc c0                bsf    %eax,%eax
 6a8:   83 f8 03                cmp    $0x3,%eax
 6ab:   bb 02 00 00 00          mov    $0x2,%ebx
 6b0:   0f 4c d8                cmovl  %eax,%ebx
 6b3:   83 fb 01                cmp    $0x1,%ebx
 6b6:   77 49                   ja     701 <dbs_check_cpu+0x251>
 6b8:   89 ee                   mov    %ebp,%esi
 6ba:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
 6c0:   8b 04 9d 00 00 00 00    mov    0x0(,%ebx,4),%eax
 6c7:   bf 02 00 00 00          mov    $0x2,%edi
 6cc:   01 f0                   add    %esi,%eax
 6ce:   8b 00                   mov    (%eax),%eax
 6d0:   8b 40 1c                mov    0x1c(%eax),%eax 
 6d3:   89 7c 24 04             mov    %edi,0x4(%esp)
 6d7:   c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 6de:   89 04 9d 08 00 00 00    mov    %eax,0x8(,%ebx,4)
 6e5:   8d 43 01                lea    0x1(%ebx),%eax
 6e8:   bb 02 00 00 00          mov    $0x2,%ebx
 6ed:   89 44 24 08             mov    %eax,0x8(%esp)
 6f1:   e8 fc ff ff ff          call   6f2 <dbs_check_cpu+0x242>
 6f6:   83 f8 03                cmp    $0x3,%eax
 6f9:   0f 4c d8                cmovl  %eax,%ebx
 6fc:   83 fb 01                cmp    $0x1,%ebx
 6ff:   76 bf                   jbe    6c0 <dbs_check_cpu+0x210>
 701:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 705:   bb 01 00 00 00          mov    $0x1,%ebx
 70a:   bf ff ff ff ff          mov    $0xffffffff,%edi
 70f:   66 89 1d 10 00 00 00    mov    %bx,0x10
 716:   8b 01                   mov    (%ecx),%eax
 718:   85 c0                   test   %eax,%eax
 71a:   0f 84 dd fd ff ff       je     4fd <dbs_check_cpu+0x4d>
 720:   0f bc c0                bsf    %eax,%eax
 723:   e9 2e fe ff ff          jmp    556 <dbs_check_cpu+0xa6>
 728:   8b 54 24 24             mov    0x24(%esp),%edx
 72c:   8b 04 95 00 00 00 00    mov    0x0(,%edx,4),%eax
733:   40                      inc    %eax
 734:   89 04 95 00 00 00 00    mov    %eax,0x0(,%edx,4)
 73b:   8b 15 54 00 00 00       mov    0x54,%edx
 741:   39 d0                   cmp    %edx,%eax
 743:   0f 82 47 ff ff ff       jb     690 <dbs_check_cpu+0x1e0>
 749:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 74d:   bf ff ff ff ff          mov    $0xffffffff,%edi
 752:   8b 01                   mov    (%ecx),%eax
 754:   85 c0                   test   %eax,%eax
 756:   0f 85 40 01 00 00       jne    89c <dbs_check_cpu+0x3ec>
 75c:   b8 20 00 00 00          mov    $0x20,%eax
 761:   83 f8 03                cmp    $0x3,%eax
 764:   bb 02 00 00 00          mov    $0x2,%ebx
 769:   0f 4c d8                cmovl  %eax,%ebx
 76c:   83 fb 01                cmp    $0x1,%ebx
 76f:   77 64                   ja     7d5 <dbs_check_cpu+0x325>
 771:   89 ee                   mov    %ebp,%esi
 773:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
 779:   8d bc 27 00 00 00 00    lea    0x0(%edi),%edi
 780:   8b 04 9d 00 00 00 00    mov    0x0(,%ebx,4),%eax
 787:   01 f0                   add    %esi,%eax
 789:   8b 50 04                mov    0x4(%eax),%edx
 78c:   8b 68 08                mov    0x8(%eax),%ebp
 78f:   89 d1                   mov    %edx,%ecx
 791:   29 e9                   sub    %ebp,%ecx
 793:   89 50 08                mov    %edx,0x8(%eax)
 796:   8d 43 01                lea    0x1(%ebx),%eax
 799:   39 f9                   cmp    %edi,%ecx
 79b:   89 44 24 08             mov    %eax,0x8(%esp)
 79f:   8b 44 24 0c             mov    0xc(%esp),%eax
 7a3:   bd 02 00 00 00          mov    $0x2,%ebp
 7a8:   0f 42 f9                cmovb  %ecx,%edi
 7ab:   89 6c 24 04             mov    %ebp,0x4(%esp)
 7af:   89 04 24                mov    %eax,(%esp)
 7b2:   e8 fc ff ff ff          call   7b3 <dbs_check_cpu+0x303>
 7b7:   83 f8 03                cmp    $0x3,%eax
 7ba:   ba 02 00 00 00          mov    $0x2,%edx
7bf:   0f 4d c2                cmovge %edx,%eax
 7c2:   83 f8 01                cmp    $0x1,%eax
 7c5:   89 c3                   mov    %eax,%ebx
 7c7:   76 b7                   jbe    780 <dbs_check_cpu+0x2d0>
 7c9:   8b 35 50 00 00 00       mov    0x50,%esi
 7cf:   8b 15 54 00 00 00       mov    0x54,%edx
 7d5:   8d 04 bf                lea    (%edi,%edi,4),%eax
 7d8:   8b 4c 24 24             mov    0x24(%esp),%ecx
 7dc:   8d 04 80                lea    (%eax,%eax,4),%eax
 7df:   8d 1c 85 00 00 00 00    lea    0x0(,%eax,4),%ebx
 7e6:   89 f0                   mov    %esi,%eax
 7e8:   0f af c2                imul   %edx,%eax
 7eb:   8b 35 5c 00 00 00       mov    0x5c,%esi
 7f1:   31 ff                   xor    %edi,%edi
 7f3:   ba fe ff ff 7f          mov    $0x7ffffffe,%edx
 7f8:   89 3c 8d 00 00 00 00    mov    %edi,0x0(,%ecx,4)
 7ff:   b9 64 00 00 00          mov    $0x64,%ecx
 804:   29 f1                   sub    %esi,%ecx
 806:   3d c0 e0 ff ff          cmp    $0xffffe0c0,%eax
 80b:   77 10                   ja     81d <dbs_check_cpu+0x36d>
 80d:   8d 90 9f 0f 00 00       lea    0xf9f(%eax),%edx
 813:   b8 d3 4d 62 10          mov    $0x10624dd3,%eax
 818:   f7 e2                   mul    %edx
 81a:   c1 ea 08                shr    $0x8,%edx
 81d:   0f af ca                imul   %edx,%ecx
 820:   39 cb                   cmp    %ecx,%ebx
 822:   0f 86 68 fe ff ff       jbe    690 <dbs_check_cpu+0x1e0>
 828:   8b 44 24 24             mov    0x24(%esp),%eax
 82c:   8b 54 24 0c             mov    0xc(%esp),%edx
 830:   8b 0c 85 08 00 00 00    mov    0x8(,%eax,4),%ecx
 837:   3b 4a 14                cmp    0x14(%edx),%ecx
 83a:   0f 84 50 fe ff ff       je     690 <dbs_check_cpu+0x1e0>
 840:   a1 64 00 00 00          mov    0x64,%eax
 845:   85 c0                   test   %eax,%eax
 847:   0f 84 43 fe ff ff       je     690 <dbs_check_cpu+0x1e0>
 84d:   8b 5a 18                mov    0x18(%edx),%ebx
 850:   ba 1f 85 eb 51          mov    $0x51eb851f,%edx
 855:   0f af c3                imul   %ebx,%eax
 858:   f7 e2                   mul    %edx
 85a:   b8 05 00 00 00          mov    $0x5,%eax
 85f:   c1 ea 05                shr    $0x5,%edx
 862:   0f 44 d0                cmove  %eax,%edx
 865:   89 c8                   mov    %ecx,%eax
 867:   8b 4c 24 24             mov    0x24(%esp),%ecx
 86b:   29 d0                   sub    %edx,%eax
 86d:   89 04 8d 08 00 00 00    mov    %eax,0x8(,%ecx,4)
 874:   8b 4c 24 0c             mov    0xc(%esp),%ecx
 878:   8b 51 14                mov    0x14(%ecx),%edx
 87b:   39 d0                   cmp    %edx,%eax
 87d:   0f 83 ef fd ff ff       jae    672 <dbs_check_cpu+0x1c2>
 883:   e9 dd fd ff ff          jmp    665 <dbs_check_cpu+0x1b5>
 888:   b8 20 00 00 00          mov    $0x20,%eax
 88d:   e9 16 fe ff ff          jmp    6a8 <dbs_check_cpu+0x1f8>
 892:   b8 20 00 00 00          mov    $0x20,%eax
 897:   e9 2f fd ff ff          jmp    5cb <dbs_check_cpu+0x11b>
 89c:   0f bc c0                bsf    %eax,%eax
 89f:   e9 bd fe ff ff          jmp    761 <dbs_check_cpu+0x2b1>
 8a4:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
 8aa:   8d bf 00 00 00 00       lea    0x0(%edi),%edi
