Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUCDWYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUCDWYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:24:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:55684 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261978AbUCDWYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:24:39 -0500
Date: Thu, 4 Mar 2004 14:26:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rui Saraiva <rmps@joel.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm2: 3 dumps at __make_request, system freeze
Message-Id: <20040304142638.47b00812.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403042127580.28900@joel.ist.utl.pt>
References: <Pine.LNX.4.58.0403041834350.28568@joel.ist.utl.pt>
	<20040304111204.6db8bd6e.akpm@osdl.org>
	<Pine.LNX.4.58.0403042127580.28900@joel.ist.utl.pt>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Saraiva <rmps@joel.ist.utl.pt> wrote:
>
> On Thu, 4 Mar 2004, Andrew Morton wrote:
> 
> > Rui Saraiva <rmps@joel.ist.utl.pt> wrote:
> > >
> > > Yesterday I got these 3 dumps (on dmesg) while compiling (on ext3 fs) the
> > > kernel and some other userland utilities.
> >
> > Could you please add this?
> >
> > --- 25/drivers/block/ll_rw_blk.c~blk-unplug-when-max-request-queued-fix	Wed Mar  3 16:03:01 2004
> > +++ 25-akpm/drivers/block/ll_rw_blk.c	Wed Mar  3 16:03:32 2004
> 
> [CUT]
> 
> I'm still experiencing some problems with that patch applied. I was again
> compiling the kernel (no tvtime this time) and got this:
> 
> Unable to handle kernel paging request at virtual address c1810f70 printing eip:
> c02783ae
> *pde = 00006063
> *pte = 01810000
> Oops: 0000 [#1]
> PREEMPT DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[<c02783ae>]    Not tainted VLI
> EFLAGS: 00010086
> EIP is at __make_request+0x3ae/0x6a0

OK, I screwed up.  If we ended up finding a merge in the elevator, local
variable `req' in __make_request() can end up pointing at the now-freed-up
request.

Thanks.  I suggest that you disable CONFIG_DEBUG_PAGEALLOC for now - the
bug is otherwise harmless.
