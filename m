Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWELNQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWELNQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWELNQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:16:56 -0400
Received: from duch.mimuw.edu.pl ([193.0.96.2]:1944 "EHLO duch.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751277AbWELNQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:16:56 -0400
Date: Fri, 12 May 2006 15:16:54 +0200
From: Tomasz Malesinski <tmal@mimuw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Segfault on the i386 enter instruction
Message-ID: <20060512131654.GB2994@duch.mimuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code attached below segfaults on the enter instruction. It works
when a stack frame is created by the three commented out
instructions and also when the first operand of the enter instruction
is small (less than about 6500 on my system).

AFAIK, the only difference between creating a stack frame with the
enter instruction or push/mov/sub is that enter checks if the new
value of esp is inside the stack segment limit.

I tested it on a vanilla kernel 2.4.26 on Intel Celeron and also on
probably non-vanilla 2.6.16.13 running on 3 dual core AMD Opteron,
quite busy, server. It is working in 32-bit mode. Interestingly, on
the second machine sometimes the program worked correctly.

I am not subscribed to the list. Please cc replies to me.


	.file	"a.c"
	.version	"01.01"
gcc2_compiled.:
.section	.rodata
.LC0:
	.string	"asdf\n"
.text
	.align 4
.globl main
	.type	 main,@function
main:
	enter $10008, $0
#	pushl %ebp
#	movl %esp,%ebp
#	subl $10008,%esp
	addl $-12,%esp
	pushl $.LC0
	call printf
	addl $16,%esp
.L2:
	leave
	ret
.Lfe1:
	.size	 main,.Lfe1-main
	.ident	"GCC: (GNU) 2.95.4 20011002 (Debian prerelease)"

-- 
Tomek Malesinski
