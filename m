Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWI3Hwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWI3Hwd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 03:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWI3Hwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 03:52:33 -0400
Received: from smtp11.poczta.interia.pl ([80.48.65.11]:46015 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1751116AbWI3Hwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 03:52:32 -0400
Message-ID: <451E232A.9000303@interia.pl>
Date: Sat, 30 Sep 2006 09:56:26 +0200
From: =?UTF-8?B?QXJrYWRpdXN6IEphxYJvd2llYw==?= <ajalowiec@interia.pl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>, ornati@fastwebnet.it,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users[ PROBLEM: Kernel 2.6.x freeze
References: <Pine.LNX.4.44L0.0609291717460.26116-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609291717460.26116-100000@netrider.rowland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: 68502acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
>
> Equally important, which version of gcc was used to compile the kernel?
>   
My gcc version is:

gcc (GCC) 3.3.6

> Arkadiusz, could you please run "objdump -d drivers/usb/host/uhci-hcd.o" 
> in your kernel source directory, and post the portion of the output for 
> the uhci_giveback_urb routine? 
00001483 <uhci_giveback_urb>:
    1483:    55                       push   %ebp
    1484:    57                       push   %edi
    1485:    89 d7                    mov    %edx,%edi
    1487:    56                       push   %esi
    1488:    89 ce                    mov    %ecx,%esi
    148a:    53                       push   %ebx
    148b:    83 ec 1c                 sub    $0x1c,%esp
    148e:    89 44 24 18              mov    %eax,0x18(%esp)
    1492:    83 7a 48 01              cmpl   $0x1,0x48(%edx)
    1496:    8b 69 04                 mov    0x4(%ecx),%ebp
    1499:    75 27                    jne    14c2 <uhci_giveback_urb+0x3f>
    149b:    8d 42 18                 lea    0x18(%edx),%eax
    149e:    8b 55 04                 mov    0x4(%ebp),%edx
    14a1:    39 c2                    cmp    %eax,%edx
    14a3:    75 1d                    jne    14c2 <uhci_giveback_urb+0x3f>
    14a5:    8b 45 00                 mov    0x0(%ebp),%eax
    14a8:    39 d0                    cmp    %edx,%eax
    14aa:    74 16                    je     14c2 <uhci_giveback_urb+0x3f>
    14ac:    8b 40 08                 mov    0x8(%eax),%eax
    14af:    8d 50 5c                 lea    0x5c(%eax),%edx
    14b2:    89 57 2c                 mov    %edx,0x2c(%edi)
    14b5:    8b 40 44                 mov    0x44(%eax),%eax
    14b8:    c7 47 40 00 00 00 00     movl   $0x0,0x40(%edi)
    14bf:    89 47 3c                 mov    %eax,0x3c(%edi)
    14c2:    8b 45 00                 mov    0x0(%ebp),%eax
    14c5:    8b 55 04                 mov    0x4(%ebp),%edx
    14c8:    89 02                    mov    %eax,(%edx)
    14ca:    89 50 04                 mov    %edx,0x4(%eax)
    14cd:    89 6d 00                 mov    %ebp,0x0(%ebp)
    14d0:    8d 47 18                 lea    0x18(%edi),%eax
    14d3:    89 6d 04                 mov    %ebp,0x4(%ebp)
    14d6:    39 47 18                 cmp    %eax,0x18(%edi)
    14d9:    75 4b                    jne    1526 <uhci_giveback_urb+0xa3>
    14db:    0f b6 47 50              movzbl 0x50(%edi),%eax
    14df:    a8 02                    test   $0x2,%al
    14e1:    88 44 24 08              mov    %al,0x8(%esp)
    14e5:    74 3f                    je     1526 <uhci_giveback_urb+0xa3>
    14e7:    0f b6 46 20              movzbl 0x20(%esi),%eax
    14eb:    8b 4e 20                 mov    0x20(%esi),%ecx
    14ee:    ba fe ff ff ff           mov    $0xfffffffe,%edx
    14f3:    24 80                    and    $0x80,%al
    14f5:    0f 94 c3                 sete   %bl
    14f8:    c1 e9 0f                 shr    $0xf,%ecx
    14fb:    0f b6 db                 movzbl %bl,%ebx
    14fe:    83 e1 0f                 and    $0xf,%ecx
    1501:    89 1c 24                 mov    %ebx,(%esp)
    1504:    89 d8                    mov    %ebx,%eax
    1506:    d3 c2                    rol    %cl,%edx
    1508:    8b 5e 1c                 mov    0x1c(%esi),%ebx
    150b:    23 54 83 24              and    0x24(%ebx,%eax,4),%edx
    150f:    0f b6 44 24 08           movzbl 0x8(%esp),%eax
    1514:    83 e0 01                 and    $0x1,%eax
    1517:    d3 e0                    shl    %cl,%eax
    1519:    09 c2                    or     %eax,%edx
    151b:    8b 04 24                 mov    (%esp),%eax
    151e:    89 54 83 24              mov    %edx,0x24(%ebx,%eax,4)
    1522:    80 67 50 fd              andb   $0xfd,0x50(%edi)
    1526:    8b 44 24 18              mov    0x18(%esp),%eax
    152a:    89 ea                    mov    %ebp,%edx
    152c:    e8 fe f1 ff ff           call   72f <uhci_free_urb_priv>
    1531:    8b 47 48                 mov    0x48(%edi),%eax
    1534:    83 f8 01                 cmp    $0x1,%eax
    1537:    74 07                    je     1540 <uhci_giveback_urb+0xbd>
    1539:    83 f8 03                 cmp    $0x3,%eax
    153c:    74 12                    je     1550 <uhci_giveback_urb+0xcd>
    153e:    eb 33                    jmp    1573 <uhci_giveback_urb+0xf0>
    1540:    83 7e 08 00              cmpl   $0x0,0x8(%esi)
    1544:    74 2d                    je     1573 <uhci_giveback_urb+0xf0>
    1546:    8b 46 1c                 mov    0x1c(%esi),%eax
    1549:    b9 01 00 00 00           mov    $0x1,%ecx
    154e:    eb 13                    jmp    1563 <uhci_giveback_urb+0xe0>
    1550:    8d 47 18                 lea    0x18(%edi),%eax
    1553:    39 47 18                 cmp    %eax,0x18(%edi)
    1556:    75 14                    jne    156c <uhci_giveback_urb+0xe9>
    1558:    83 7e 08 00              cmpl   $0x0,0x8(%esi)
    155c:    74 0e                    je     156c <uhci_giveback_urb+0xe9>
    155e:    8b 46 1c                 mov    0x1c(%esi),%eax
    1561:    31 c9                    xor    %ecx,%ecx
    1563:    89 f2                    mov    %esi,%edx
    1565:    e8 fc ff ff ff           call   1566 <uhci_giveback_urb+0xe3>
    156a:    eb 07                    jmp    1573 <uhci_giveback_urb+0xf0>
    156c:    c7 46 08 00 00 00 00     movl   $0x0,0x8(%esi)
    1573:    8b 44 24 18              mov    0x18(%esp),%eax
    1577:    8b 4c 24 30              mov    0x30(%esp),%ecx
    157b:    89 f2                    mov    %esi,%edx
    157d:    2d d0 00 00 00           sub    $0xd0,%eax
    1582:    e8 fc ff ff ff           call   1583 <uhci_giveback_urb+0x100>
    1587:    8d 47 18                 lea    0x18(%edi),%eax
    158a:    39 47 18                 cmp    %eax,0x18(%edi)
    158d:    75 12                    jne    15a1 <uhci_giveback_urb+0x11e>
    158f:    89 fa                    mov    %edi,%edx
    1591:    8b 44 24 18              mov    0x18(%esp),%eax
    1595:    e8 4d f0 ff ff           call   5e7 <uhci_unlink_qh>
    159a:    c7 47 38 00 00 00 00     movl   $0x0,0x38(%edi)
    15a1:    83 c4 1c                 add    $0x1c,%esp
    15a4:    5b                       pop    %ebx
    15a5:    5e                       pop    %esi
    15a6:    5f                       pop    %edi
    15a7:    5d                       pop    %ebp
    15a8:    c3                       ret



----------------------------------------------------------------------
Dziewczyny Paryza >>> http://link.interia.pl/f19a3 

