Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVFEXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVFEXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVFEXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 19:09:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40321 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261628AbVFEXJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 19:09:55 -0400
Date: Sun, 5 Jun 2005 15:16:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 & latest binutils: asm-problems still there
Message-ID: <20050605181632.GA19297@logos.cnet>
References: <200506040329.j543TWV7029456@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506040329.j543TWV7029456@wildsau.enemy.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 05:29:31AM +0200, Herbert Rosmanith wrote:
> 
> good morning,
> 
> I've just tried to compile 2.4.31 and it still doesn't compile
> cleanly with the latest binutils release.
> 
> gcc -D__KERNEL__ -I/data/root/linux-2.4.31/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=process  -c -o process.o process.c
> {standard input}: Assembler messages:
> {standard input}:750: Error: suffix or operands invalid for `mov'
> {standard input}:751: Error: suffix or operands invalid for `mov'
> {standard input}:845: Error: suffix or operands invalid for `mov'
> {standard input}:846: Error: suffix or operands invalid for `mov'
> {standard input}:897: Error: suffix or operands invalid for `mov'
> {standard input}:898: Error: suffix or operands invalid for `mov'
> {standard input}:900: Error: suffix or operands invalid for `mov'
> {standard input}:912: Error: suffix or operands invalid for `mov'
> 
> alessandro suardi told me that this problem is solved using the
> patch from:
>   http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
> 
> which are dated from march (2005-03-27) and therefore, about 3 months
> old.
> 
> it's about time this gets into the official kernel. who is in charge
> of it? (it's obviously not sufficient to report to lkml).

Looks OK except that one "movl" conversion was forgotten in 
the x86-64 diff:

@@ -609,7 +609,7 @@ struct task_struct *__switch_to(struct t
 	}
 	{
 		unsigned gsindex;
-		asm volatile("movl %%gs,%0" : "=g" (gsindex)); 
+		asm volatile("movl %%gs,%0" : "=r" (gsindex)); 
 		if (unlikely((gsindex | next->gsindex) || prev->gs)) {

Who wrote the patch? 
