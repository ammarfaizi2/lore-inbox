Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTIGMm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIGMm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 08:42:58 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:60817 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S261170AbTIGMmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 08:42:54 -0400
Date: Sun, 7 Sep 2003 14:42:51 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907124251.GC5460@pengutronix.de>
References: <20030907112813.GQ14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030907112813.GQ14436@fs.tum.de>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19vysJ-0000Dp-00*AwY57J4R/uI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 01:28:13PM +0200, Adrian Bunk wrote:
> The patch below tries to implement a better i386 CPU selection.

Did you look at how rmk does CPU selection in the ARM tree? He has
developed a very sophisticated scheme as there are lots of completely
different cpu implementations, using a few cores. It might be an idea to
make the schemes more uniform than they are now. 

> There are two different needs:
> 1. the installation kernel of a distribution should support all CPUs 
>    this distribution supports (perhaps starting with the 386)

Ack. 

> 2. a sysadmin might e.g. want a kernel that support both a Pentium-III
>    and a Pentium 4, but doesn't need to support a 386

Ack. 

3. Embedded forlks might want to make a kernel which has support for
exactly the used processor and nothing more. 

> Changes:
[...]
> - AMD Elan is a different subarch, you can't configure a kernel that 
>   runs on both the AMD Elan and other i386 CPUs

Ack. Same with for example Geode. And the subarchs might have different
implementations, like Elan SC400, Elan SC410, Elan SC520. 

> - @Robert:
>   there were no Elan CFLAGS in arch/i386/Makefile???

That seems to have evolved since I last touched the Elan stuff. The
Elans are more or less 486 cores with some edges, so adding -march=i486
should be ok. 

> - which CPUs exactly need X86_ALIGNMENT_16?

I've just copied that from 486. 

> A 2.6.0-test4-mm5 kernel with this patch applied compiled and bootet on
> my PC.

I could do some tests on an Elan board, but not earlier than end of next
week as I'm out of office for some days...

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
