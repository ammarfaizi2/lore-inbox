Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277000AbRJ0UJW>; Sat, 27 Oct 2001 16:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRJ0UJN>; Sat, 27 Oct 2001 16:09:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277000AbRJ0UJC>; Sat, 27 Oct 2001 16:09:02 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [oops] linux-2.4.14-pre2 - __remove_from_queues+14/28
Date: Sat, 27 Oct 2001 20:07:43 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rf46f$3ig$1@penguin.transmeta.com>
In-Reply-To: <20011027144624.A11364@lnuxlab.ath.cx>
X-Trace: palladium.transmeta.com 1004213363 3826 127.0.0.1 (27 Oct 2001 20:09:23 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Oct 2001 20:09:23 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011027144624.A11364@lnuxlab.ath.cx>,
khromy  <khromy@lnuxlab.ath.cx> wrote:
>If you need more info, let me know.

Have you had any memory trouble or similar with this machine?

It looks very much like a single-bit error:

>Unable to handle kernel paging request at virtual address 00100000
>c012e694
>*pde = 00000000
>Oops: 0002
>CPU:    0
>EIP:    0010:[<c012e694>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>EFLAGS: 00010246
>eax: 00000000   ebx: c3135920   ecx: c3135920   edx: 00100000
>esi: c3135a40   edi: c3135a40   ebp: c10c4bc0   esp: c1311f2c

Here "edx" appears to be bh->b_pprev pointer, which can quite validly be
NULL for a non-hashed page.

So a value of all zeroes, or a kernel pointer value (ie 0xC.....) would
be valid, but 0x00100000 is not.

It doesn't have to be bad memory, of course - it could easily be a wild
pointer and a bit set operation.. But.

		Linus
