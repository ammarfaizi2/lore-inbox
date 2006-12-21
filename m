Return-Path: <linux-kernel-owner+w=401wt.eu-S1422924AbWLUJRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbWLUJRR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWLUJRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:17:13 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:2409 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422910AbWLUJRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:17:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CJAMkzy2gyVzjU/mDodJUlxudAKh0+3lUWTZxEtQc437LCbfLq7942MdVDBroVtncBZ5Wy7jXBS6D0fumJ84zv7Sv8oSQg5H0O9Lc6ivJnst48GkDUu42c1s/j72PM92eih/j/a37+jw6Abp2TdItINmHLvYxF47OYuXkUVJSx0=
Message-ID: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
Date: Thu, 21 Dec 2006 02:17:05 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Martin Michlmayr" <tbm@cyrius.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Andrei Popa" <andrei.popa@i-neo.ro>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Heiko Carstens" <heiko.carstens@de.ibm.com>,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Linus Torvalds <torvalds@osdl.org> wrote:

> That said, I think the patch I sent out should actually work on top of
> plain 2.6.19 too. I don't think things have changed in this area that
> much. IOW, you don't _need_ latest -git to test it, you just need a broken
> kernel ;)

I created a version of your patch that applied to 2.6.19, but it
doesn't compile:

mm/built-in.o: In function `cancel_dirty_page':
slab.c:(.text+0x8964): undefined reference to `task_io_account_cancelled_write'
make[3]: *** [.tmp_vmlinux1] Error 1

It looks like task_io_account_cancelled_write() was added in

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7c3ab7381e79dfc7db14a67c6f4f3285664e1ec2

Can the call to task_io_account_cancelled_write() simply be removed
from cancel_dirty_page() for testing the patch with 2.6.19 (since
2.6.19 doesn't seem to have the task I/O accounting) ?

Gordon

-- 
Gordon Farquharson
