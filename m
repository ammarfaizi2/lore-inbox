Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTD3X77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTD3X77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:59:59 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:30142 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262640AbTD3X75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:59:57 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dphillips@sistina.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <Pine.LNX.4.44.0304301640110.19484-100000@home.transmeta.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 01 May 2003 02:12:10 +0200
In-Reply-To: <Pine.LNX.4.44.0304301640110.19484-100000@home.transmeta.com>
Message-ID: <87d6j34jad.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 30 Apr 2003, Alan Cox wrote:
> > 
> > It ought to be basically the same as ffs because if I remember rightly 
> > 
> > ffs(x^(x-1)) == fls(x)
> 
> So did anybody time this? ffs() we have hardware support for on x86,
> and it's even reasonably efficient on some CPU's ..

There appears to be hardware support for fls, too. This is what gcc
generates for

int fls(int x) {
    return x ? 32 - __builtin_clz(x) : 0;
}

fls:
        pushl   %ebp
        xorl    %edx, %edx
        movl    %esp, %ebp
        movl    8(%ebp), %eax
        testl   %eax, %eax
        je      .L3
        bsrl    %eax, %ecx
        movl    $32, %edx
        xorl    $31, %ecx
        subl    %ecx, %edx
.L3:
        popl    %ebp
        movl    %edx, %eax
        ret

-- 
	Falk
