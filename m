Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310506AbSCGUZ3>; Thu, 7 Mar 2002 15:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310507AbSCGUZV>; Thu, 7 Mar 2002 15:25:21 -0500
Received: from fungus.teststation.com ([212.32.186.211]:23822 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S310506AbSCGUZM>; Thu, 7 Mar 2002 15:25:12 -0500
Date: Thu, 7 Mar 2002 21:24:24 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Stephan Maciej <stephan@maciej.muc.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: filldir64 oopses on smbfs
In-Reply-To: <Pine.LNX.4.33.0203061734540.808@maciej.muc.de>
Message-ID: <Pine.LNX.4.33.0203072121090.1448-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Stephan Maciej wrote:

> Unable to handle kernel paging request at virtual address d0000000
>  printing eip:
> d11d5c13
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<d11d5c13>]    Not tainted
> EFLAGS: 00210282
> eax: 58ea5128   ebx: 2a037f58   ecx: fa6373fd   edx: 782edd08
> esi: d0000000   edi: ca1f5e30   ebp: ca1f5ec8   esp: ca1f5de0
> ds: 0018   es: 0018   ss: 0018
> Process kdeinit (pid: 1603, stackpage=ca1f5000)
> Stack: c0146a10 ca1f5e98 d11e4502 00000001 00000000 00000000 00000000 ce7f5180 
>        c35fe6c0 00000000 00028955 c4fe2f40 00000000 00000000 c9f16000 0000002f 
>        00000000 00000000 00000001 00000031 d11d43c5 c906cf40 ca1f5fb0 c0146a10 
> Call Trace: [filldir64+176/368] [<d11d43c5>] [filldir64+176/368] 
> [filldir64+176/368] [<d11d445c>] 
>    [filldir64+176/368] [<d11d5343>] [filldir64+176/368] 
> [dcache_readdir+94/288] [filldir64+176/368] [sys_getdents64+255/259] 
>    [filldir64+176/368] [send_sigio_to_task+160/208] [system_call+51/56] 
> 
> Code: 0f b6 06 46 89 c2 c1 e2 04 01 da c1 e8 04 01 c2 8d 04 92 8d 

You are supposed to decode these with ksymoops ...

However "d0000000" and 2.4.18 can only be the nls bug introduced by
someone late in the 2.4.18 series. Please try this patch:

http://www.hojdpunkten.ac.se/054/samba/00-smbfs-2.4.18-codepage.patch.gz

/Urban

