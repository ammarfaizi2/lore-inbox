Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbUCPIBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCPIBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:01:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:54738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263508AbUCPIBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:01:08 -0500
Date: Mon, 15 Mar 2004 23:28:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
Message-Id: <20040315232834.5ea11c46.akpm@osdl.org>
In-Reply-To: <20040316072327.GA2705@elte.hu>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
	<16466.57738.590102.717396@notabene.cse.unsw.edu.au>
	<16469.2797.130561.885788@notabene.cse.unsw.edu.au>
	<20040315091843.GA21587@elte.hu>
	<16470.22982.831048.924954@notabene.cse.unsw.edu.au>
	<20040315205201.7699e1c1.akpm@osdl.org>
	<20040316072327.GA2705@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > I'll have a play with your .config, see if I can reproduce it.  If not
> > I'll squeeze off -mm3 and would ask you to retest on that if poss.
> 
> i tried Neil's bzImage and it hung on a stock PC too.

Me too, with CONFIG_DEBUG_PAGEALLOC.  We had a fatal bug around that.

However it seems that Neil's machine is dying with CONFIG_DEBUG_SLAB=y,
CONFIG_DEBUG_PAGEALLOC=n, for which we have no explanation.  It seems that
we're getting use-after-free errors against the pgd's.

Maybe it was the early-x86-cpu-detection.patch bug biting in two places -
let me brew rc1-mm1 and we'll see.

