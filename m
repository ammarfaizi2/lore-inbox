Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277487AbRJJW01>; Wed, 10 Oct 2001 18:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277493AbRJJW0R>; Wed, 10 Oct 2001 18:26:17 -0400
Received: from quark.didntduck.org ([216.43.55.190]:57092 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S277487AbRJJWZ6>; Wed, 10 Oct 2001 18:25:58 -0400
Message-ID: <3BC4CB03.BE1FC37@didntduck.org>
Date: Wed, 10 Oct 2001 18:26:11 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Matthews <bmatthews@redhat.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 oops
In-Reply-To: <3BC4B34C.BB45D829@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Matthews wrote:
> 
> Linus,
> 
> I've received an oops while booting 2.4.11 on two different SMP
> machines.  The kernel was SMP, HIGHMEM=64G with sym53c8xx, 3c59x,
> eepro100, aic7xx and megaraid drivers statically linked.
>
> eax: 37e8ace4   ebx: 00000001     ecx: 00000001       edx: c02e1990
> Code;  c013d941 <exec_mmap+111/1f0>   <=====
>    0:   0f 22 d8                  mov    %eax,%cr3   <=====

What looks like happened here is that the pgd pointer isn't properly
aligned (it should be 32 byte aligned and 0x37e8ace4 is not).  Do you
have slab debugging turned on?  I think this has been fixed already in
the AC kernels.

--

				Brian Gerst
