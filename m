Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbTHYXLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbTHYXLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 19:11:22 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:37176 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262401AbTHYXLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 19:11:15 -0400
Date: Tue, 26 Aug 2003 01:11:13 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
       Bartlomiej Solarz-Niesluchowski <solarz@wsisiz.edu.pl>
Subject: linux-2.4.22 Oops on ATM PCA-200EPC
Message-ID: <Pine.LNX.4.53.0308260104580.17995@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have always used vanilla kernel with very old patch for ATM
(name: linux-2.3.99-pre6-fore200e-0.2f.patch) It worked well -
trouble-free. 
I have just tried vanilla 2.4.22, here is oops. ATM doesn't work :(

ksymoops 2.4.5 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /lib/modules/2.4.22/System.map (specified)

Aug 26 00:47:54 voices kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Aug 26 00:47:54 voices kernel: c0263127
Aug 26 00:47:54 voices kernel: *pde = 00000000
Aug 26 00:47:54 voices kernel: Oops: 0002
Aug 26 00:47:54 voices kernel: CPU:    0
Aug 26 00:47:54 voices kernel: EIP:    0010:[<c0263127>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 26 00:47:54 voices kernel: EFLAGS: 00010286
Aug 26 00:47:54 voices kernel: eax: 00000000   ebx: ffffffff   ecx: c02c7c14   edx: ffffff9e
Aug 26 00:47:54 voices kernel: esi: f78812b4   edi: 000061e1   ebp: f6f27800   esp: f78e5f04
Aug 26 00:47:54 voices kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 00:47:54 voices kernel: Process atmarpd (pid: 8093, stackpage=f78e5000)
Aug 26 00:47:54 voices kernel: Stack: f6f27800 f7b2a880 f706b680 400f7020 00000000 00000003 f6fb7a80 f7b2a89c 
Aug 26 00:47:54 voices kernel:        00000000 005d3339 f78812b4 00030002 f7a3e780 f7b7c005 00000003 0028f3c6 
Aug 26 00:47:54 voices kernel:        f78e5f24 00000007 000036a9 00000000 00000000 00000002 f78e4000 000061e1 
Aug 26 00:47:54 voices kernel: Call Trace:    [<c0260f83>] [<c01fac40>] [<c014f835>] [<c010770f>]
Aug 26 00:47:54 voices kernel: Code: f0 ff 48 10 a1 74 0f 36 c0 8b 40 18 83 48 14 08 85 d2 0f 85 


>>EIP; c0263127 <atm_ioctl+927/c90>   <=====

>>ebx; ffffffff <END_OF_CODE+7647f28/????>
>>ecx; c02c7c14 <atm_clip_ops_mutex+0/14>
>>edx; ffffff9e <END_OF_CODE+7647ec7/????>
>>esi; f78812b4 <_end+3752031c/3858a0c8>
>>edi; 000061e1 Before first symbol
>>ebp; f6f27800 <_end+36bc6868/3858a0c8>
>>esp; f78e5f04 <_end+37584f6c/3858a0c8>

Trace; c0260f83 <__lock_svc_proto_ioctl+43/80>
Trace; c01fac40 <sock_ioctl+40/80>
Trace; c014f835 <sys_ioctl+f5/2b0>
Trace; c010770f <system_call+33/38>

Code;  c0263127 <atm_ioctl+927/c90>
00000000 <_EIP>:
Code;  c0263127 <atm_ioctl+927/c90>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c026312b <atm_ioctl+92b/c90>
   4:   a1 74 0f 36 c0            mov    0xc0360f74,%eax
Code;  c0263130 <atm_ioctl+930/c90>
   9:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c0263133 <atm_ioctl+933/c90>
   c:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c0263137 <atm_ioctl+937/c90>
  10:   85 d2                     test   %edx,%edx
Code;  c0263139 <atm_ioctl+939/c90>
  12:   0f 85 00 00 00 00         jne    18 <_EIP+0x18>


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
