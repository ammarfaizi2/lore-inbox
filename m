Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbTIMVlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTIMVlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:41:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6671 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S262203AbTIMVkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:40:00 -0400
Date: Sat, 13 Sep 2003 23:39:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre4
Message-ID: <20030913213947.GA557@alpha.home.local>
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 04:48:50PM -0300, Marcelo Tosatti wrote:
> 
> Hello, 
> 
> Here goes -pre4, which contains networking update, IA64 update, PPC
> update, USB update, bunch of knfsd fixes, amongst others.

Seems good here.

However, I tried to compile it on alpha with gcc-3.3.1. It failed on xor.h
because all the asm code is only one string.

Looking through the list archives, I found this (old) patch to 2.5.44-ac3 which
applies cleanly to 2.4.23-pre4. Would you mind applying it, please ?

Cheers,
Willy


>From linux-kernel-owner+willy=40w.ods.org@vger.kernel.org  Tue Oct 29 00:11:51 2002
Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: from vax.home.local (vax [10.2.1.2])
	by alpha.home.local (8.12.4/8.12.1) with ESMTP id g9SNBnn4022263
	for <willy@w.ods.org>; Tue, 29 Oct 2002 00:11:49 +0100
Received: from vger.kernel.org (vger.kernel.org [209.116.70.75])
	by vax.home.local (8.12.2/8.12.1) with ESMTP id g9SNAZtq026134
	for <willy@w.ods.org>; Tue, 29 Oct 2002 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSJ1Wjd>; Mon, 28 Oct 2002 17:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSJ1Wjc>; Mon, 28 Oct 2002 17:39:32 -0500
Received: from p50829418.dip.t-dialin.net ([80.130.148.24]:2309 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S261352AbSJ1WjG>; Mon, 28 Oct 2002 17:39:06 -0500
Received: from dl8bcu.de (th@localhost [127.0.0.1])
	by Marvin.DL8BCU.ampr.org (8.12.1/8.12.1) with ESMTP id g9SMjMVK002631;
	Mon, 28 Oct 2002 22:45:23 GMT
Received: (from th@localhost)
	by dl8bcu.de (8.12.1/8.12.1/Submit) id g9SMjLmI002630;
	Mon, 28 Oct 2002 22:45:21 GMT
X-Authentication-Warning: Marvin.borg.net: th set sender to dl8bcu@dl8bcu.de using -f
Date: 	Mon, 28 Oct 2002 22:45:21 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] asm-alpha/xor.h compile failure (2.5.44-ac5)
Message-ID: <20021028224521.D2396@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org
Status: RO
Content-Length: 34048
Lines: 1615

Hi,
gcc 3.3 complains about the missing quotes:


In file included from drivers/md/xor.c:23:
include/asm/xor.h: At top level:
include/asm/xor.h:36: error: request for member `text' in something not a structure or union
include/asm/xor.h:37: error: parse error before numeric constant
include/asm/xor.h:62: error: syntax error at '#' token
include/asm/xor.h:87:17: invalid suffix "b" on integer constant
include/asm/xor.h:119: error: syntax error at '#' token
include/asm/xor.h:120: error: syntax error at '#' token
include/asm/xor.h:121: error: syntax error at '#' token


Please apply.  

Thorsten


diff -ur linux-2.5.44-ac3/include/asm-alpha/xor.h linux-2.5.44-ac3-ds20/include/asm-alpha/xor.h
--- linux-2.5.44-ac3/include/asm-alpha/xor.h	Sat Oct 19 04:02:28 2002
+++ linux-2.5.44-ac3-ds20/include/asm-alpha/xor.h	Fri Oct 25 18:06:00 2002
@@ -32,794 +32,794 @@
 				 unsigned long *, unsigned long *,
 				 unsigned long *, unsigned long *);
 
-asm("
-	.text
-	.align 3
-	.ent xor_alpha_2
-xor_alpha_2:
-	.prologue 0
-	srl $16, 6, $16
-	.align 4
-2:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,8($17)
-	ldq $3,8($18)
-
-	ldq $4,16($17)
-	ldq $5,16($18)
-	ldq $6,24($17)
-	ldq $7,24($18)
-
-	ldq $19,32($17)
-	ldq $20,32($18)
-	ldq $21,40($17)
-	ldq $22,40($18)
-
-	ldq $23,48($17)
-	ldq $24,48($18)
-	ldq $25,56($17)
-	xor $0,$1,$0		# 7 cycles from $1 load
-
-	ldq $27,56($18)
-	xor $2,$3,$2
-	stq $0,0($17)
-	xor $4,$5,$4
-
-	stq $2,8($17)
-	xor $6,$7,$6
-	stq $4,16($17)
-	xor $19,$20,$19
-
-	stq $6,24($17)
-	xor $21,$22,$21
-	stq $19,32($17)
-	xor $23,$24,$23
-
-	stq $21,40($17)
-	xor $25,$27,$25
-	stq $23,48($17)
-	subq $16,1,$16
-
-	stq $25,56($17)
-	addq $17,64,$17
-	addq $18,64,$18
-	bgt $16,2b
-
-	ret
-	.end xor_alpha_2
-
-	.align 3
-	.ent xor_alpha_3
-xor_alpha_3:
-	.prologue 0
-	srl $16, 6, $16
-	.align 4
-3:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,0($19)
-	ldq $3,8($17)
-
-	ldq $4,8($18)
-	ldq $6,16($17)
-	ldq $7,16($18)
-	ldq $21,24($17)
-
-	ldq $22,24($18)
-	ldq $24,32($17)
-	ldq $25,32($18)
-	ldq $5,8($19)
-
-	ldq $20,16($19)
-	ldq $23,24($19)
-	ldq $27,32($19)
-	nop
-
-	xor $0,$1,$1		# 8 cycles from $0 load
-	xor $3,$4,$4		# 6 cycles from $4 load
-	xor $6,$7,$7		# 6 cycles from $7 load
-	xor $21,$22,$22		# 5 cycles from $22 load
-
-	xor $1,$2,$2		# 9 cycles from $2 load
-	xor $24,$25,$25		# 5 cycles from $25 load
-	stq $2,0($17)
-	xor $4,$5,$5		# 6 cycles from $5 load
-
-	stq $5,8($17)
-	xor $7,$20,$20		# 7 cycles from $20 load
-	stq $20,16($17)
-	xor $22,$23,$23		# 7 cycles from $23 load
-
-	stq $23,24($17)
-	xor $25,$27,$27		# 7 cycles from $27 load
-	stq $27,32($17)
-	nop
-
-	ldq $0,40($17)
-	ldq $1,40($18)
-	ldq $3,48($17)
-	ldq $4,48($18)
-
-	ldq $6,56($17)
-	ldq $7,56($18)
-	ldq $2,40($19)
-	ldq $5,48($19)
-
-	ldq $20,56($19)
-	xor $0,$1,$1		# 4 cycles from $1 load
-	xor $3,$4,$4		# 5 cycles from $4 load
-	xor $6,$7,$7		# 5 cycles from $7 load
-
-	xor $1,$2,$2		# 4 cycles from $2 load
-	xor $4,$5,$5		# 5 cycles from $5 load
-	stq $2,40($17)
-	xor $7,$20,$20		# 4 cycles from $20 load
-
-	stq $5,48($17)
-	subq $16,1,$16
-	stq $20,56($17)
-	addq $19,64,$19
-
-	addq $18,64,$18
-	addq $17,64,$17
-	bgt $16,3b
-	ret
-	.end xor_alpha_3
-
-	.align 3
-	.ent xor_alpha_4
-xor_alpha_4:
-	.prologue 0
-	srl $16, 6, $16
-	.align 4
-4:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,0($19)
-	ldq $3,0($20)
-
-	ldq $4,8($17)
-	ldq $5,8($18)
-	ldq $6,8($19)
-	ldq $7,8($20)
-
-	ldq $21,16($17)
-	ldq $22,16($18)
-	ldq $23,16($19)
-	ldq $24,16($20)
-
-	ldq $25,24($17)
-	xor $0,$1,$1		# 6 cycles from $1 load
-	ldq $27,24($18)
-	xor $2,$3,$3		# 6 cycles from $3 load
-
-	ldq $0,24($19)
-	xor $1,$3,$3
-	ldq $1,24($20)
-	xor $4,$5,$5		# 7 cycles from $5 load
-
-	stq $3,0($17)
-	xor $6,$7,$7
-	xor $21,$22,$22		# 7 cycles from $22 load
-	xor $5,$7,$7
-
-	stq $7,8($17)
-	xor $23,$24,$24		# 7 cycles from $24 load
-	ldq $2,32($17)
-	xor $22,$24,$24
-
-	ldq $3,32($18)
-	ldq $4,32($19)
-	ldq $5,32($20)
-	xor $25,$27,$27		# 8 cycles from $27 load
-
-	ldq $6,40($17)
-	ldq $7,40($18)
-	ldq $21,40($19)
-	ldq $22,40($20)
-
-	stq $24,16($17)
-	xor $0,$1,$1		# 9 cycles from $1 load
-	xor $2,$3,$3		# 5 cycles from $3 load
-	xor $27,$1,$1
-
-	stq $1,24($17)
-	xor $4,$5,$5		# 5 cycles from $5 load
-	ldq $23,48($17)
-	ldq $24,48($18)
-
-	ldq $25,48($19)
-	xor $3,$5,$5
-	ldq $27,48($20)
-	ldq $0,56($17)
-
-	ldq $1,56($18)
-	ldq $2,56($19)
-	xor $6,$7,$7		# 8 cycles from $6 load
-	ldq $3,56($20)
-
-	stq $5,32($17)
-	xor $21,$22,$22		# 8 cycles from $22 load
-	xor $7,$22,$22
-	xor $23,$24,$24		# 5 cycles from $24 load
-
-	stq $22,40($17)
-	xor $25,$27,$27		# 5 cycles from $27 load
-	xor $24,$27,$27
-	xor $0,$1,$1		# 5 cycles from $1 load
-
-	stq $27,48($17)
-	xor $2,$3,$3		# 4 cycles from $3 load
-	xor $1,$3,$3
-	subq $16,1,$16
-
-	stq $3,56($17)
-	addq $20,64,$20
-	addq $19,64,$19
-	addq $18,64,$18
-
-	addq $17,64,$17
-	bgt $16,4b
-	ret
-	.end xor_alpha_4
-
-	.align 3
-	.ent xor_alpha_5
-xor_alpha_5:
-	.prologue 0
-	srl $16, 6, $16
-	.align 4
-5:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,0($19)
-	ldq $3,0($20)
-
-	ldq $4,0($21)
-	ldq $5,8($17)
-	ldq $6,8($18)
-	ldq $7,8($19)
-
-	ldq $22,8($20)
-	ldq $23,8($21)
-	ldq $24,16($17)
-	ldq $25,16($18)
-
-	ldq $27,16($19)
-	xor $0,$1,$1		# 6 cycles from $1 load
-	ldq $28,16($20)
-	xor $2,$3,$3		# 6 cycles from $3 load
-
-	ldq $0,16($21)
-	xor $1,$3,$3
-	ldq $1,24($17)
-	xor $3,$4,$4		# 7 cycles from $4 load
-
-	stq $4,0($17)
-	xor $5,$6,$6		# 7 cycles from $6 load
-	xor $7,$22,$22		# 7 cycles from $22 load
-	xor $6,$23,$23		# 7 cycles from $23 load
-
-	ldq $2,24($18)
-	xor $22,$23,$23
-	ldq $3,24($19)
-	xor $24,$25,$25		# 8 cycles from $25 load
-
-	stq $23,8($17)
-	xor $25,$27,$27		# 8 cycles from $27 load
-	ldq $4,24($20)
-	xor $28,$0,$0		# 7 cycles from $0 load
-
-	ldq $5,24($21)
-	xor $27,$0,$0
-	ldq $6,32($17)
-	ldq $7,32($18)
-
-	stq $0,16($17)
-	xor $1,$2,$2		# 6 cycles from $2 load
-	ldq $22,32($19)
-	xor $3,$4,$4		# 4 cycles from $4 load
-	
-	ldq $23,32($20)
-	xor $2,$4,$4
-	ldq $24,32($21)
-	ldq $25,40($17)
-
-	ldq $27,40($18)
-	ldq $28,40($19)
-	ldq $0,40($20)
-	xor $4,$5,$5		# 7 cycles from $5 load
-
-	stq $5,24($17)
-	xor $6,$7,$7		# 7 cycles from $7 load
-	ldq $1,40($21)
-	ldq $2,48($17)
-
-	ldq $3,48($18)
-	xor $7,$22,$22		# 7 cycles from $22 load
-	ldq $4,48($19)
-	xor $23,$24,$24		# 6 cycles from $24 load
-
-	ldq $5,48($20)
-	xor $22,$24,$24
-	ldq $6,48($21)
-	xor $25,$27,$27		# 7 cycles from $27 load
-
-	stq $24,32($17)
-	xor $27,$28,$28		# 8 cycles from $28 load
-	ldq $7,56($17)
-	xor $0,$1,$1		# 6 cycles from $1 load
-
-	ldq $22,56($18)
-	ldq $23,56($19)
-	ldq $24,56($20)
-	ldq $25,56($21)
-
-	xor $28,$1,$1
-	xor $2,$3,$3		# 9 cycles from $3 load
-	xor $3,$4,$4		# 9 cycles from $4 load
-	xor $5,$6,$6		# 8 cycles from $6 load
-
-	stq $1,40($17)
-	xor $4,$6,$6
-	xor $7,$22,$22		# 7 cycles from $22 load
-	xor $23,$24,$24		# 6 cycles from $24 load
-
-	stq $6,48($17)
-	xor $22,$24,$24
-	subq $16,1,$16
-	xor $24,$25,$25		# 8 cycles from $25 load
-
-	stq $25,56($17)
-	addq $21,64,$21
-	addq $20,64,$20
-	addq $19,64,$19
-
-	addq $18,64,$18
-	addq $17,64,$17
-	bgt $16,5b
-	ret
-	.end xor_alpha_5
-
-	.align 3
-	.ent xor_alpha_prefetch_2
-xor_alpha_prefetch_2:
-	.prologue 0
-	srl $16, 6, $16
-
-	ldq $31, 0($17)
-	ldq $31, 0($18)
-
-	ldq $31, 64($17)
-	ldq $31, 64($18)
-
-	ldq $31, 128($17)
-	ldq $31, 128($18)
-
-	ldq $31, 192($17)
-	ldq $31, 192($18)
-	.align 4
-2:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,8($17)
-	ldq $3,8($18)
-
-	ldq $4,16($17)
-	ldq $5,16($18)
-	ldq $6,24($17)
-	ldq $7,24($18)
-
-	ldq $19,32($17)
-	ldq $20,32($18)
-	ldq $21,40($17)
-	ldq $22,40($18)
-
-	ldq $23,48($17)
-	ldq $24,48($18)
-	ldq $25,56($17)
-	ldq $27,56($18)
-
-	ldq $31,256($17)
-	xor $0,$1,$0		# 8 cycles from $1 load
-	ldq $31,256($18)
-	xor $2,$3,$2
-
-	stq $0,0($17)
-	xor $4,$5,$4
-	stq $2,8($17)
-	xor $6,$7,$6
-
-	stq $4,16($17)
-	xor $19,$20,$19
-	stq $6,24($17)
-	xor $21,$22,$21
-
-	stq $19,32($17)
-	xor $23,$24,$23
-	stq $21,40($17)
-	xor $25,$27,$25
-
-	stq $23,48($17)
-	subq $16,1,$16
-	stq $25,56($17)
-	addq $17,64,$17
-
-	addq $18,64,$18
-	bgt $16,2b
-	ret
-	.end xor_alpha_prefetch_2
-
-	.align 3
-	.ent xor_alpha_prefetch_3
-xor_alpha_prefetch_3:
-	.prologue 0
-	srl $16, 6, $16
-
-	ldq $31, 0($17)
-	ldq $31, 0($18)
-	ldq $31, 0($19)
-
-	ldq $31, 64($17)
-	ldq $31, 64($18)
-	ldq $31, 64($19)
-
-	ldq $31, 128($17)
-	ldq $31, 128($18)
-	ldq $31, 128($19)
-
-	ldq $31, 192($17)
-	ldq $31, 192($18)
-	ldq $31, 192($19)
-	.align 4
-3:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,0($19)
-	ldq $3,8($17)
-
-	ldq $4,8($18)
-	ldq $6,16($17)
-	ldq $7,16($18)
-	ldq $21,24($17)
-
-	ldq $22,24($18)
-	ldq $24,32($17)
-	ldq $25,32($18)
-	ldq $5,8($19)
-
-	ldq $20,16($19)
-	ldq $23,24($19)
-	ldq $27,32($19)
-	nop
-
-	xor $0,$1,$1		# 8 cycles from $0 load
-	xor $3,$4,$4		# 7 cycles from $4 load
-	xor $6,$7,$7		# 6 cycles from $7 load
-	xor $21,$22,$22		# 5 cycles from $22 load
-
-	xor $1,$2,$2		# 9 cycles from $2 load
-	xor $24,$25,$25		# 5 cycles from $25 load
-	stq $2,0($17)
-	xor $4,$5,$5		# 6 cycles from $5 load
-
-	stq $5,8($17)
-	xor $7,$20,$20		# 7 cycles from $20 load
-	stq $20,16($17)
-	xor $22,$23,$23		# 7 cycles from $23 load
-
-	stq $23,24($17)
-	xor $25,$27,$27		# 7 cycles from $27 load
-	stq $27,32($17)
-	nop
-
-	ldq $0,40($17)
-	ldq $1,40($18)
-	ldq $3,48($17)
-	ldq $4,48($18)
-
-	ldq $6,56($17)
-	ldq $7,56($18)
-	ldq $2,40($19)
-	ldq $5,48($19)
-
-	ldq $20,56($19)
-	ldq $31,256($17)
-	ldq $31,256($18)
-	ldq $31,256($19)
-
-	xor $0,$1,$1		# 6 cycles from $1 load
-	xor $3,$4,$4		# 5 cycles from $4 load
-	xor $6,$7,$7		# 5 cycles from $7 load
-	xor $1,$2,$2		# 4 cycles from $2 load
-	
-	xor $4,$5,$5		# 5 cycles from $5 load
-	xor $7,$20,$20		# 4 cycles from $20 load
-	stq $2,40($17)
-	subq $16,1,$16
-
-	stq $5,48($17)
-	addq $19,64,$19
-	stq $20,56($17)
-	addq $18,64,$18
-
-	addq $17,64,$17
-	bgt $16,3b
-	ret
-	.end xor_alpha_prefetch_3
-
-	.align 3
-	.ent xor_alpha_prefetch_4
-xor_alpha_prefetch_4:
-	.prologue 0
-	srl $16, 6, $16
-
-	ldq $31, 0($17)
-	ldq $31, 0($18)
-	ldq $31, 0($19)
-	ldq $31, 0($20)
-
-	ldq $31, 64($17)
-	ldq $31, 64($18)
-	ldq $31, 64($19)
-	ldq $31, 64($20)
-
-	ldq $31, 128($17)
-	ldq $31, 128($18)
-	ldq $31, 128($19)
-	ldq $31, 128($20)
-
-	ldq $31, 192($17)
-	ldq $31, 192($18)
-	ldq $31, 192($19)
-	ldq $31, 192($20)
-	.align 4
-4:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,0($19)
-	ldq $3,0($20)
-
-	ldq $4,8($17)
-	ldq $5,8($18)
-	ldq $6,8($19)
-	ldq $7,8($20)
-
-	ldq $21,16($17)
-	ldq $22,16($18)
-	ldq $23,16($19)
-	ldq $24,16($20)
-
-	ldq $25,24($17)
-	xor $0,$1,$1		# 6 cycles from $1 load
-	ldq $27,24($18)
-	xor $2,$3,$3		# 6 cycles from $3 load
-
-	ldq $0,24($19)
-	xor $1,$3,$3
-	ldq $1,24($20)
-	xor $4,$5,$5		# 7 cycles from $5 load
-
-	stq $3,0($17)
-	xor $6,$7,$7
-	xor $21,$22,$22		# 7 cycles from $22 load
-	xor $5,$7,$7
-
-	stq $7,8($17)
-	xor $23,$24,$24		# 7 cycles from $24 load
-	ldq $2,32($17)
-	xor $22,$24,$24
-
-	ldq $3,32($18)
-	ldq $4,32($19)
-	ldq $5,32($20)
-	xor $25,$27,$27		# 8 cycles from $27 load
-
-	ldq $6,40($17)
-	ldq $7,40($18)
-	ldq $21,40($19)
-	ldq $22,40($20)
-
-	stq $24,16($17)
-	xor $0,$1,$1		# 9 cycles from $1 load
-	xor $2,$3,$3		# 5 cycles from $3 load
-	xor $27,$1,$1
-
-	stq $1,24($17)
-	xor $4,$5,$5		# 5 cycles from $5 load
-	ldq $23,48($17)
-	xor $3,$5,$5
-
-	ldq $24,48($18)
-	ldq $25,48($19)
-	ldq $27,48($20)
-	ldq $0,56($17)
-
-	ldq $1,56($18)
-	ldq $2,56($19)
-	ldq $3,56($20)
-	xor $6,$7,$7		# 8 cycles from $6 load
-
-	ldq $31,256($17)
-	xor $21,$22,$22		# 8 cycles from $22 load
-	ldq $31,256($18)
-	xor $7,$22,$22
-
-	ldq $31,256($19)
-	xor $23,$24,$24		# 6 cycles from $24 load
-	ldq $31,256($20)
-	xor $25,$27,$27		# 6 cycles from $27 load
-
-	stq $5,32($17)
-	xor $24,$27,$27
-	xor $0,$1,$1		# 7 cycles from $1 load
-	xor $2,$3,$3		# 6 cycles from $3 load
-
-	stq $22,40($17)
-	xor $1,$3,$3
-	stq $27,48($17)
-	subq $16,1,$16
-
-	stq $3,56($17)
-	addq $20,64,$20
-	addq $19,64,$19
-	addq $18,64,$18
-
-	addq $17,64,$17
-	bgt $16,4b
-	ret
-	.end xor_alpha_prefetch_4
-
-	.align 3
-	.ent xor_alpha_prefetch_5
-xor_alpha_prefetch_5:
-	.prologue 0
-	srl $16, 6, $16
-
-	ldq $31, 0($17)
-	ldq $31, 0($18)
-	ldq $31, 0($19)
-	ldq $31, 0($20)
-	ldq $31, 0($21)
-
-	ldq $31, 64($17)
-	ldq $31, 64($18)
-	ldq $31, 64($19)
-	ldq $31, 64($20)
-	ldq $31, 64($21)
-
-	ldq $31, 128($17)
-	ldq $31, 128($18)
-	ldq $31, 128($19)
-	ldq $31, 128($20)
-	ldq $31, 128($21)
-
-	ldq $31, 192($17)
-	ldq $31, 192($18)
-	ldq $31, 192($19)
-	ldq $31, 192($20)
-	ldq $31, 192($21)
-	.align 4
-5:
-	ldq $0,0($17)
-	ldq $1,0($18)
-	ldq $2,0($19)
-	ldq $3,0($20)
-
-	ldq $4,0($21)
-	ldq $5,8($17)
-	ldq $6,8($18)
-	ldq $7,8($19)
-
-	ldq $22,8($20)
-	ldq $23,8($21)
-	ldq $24,16($17)
-	ldq $25,16($18)
-
-	ldq $27,16($19)
-	xor $0,$1,$1		# 6 cycles from $1 load
-	ldq $28,16($20)
-	xor $2,$3,$3		# 6 cycles from $3 load
-
-	ldq $0,16($21)
-	xor $1,$3,$3
-	ldq $1,24($17)
-	xor $3,$4,$4		# 7 cycles from $4 load
-
-	stq $4,0($17)
-	xor $5,$6,$6		# 7 cycles from $6 load
-	xor $7,$22,$22		# 7 cycles from $22 load
-	xor $6,$23,$23		# 7 cycles from $23 load
-
-	ldq $2,24($18)
-	xor $22,$23,$23
-	ldq $3,24($19)
-	xor $24,$25,$25		# 8 cycles from $25 load
-
-	stq $23,8($17)
-	xor $25,$27,$27		# 8 cycles from $27 load
-	ldq $4,24($20)
-	xor $28,$0,$0		# 7 cycles from $0 load
-
-	ldq $5,24($21)
-	xor $27,$0,$0
-	ldq $6,32($17)
-	ldq $7,32($18)
-
-	stq $0,16($17)
-	xor $1,$2,$2		# 6 cycles from $2 load
-	ldq $22,32($19)
-	xor $3,$4,$4		# 4 cycles from $4 load
-	
-	ldq $23,32($20)
-	xor $2,$4,$4
-	ldq $24,32($21)
-	ldq $25,40($17)
-
-	ldq $27,40($18)
-	ldq $28,40($19)
-	ldq $0,40($20)
-	xor $4,$5,$5		# 7 cycles from $5 load
-
-	stq $5,24($17)
-	xor $6,$7,$7		# 7 cycles from $7 load
-	ldq $1,40($21)
-	ldq $2,48($17)
-
-	ldq $3,48($18)
-	xor $7,$22,$22		# 7 cycles from $22 load
-	ldq $4,48($19)
-	xor $23,$24,$24		# 6 cycles from $24 load
-
-	ldq $5,48($20)
-	xor $22,$24,$24
-	ldq $6,48($21)
-	xor $25,$27,$27		# 7 cycles from $27 load
-
-	stq $24,32($17)
-	xor $27,$28,$28		# 8 cycles from $28 load
-	ldq $7,56($17)
-	xor $0,$1,$1		# 6 cycles from $1 load
-
-	ldq $22,56($18)
-	ldq $23,56($19)
-	ldq $24,56($20)
-	ldq $25,56($21)
-
-	ldq $31,256($17)
-	xor $28,$1,$1
-	ldq $31,256($18)
-	xor $2,$3,$3		# 9 cycles from $3 load
-
-	ldq $31,256($19)
-	xor $3,$4,$4		# 9 cycles from $4 load
-	ldq $31,256($20)
-	xor $5,$6,$6		# 8 cycles from $6 load
-
-	stq $1,40($17)
-	xor $4,$6,$6
-	xor $7,$22,$22		# 7 cycles from $22 load
-	xor $23,$24,$24		# 6 cycles from $24 load
-
-	stq $6,48($17)
-	xor $22,$24,$24
-	ldq $31,256($21)
-	xor $24,$25,$25		# 8 cycles from $25 load
-
-	stq $25,56($17)
-	subq $16,1,$16
-	addq $21,64,$21
-	addq $20,64,$20
-
-	addq $19,64,$19
-	addq $18,64,$18
-	addq $17,64,$17
-	bgt $16,5b
-
-	ret
-	.end xor_alpha_prefetch_5
-");
+asm(
+"	.text			\n"
+"	.align 3		\n"
+"	.ent xor_alpha_2	\n"
+"xor_alpha_2:			\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"	.align 4		\n"
+"2:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,8($17)		\n"
+"	ldq $3,8($18)		\n"
+"				\n"
+"	ldq $4,16($17)		\n"
+"	ldq $5,16($18)		\n"
+"	ldq $6,24($17)		\n"
+"	ldq $7,24($18)		\n"
+"				\n"
+"	ldq $19,32($17)		\n"
+"	ldq $20,32($18)		\n"
+"	ldq $21,40($17)		\n"
+"	ldq $22,40($18)		\n"
+"				\n"
+"	ldq $23,48($17)		\n"
+"	ldq $24,48($18)		\n"
+"	ldq $25,56($17)		\n"
+"	xor $0,$1,$0		# 7 cycles from $1 load	\n"
+"				\n"
+"	ldq $27,56($18)		\n"
+"	xor $2,$3,$2		\n"
+"	stq $0,0($17)		\n"
+"	xor $4,$5,$4		\n"
+"				\n"
+"	stq $2,8($17)		\n"
+"	xor $6,$7,$6		\n"
+"	stq $4,16($17)		\n"
+"	xor $19,$20,$19		\n"
+"				\n"
+"	stq $6,24($17)		\n"
+"	xor $21,$22,$21		\n"
+"	stq $19,32($17)		\n"
+"	xor $23,$24,$23		\n"
+"				\n"
+"	stq $21,40($17)		\n"
+"	xor $25,$27,$25		\n"
+"	stq $23,48($17)		\n"
+"	subq $16,1,$16		\n"
+"				\n"
+"	stq $25,56($17)		\n"
+"	addq $17,64,$17		\n"
+"	addq $18,64,$18		\n"
+"	bgt $16,2b		\n"
+"				\n"
+"	ret			\n"
+"	.end xor_alpha_2	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_3	\n"
+"xor_alpha_3:			\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"	.align 4		\n"
+"3:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,0($19)		\n"
+"	ldq $3,8($17)		\n"
+"				\n"
+"	ldq $4,8($18)		\n"
+"	ldq $6,16($17)		\n"
+"	ldq $7,16($18)		\n"
+"	ldq $21,24($17)		\n"
+"				\n"
+"	ldq $22,24($18)		\n"
+"	ldq $24,32($17)		\n"
+"	ldq $25,32($18)		\n"
+"	ldq $5,8($19)		\n"
+"				\n"
+"	ldq $20,16($19)		\n"
+"	ldq $23,24($19)		\n"
+"	ldq $27,32($19)		\n"
+"	nop			\n"
+"				\n"
+"	xor $0,$1,$1		# 8 cycles from $0 load	\n"
+"	xor $3,$4,$4		# 6 cycles from $4 load	\n"
+"	xor $6,$7,$7		# 6 cycles from $7 load	\n"
+"	xor $21,$22,$22		# 5 cycles from $22 load	\n"
+"				\n"
+"	xor $1,$2,$2		# 9 cycles from $2 load	\n"
+"	xor $24,$25,$25		# 5 cycles from $25 load	\n"
+"	stq $2,0($17)		\n"
+"	xor $4,$5,$5		# 6 cycles from $5 load	\n"
+"				\n"
+"	stq $5,8($17)		\n"
+"	xor $7,$20,$20		# 7 cycles from $20 load	\n"
+"	stq $20,16($17)		\n"
+"	xor $22,$23,$23		# 7 cycles from $23 load	\n"
+"				\n"
+"	stq $23,24($17)		\n"
+"	xor $25,$27,$27		# 7 cycles from $27 load	\n"
+"	stq $27,32($17)		\n"
+"	nop			\n"
+"				\n"
+"	ldq $0,40($17)		\n"
+"	ldq $1,40($18)		\n"
+"	ldq $3,48($17)		\n"
+"	ldq $4,48($18)		\n"
+"				\n"
+"	ldq $6,56($17)		\n"
+"	ldq $7,56($18)		\n"
+"	ldq $2,40($19)		\n"
+"	ldq $5,48($19)		\n"
+"				\n"
+"	ldq $20,56($19)		\n"
+"	xor $0,$1,$1		# 4 cycles from $1 load	\n"
+"	xor $3,$4,$4		# 5 cycles from $4 load	\n"
+"	xor $6,$7,$7		# 5 cycles from $7 load	\n"
+"				\n"
+"	xor $1,$2,$2		# 4 cycles from $2 load	\n"
+"	xor $4,$5,$5		# 5 cycles from $5 load	\n"
+"	stq $2,40($17)		\n"
+"	xor $7,$20,$20		# 4 cycles from $20 load	\n"
+"				\n"
+"	stq $5,48($17)		\n"
+"	subq $16,1,$16		\n"
+"	stq $20,56($17)		\n"
+"	addq $19,64,$19		\n"
+"				\n"
+"	addq $18,64,$18		\n"
+"	addq $17,64,$17		\n"
+"	bgt $16,3b		\n"
+"	ret			\n"
+"	.end xor_alpha_3	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_4	\n"
+"xor_alpha_4:			\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"	.align 4		\n"
+"4:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,0($19)		\n"
+"	ldq $3,0($20)		\n"
+"				\n"
+"	ldq $4,8($17)		\n"
+"	ldq $5,8($18)		\n"
+"	ldq $6,8($19)		\n"
+"	ldq $7,8($20)		\n"
+"				\n"
+"	ldq $21,16($17)		\n"
+"	ldq $22,16($18)		\n"
+"	ldq $23,16($19)		\n"
+"	ldq $24,16($20)		\n"
+"				\n"
+"	ldq $25,24($17)		\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"	ldq $27,24($18)		\n"
+"	xor $2,$3,$3		# 6 cycles from $3 load	\n"
+"				\n"
+"	ldq $0,24($19)		\n"
+"	xor $1,$3,$3		\n"
+"	ldq $1,24($20)		\n"
+"	xor $4,$5,$5		# 7 cycles from $5 load	\n"
+"				\n"
+"	stq $3,0($17)		\n"
+"	xor $6,$7,$7		\n"
+"	xor $21,$22,$22		# 7 cycles from $22 load	\n"
+"	xor $5,$7,$7		\n"
+"				\n"
+"	stq $7,8($17)		\n"
+"	xor $23,$24,$24		# 7 cycles from $24 load	\n"
+"	ldq $2,32($17)		\n"
+"	xor $22,$24,$24		\n"
+"				\n"
+"	ldq $3,32($18)		\n"
+"	ldq $4,32($19)		\n"
+"	ldq $5,32($20)		\n"
+"	xor $25,$27,$27		# 8 cycles from $27 load	\n"
+"				\n"
+"	ldq $6,40($17)		\n"
+"	ldq $7,40($18)		\n"
+"	ldq $21,40($19)		\n"
+"	ldq $22,40($20)		\n"
+"				\n"
+"	stq $24,16($17)		\n"
+"	xor $0,$1,$1		# 9 cycles from $1 load	\n"
+"	xor $2,$3,$3		# 5 cycles from $3 load	\n"
+"	xor $27,$1,$1		\n"
+"				\n"
+"	stq $1,24($17)		\n"
+"	xor $4,$5,$5		# 5 cycles from $5 load	\n"
+"	ldq $23,48($17)		\n"
+"	ldq $24,48($18)		\n"
+"				\n"
+"	ldq $25,48($19)		\n"
+"	xor $3,$5,$5		\n"
+"	ldq $27,48($20)		\n"
+"	ldq $0,56($17)		\n"
+"				\n"
+"	ldq $1,56($18)		\n"
+"	ldq $2,56($19)		\n"
+"	xor $6,$7,$7		# 8 cycles from $6 load	\n"
+"	ldq $3,56($20)		\n"
+"				\n"
+"	stq $5,32($17)		\n"
+"	xor $21,$22,$22		# 8 cycles from $22 load	\n"
+"	xor $7,$22,$22		\n"
+"	xor $23,$24,$24		# 5 cycles from $24 load	\n"
+"				\n"
+"	stq $22,40($17)		\n"
+"	xor $25,$27,$27		# 5 cycles from $27 load	\n"
+"	xor $24,$27,$27		\n"
+"	xor $0,$1,$1		# 5 cycles from $1 load	\n"
+"				\n"
+"	stq $27,48($17)		\n"
+"	xor $2,$3,$3		# 4 cycles from $3 load	\n"
+"	xor $1,$3,$3		\n"
+"	subq $16,1,$16		\n"
+"				\n"
+"	stq $3,56($17)		\n"
+"	addq $20,64,$20		\n"
+"	addq $19,64,$19		\n"
+"	addq $18,64,$18		\n"
+"				\n"
+"	addq $17,64,$17		\n"
+"	bgt $16,4b		\n"
+"	ret			\n"
+"	.end xor_alpha_4	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_5	\n"
+"xor_alpha_5:			\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"	.align 4		\n"
+"5:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,0($19)		\n"
+"	ldq $3,0($20)		\n"
+"				\n"
+"	ldq $4,0($21)		\n"
+"	ldq $5,8($17)		\n"
+"	ldq $6,8($18)		\n"
+"	ldq $7,8($19)		\n"
+"				\n"
+"	ldq $22,8($20)		\n"
+"	ldq $23,8($21)		\n"
+"	ldq $24,16($17)		\n"
+"	ldq $25,16($18)		\n"
+"				\n"
+"	ldq $27,16($19)		\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"	ldq $28,16($20)		\n"
+"	xor $2,$3,$3		# 6 cycles from $3 load	\n"
+"				\n"
+"	ldq $0,16($21)		\n"
+"	xor $1,$3,$3		\n"
+"	ldq $1,24($17)		\n"
+"	xor $3,$4,$4		# 7 cycles from $4 load	\n"
+"				\n"
+"	stq $4,0($17)		\n"
+"	xor $5,$6,$6		# 7 cycles from $6 load	\n"
+"	xor $7,$22,$22		# 7 cycles from $22 load	\n"
+"	xor $6,$23,$23		# 7 cycles from $23 load	\n"
+"				\n"
+"	ldq $2,24($18)		\n"
+"	xor $22,$23,$23		\n"
+"	ldq $3,24($19)		\n"
+"	xor $24,$25,$25		# 8 cycles from $25 load	\n"
+"				\n"
+"	stq $23,8($17)		\n"
+"	xor $25,$27,$27		# 8 cycles from $27 load	\n"
+"	ldq $4,24($20)		\n"
+"	xor $28,$0,$0		# 7 cycles from $0 load	\n"
+"				\n"
+"	ldq $5,24($21)		\n"
+"	xor $27,$0,$0		\n"
+"	ldq $6,32($17)		\n"
+"	ldq $7,32($18)		\n"
+"				\n"
+"	stq $0,16($17)		\n"
+"	xor $1,$2,$2		# 6 cycles from $2 load	\n"
+"	ldq $22,32($19)		\n"
+"	xor $3,$4,$4		# 4 cycles from $4 load	\n"
+"				\n"
+"	ldq $23,32($20)		\n"
+"	xor $2,$4,$4		\n"
+"	ldq $24,32($21)		\n"
+"	ldq $25,40($17)		\n"
+"				\n"
+"	ldq $27,40($18)		\n"
+"	ldq $28,40($19)		\n"
+"	ldq $0,40($20)		\n"
+"	xor $4,$5,$5		# 7 cycles from $5 load	\n"
+"				\n"
+"	stq $5,24($17)		\n"
+"	xor $6,$7,$7		# 7 cycles from $7 load	\n"
+"	ldq $1,40($21)		\n"
+"	ldq $2,48($17)		\n"
+"				\n"
+"	ldq $3,48($18)		\n"
+"	xor $7,$22,$22		# 7 cycles from $22 load	\n"
+"	ldq $4,48($19)		\n"
+"	xor $23,$24,$24		# 6 cycles from $24 load	\n"
+"				\n"
+"	ldq $5,48($20)		\n"
+"	xor $22,$24,$24		\n"
+"	ldq $6,48($21)		\n"
+"	xor $25,$27,$27		# 7 cycles from $27 load	\n"
+"				\n"
+"	stq $24,32($17)		\n"
+"	xor $27,$28,$28		# 8 cycles from $28 load	\n"
+"	ldq $7,56($17)		\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"				\n"
+"	ldq $22,56($18)		\n"
+"	ldq $23,56($19)		\n"
+"	ldq $24,56($20)		\n"
+"	ldq $25,56($21)		\n"
+"				\n"
+"	xor $28,$1,$1		\n"
+"	xor $2,$3,$3		# 9 cycles from $3 load	\n"
+"	xor $3,$4,$4		# 9 cycles from $4 load	\n"
+"	xor $5,$6,$6		# 8 cycles from $6 load	\n"
+"				\n"
+"	stq $1,40($17)		\n"
+"	xor $4,$6,$6		\n"
+"	xor $7,$22,$22		# 7 cycles from $22 load	\n"
+"	xor $23,$24,$24		# 6 cycles from $24 load	\n"
+"				\n"
+"	stq $6,48($17)		\n"
+"	xor $22,$24,$24		\n"
+"	subq $16,1,$16		\n"
+"	xor $24,$25,$25		# 8 cycles from $25 load	\n"
+"				\n"
+"	stq $25,56($17)		\n"
+"	addq $21,64,$21		\n"
+"	addq $20,64,$20		\n"
+"	addq $19,64,$19		\n"
+"				\n"
+"	addq $18,64,$18		\n"
+"	addq $17,64,$17		\n"
+"	bgt $16,5b		\n"
+"	ret			\n"
+"	.end xor_alpha_5	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_prefetch_2	\n"
+"xor_alpha_prefetch_2:		\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"				\n"
+"	ldq $31, 0($17)		\n"
+"	ldq $31, 0($18)		\n"
+"				\n"
+"	ldq $31, 64($17)	\n"
+"	ldq $31, 64($18)	\n"
+"				\n"
+"	ldq $31, 128($17)	\n"
+"	ldq $31, 128($18)	\n"
+"				\n"
+"	ldq $31, 192($17)	\n"
+"	ldq $31, 192($18)	\n"
+"	.align 4		\n"
+"2:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,8($17)		\n"
+"	ldq $3,8($18)		\n"
+"				\n"
+"	ldq $4,16($17)		\n"
+"	ldq $5,16($18)		\n"
+"	ldq $6,24($17)		\n"
+"	ldq $7,24($18)		\n"
+"				\n"
+"	ldq $19,32($17)		\n"
+"	ldq $20,32($18)		\n"
+"	ldq $21,40($17)		\n"
+"	ldq $22,40($18)		\n"
+"				\n"
+"	ldq $23,48($17)		\n"
+"	ldq $24,48($18)		\n"
+"	ldq $25,56($17)		\n"
+"	ldq $27,56($18)		\n"
+"				\n"
+"	ldq $31,256($17)	\n"
+"	xor $0,$1,$0		# 8 cycles from $1 load	\n"
+"	ldq $31,256($18)	\n"
+"	xor $2,$3,$2		\n"
+"				\n"
+"	stq $0,0($17)		\n"
+"	xor $4,$5,$4		\n"
+"	stq $2,8($17)		\n"
+"	xor $6,$7,$6		\n"
+"				\n"
+"	stq $4,16($17)		\n"
+"	xor $19,$20,$19		\n"
+"	stq $6,24($17)		\n"
+"	xor $21,$22,$21		\n"
+"				\n"
+"	stq $19,32($17)		\n"
+"	xor $23,$24,$23		\n"
+"	stq $21,40($17)		\n"
+"	xor $25,$27,$25		\n"
+"				\n"
+"	stq $23,48($17)		\n"
+"	subq $16,1,$16		\n"
+"	stq $25,56($17)		\n"
+"	addq $17,64,$17		\n"
+"				\n"
+"	addq $18,64,$18		\n"
+"	bgt $16,2b		\n"
+"	ret			\n"
+"	.end xor_alpha_prefetch_2	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_prefetch_3	\n"
+"xor_alpha_prefetch_3:		\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"				\n"
+"	ldq $31, 0($17)		\n"
+"	ldq $31, 0($18)		\n"
+"	ldq $31, 0($19)		\n"
+"				\n"
+"	ldq $31, 64($17)	\n"
+"	ldq $31, 64($18)	\n"
+"	ldq $31, 64($19)	\n"
+"				\n"
+"	ldq $31, 128($17)	\n"
+"	ldq $31, 128($18)	\n"
+"	ldq $31, 128($19)	\n"
+"				\n"
+"	ldq $31, 192($17)	\n"
+"	ldq $31, 192($18)	\n"
+"	ldq $31, 192($19)	\n"
+"	.align 4		\n"
+"3:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,0($19)		\n"
+"	ldq $3,8($17)		\n"
+"				\n"
+"	ldq $4,8($18)		\n"
+"	ldq $6,16($17)		\n"
+"	ldq $7,16($18)		\n"
+"	ldq $21,24($17)		\n"
+"				\n"
+"	ldq $22,24($18)		\n"
+"	ldq $24,32($17)		\n"
+"	ldq $25,32($18)		\n"
+"	ldq $5,8($19)		\n"
+"				\n"
+"	ldq $20,16($19)		\n"
+"	ldq $23,24($19)		\n"
+"	ldq $27,32($19)		\n"
+"	nop			\n"
+"				\n"
+"	xor $0,$1,$1		# 8 cycles from $0 load	\n"
+"	xor $3,$4,$4		# 7 cycles from $4 load	\n"
+"	xor $6,$7,$7		# 6 cycles from $7 load	\n"
+"	xor $21,$22,$22		# 5 cycles from $22 load	\n"
+"				\n"
+"	xor $1,$2,$2		# 9 cycles from $2 load	\n"
+"	xor $24,$25,$25		# 5 cycles from $25 load	\n"
+"	stq $2,0($17)		\n"
+"	xor $4,$5,$5		# 6 cycles from $5 load	\n"
+"				\n"
+"	stq $5,8($17)		\n"
+"	xor $7,$20,$20		# 7 cycles from $20 load	\n"
+"	stq $20,16($17)		\n"
+"	xor $22,$23,$23		# 7 cycles from $23 load	\n"
+"				\n"
+"	stq $23,24($17)		\n"
+"	xor $25,$27,$27		# 7 cycles from $27 load	\n"
+"	stq $27,32($17)		\n"
+"	nop			\n"
+"				\n"
+"	ldq $0,40($17)		\n"
+"	ldq $1,40($18)		\n"
+"	ldq $3,48($17)		\n"
+"	ldq $4,48($18)		\n"
+"				\n"
+"	ldq $6,56($17)		\n"
+"	ldq $7,56($18)		\n"
+"	ldq $2,40($19)		\n"
+"	ldq $5,48($19)		\n"
+"				\n"
+"	ldq $20,56($19)		\n"
+"	ldq $31,256($17)	\n"
+"	ldq $31,256($18)	\n"
+"	ldq $31,256($19)	\n"
+"				\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"	xor $3,$4,$4		# 5 cycles from $4 load	\n"
+"	xor $6,$7,$7		# 5 cycles from $7 load	\n"
+"	xor $1,$2,$2		# 4 cycles from $2 load	\n"
+"				\n"
+"	xor $4,$5,$5		# 5 cycles from $5 load	\n"
+"	xor $7,$20,$20		# 4 cycles from $20 load	\n"
+"	stq $2,40($17)		\n"
+"	subq $16,1,$16		\n"
+"				\n"
+"	stq $5,48($17)		\n"
+"	addq $19,64,$19		\n"
+"	stq $20,56($17)		\n"
+"	addq $18,64,$18		\n"
+"				\n"
+"	addq $17,64,$17		\n"
+"	bgt $16,3b		\n"
+"	ret			\n"
+"	.end xor_alpha_prefetch_3	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_prefetch_4	\n"
+"xor_alpha_prefetch_4:		\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"				\n"
+"	ldq $31, 0($17)		\n"
+"	ldq $31, 0($18)		\n"
+"	ldq $31, 0($19)		\n"
+"	ldq $31, 0($20)		\n"
+"				\n"
+"	ldq $31, 64($17)	\n"
+"	ldq $31, 64($18)	\n"
+"	ldq $31, 64($19)	\n"
+"	ldq $31, 64($20)	\n"
+"				\n"
+"	ldq $31, 128($17)	\n"
+"	ldq $31, 128($18)	\n"
+"	ldq $31, 128($19)	\n"
+"	ldq $31, 128($20)	\n"
+"				\n"
+"	ldq $31, 192($17)	\n"
+"	ldq $31, 192($18)	\n"
+"	ldq $31, 192($19)	\n"
+"	ldq $31, 192($20)	\n"
+"	.align 4		\n"
+"4:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,0($19)		\n"
+"	ldq $3,0($20)		\n"
+"				\n"
+"	ldq $4,8($17)		\n"
+"	ldq $5,8($18)		\n"
+"	ldq $6,8($19)		\n"
+"	ldq $7,8($20)		\n"
+"				\n"
+"	ldq $21,16($17)		\n"
+"	ldq $22,16($18)		\n"
+"	ldq $23,16($19)		\n"
+"	ldq $24,16($20)		\n"
+"				\n"
+"	ldq $25,24($17)		\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"	ldq $27,24($18)		\n"
+"	xor $2,$3,$3		# 6 cycles from $3 load	\n"
+"				\n"
+"	ldq $0,24($19)		\n"
+"	xor $1,$3,$3		\n"
+"	ldq $1,24($20)		\n"
+"	xor $4,$5,$5		# 7 cycles from $5 load	\n"
+"				\n"
+"	stq $3,0($17)		\n"
+"	xor $6,$7,$7		\n"
+"	xor $21,$22,$22		# 7 cycles from $22 load	\n"
+"	xor $5,$7,$7		\n"
+"				\n"
+"	stq $7,8($17)		\n"
+"	xor $23,$24,$24		# 7 cycles from $24 load	\n"
+"	ldq $2,32($17)		\n"
+"	xor $22,$24,$24		\n"
+"				\n"
+"	ldq $3,32($18)		\n"
+"	ldq $4,32($19)		\n"
+"	ldq $5,32($20)		\n"
+"	xor $25,$27,$27		# 8 cycles from $27 load	\n"
+"				\n"
+"	ldq $6,40($17)		\n"
+"	ldq $7,40($18)		\n"
+"	ldq $21,40($19)		\n"
+"	ldq $22,40($20)		\n"
+"				\n"
+"	stq $24,16($17)		\n"
+"	xor $0,$1,$1		# 9 cycles from $1 load	\n"
+"	xor $2,$3,$3		# 5 cycles from $3 load	\n"
+"	xor $27,$1,$1		\n"
+"				\n"
+"	stq $1,24($17)		\n"
+"	xor $4,$5,$5		# 5 cycles from $5 load	\n"
+"	ldq $23,48($17)		\n"
+"	xor $3,$5,$5		\n"
+"				\n"
+"	ldq $24,48($18)		\n"
+"	ldq $25,48($19)		\n"
+"	ldq $27,48($20)		\n"
+"	ldq $0,56($17)		\n"
+"				\n"
+"	ldq $1,56($18)		\n"
+"	ldq $2,56($19)		\n"
+"	ldq $3,56($20)		\n"
+"	xor $6,$7,$7		# 8 cycles from $6 load	\n"
+"				\n"
+"	ldq $31,256($17)	\n"
+"	xor $21,$22,$22		# 8 cycles from $22 load	\n"
+"	ldq $31,256($18)	\n"
+"	xor $7,$22,$22		\n"
+"				\n"
+"	ldq $31,256($19)	\n"
+"	xor $23,$24,$24		# 6 cycles from $24 load	\n"
+"	ldq $31,256($20)	\n"
+"	xor $25,$27,$27		# 6 cycles from $27 load	\n"
+"				\n"
+"	stq $5,32($17)		\n"
+"	xor $24,$27,$27		\n"
+"	xor $0,$1,$1		# 7 cycles from $1 load	\n"
+"	xor $2,$3,$3		# 6 cycles from $3 load	\n"
+"				\n"
+"	stq $22,40($17)		\n"
+"	xor $1,$3,$3		\n"
+"	stq $27,48($17)		\n"
+"	subq $16,1,$16		\n"
+"				\n"
+"	stq $3,56($17)		\n"
+"	addq $20,64,$20		\n"
+"	addq $19,64,$19		\n"
+"	addq $18,64,$18		\n"
+"				\n"
+"	addq $17,64,$17		\n"
+"	bgt $16,4b		\n"
+"	ret			\n"
+"	.end xor_alpha_prefetch_4	\n"
+"				\n"
+"	.align 3		\n"
+"	.ent xor_alpha_prefetch_5	\n"
+"xor_alpha_prefetch_5:		\n"
+"	.prologue 0		\n"
+"	srl $16, 6, $16		\n"
+"				\n"
+"	ldq $31, 0($17)		\n"
+"	ldq $31, 0($18)		\n"
+"	ldq $31, 0($19)		\n"
+"	ldq $31, 0($20)		\n"
+"	ldq $31, 0($21)		\n"
+"				\n"
+"	ldq $31, 64($17)	\n"
+"	ldq $31, 64($18)	\n"
+"	ldq $31, 64($19)	\n"
+"	ldq $31, 64($20)	\n"
+"	ldq $31, 64($21)	\n"
+"				\n"
+"	ldq $31, 128($17)	\n"
+"	ldq $31, 128($18)	\n"
+"	ldq $31, 128($19)	\n"
+"	ldq $31, 128($20)	\n"
+"	ldq $31, 128($21)	\n"
+"				\n"
+"	ldq $31, 192($17)	\n"
+"	ldq $31, 192($18)	\n"
+"	ldq $31, 192($19)	\n"
+"	ldq $31, 192($20)	\n"
+"	ldq $31, 192($21)	\n"
+"	.align 4		\n"
+"5:				\n"
+"	ldq $0,0($17)		\n"
+"	ldq $1,0($18)		\n"
+"	ldq $2,0($19)		\n"
+"	ldq $3,0($20)		\n"
+"				\n"
+"	ldq $4,0($21)		\n"
+"	ldq $5,8($17)		\n"
+"	ldq $6,8($18)		\n"
+"	ldq $7,8($19)		\n"
+"				\n"
+"	ldq $22,8($20)		\n"
+"	ldq $23,8($21)		\n"
+"	ldq $24,16($17)		\n"
+"	ldq $25,16($18)		\n"
+"				\n"
+"	ldq $27,16($19)		\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"	ldq $28,16($20)		\n"
+"	xor $2,$3,$3		# 6 cycles from $3 load	\n"
+"				\n"
+"	ldq $0,16($21)		\n"
+"	xor $1,$3,$3		\n"
+"	ldq $1,24($17)		\n"
+"	xor $3,$4,$4		# 7 cycles from $4 load	\n"
+"				\n"
+"	stq $4,0($17)		\n"
+"	xor $5,$6,$6		# 7 cycles from $6 load	\n"
+"	xor $7,$22,$22		# 7 cycles from $22 load	\n"
+"	xor $6,$23,$23		# 7 cycles from $23 load	\n"
+"				\n"
+"	ldq $2,24($18)		\n"
+"	xor $22,$23,$23		\n"
+"	ldq $3,24($19)		\n"
+"	xor $24,$25,$25		# 8 cycles from $25 load	\n"
+"				\n"
+"	stq $23,8($17)		\n"
+"	xor $25,$27,$27		# 8 cycles from $27 load	\n"
+"	ldq $4,24($20)		\n"
+"	xor $28,$0,$0		# 7 cycles from $0 load	\n"
+"				\n"
+"	ldq $5,24($21)		\n"
+"	xor $27,$0,$0		\n"
+"	ldq $6,32($17)		\n"
+"	ldq $7,32($18)		\n"
+"				\n"
+"	stq $0,16($17)		\n"
+"	xor $1,$2,$2		# 6 cycles from $2 load	\n"
+"	ldq $22,32($19)		\n"
+"	xor $3,$4,$4		# 4 cycles from $4 load	\n"
+"				\n"
+"	ldq $23,32($20)		\n"
+"	xor $2,$4,$4		\n"
+"	ldq $24,32($21)		\n"
+"	ldq $25,40($17)		\n"
+"				\n"
+"	ldq $27,40($18)		\n"
+"	ldq $28,40($19)		\n"
+"	ldq $0,40($20)		\n"
+"	xor $4,$5,$5		# 7 cycles from $5 load	\n"
+"				\n"
+"	stq $5,24($17)		\n"
+"	xor $6,$7,$7		# 7 cycles from $7 load	\n"
+"	ldq $1,40($21)		\n"
+"	ldq $2,48($17)		\n"
+"				\n"
+"	ldq $3,48($18)		\n"
+"	xor $7,$22,$22		# 7 cycles from $22 load	\n"
+"	ldq $4,48($19)		\n"
+"	xor $23,$24,$24		# 6 cycles from $24 load	\n"
+"				\n"
+"	ldq $5,48($20)		\n"
+"	xor $22,$24,$24		\n"
+"	ldq $6,48($21)		\n"
+"	xor $25,$27,$27		# 7 cycles from $27 load	\n"
+"				\n"
+"	stq $24,32($17)		\n"
+"	xor $27,$28,$28		# 8 cycles from $28 load	\n"
+"	ldq $7,56($17)		\n"
+"	xor $0,$1,$1		# 6 cycles from $1 load	\n"
+"				\n"
+"	ldq $22,56($18)		\n"
+"	ldq $23,56($19)		\n"
+"	ldq $24,56($20)		\n"
+"	ldq $25,56($21)		\n"
+"				\n"
+"	ldq $31,256($17)	\n"
+"	xor $28,$1,$1		\n"
+"	ldq $31,256($18)	\n"
+"	xor $2,$3,$3		# 9 cycles from $3 load	\n"
+"				\n"
+"	ldq $31,256($19)	\n"
+"	xor $3,$4,$4		# 9 cycles from $4 load	\n"
+"	ldq $31,256($20)	\n"
+"	xor $5,$6,$6		# 8 cycles from $6 load	\n"
+"				\n"
+"	stq $1,40($17)		\n"
+"	xor $4,$6,$6		\n"
+"	xor $7,$22,$22		# 7 cycles from $22 load	\n"
+"	xor $23,$24,$24		# 6 cycles from $24 load	\n"
+"				\n"
+"	stq $6,48($17)		\n"
+"	xor $22,$24,$24		\n"
+"	ldq $31,256($21)	\n"
+"	xor $24,$25,$25		# 8 cycles from $25 load	\n"
+"				\n"
+"	stq $25,56($17)		\n"
+"	subq $16,1,$16		\n"
+"	addq $21,64,$21		\n"
+"	addq $20,64,$20		\n"
+"				\n"
+"	addq $19,64,$19		\n"
+"	addq $18,64,$18		\n"
+"	addq $17,64,$17		\n"
+"	bgt $16,5b		\n"
+"				\n"
+"	ret			\n"
+"	.end xor_alpha_prefetch_5	\n"
+);
 
 static struct xor_block_template xor_block_alpha = {
 	name: "alpha",
-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

