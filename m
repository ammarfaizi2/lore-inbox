Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVCNK2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVCNK2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVCNK2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:28:54 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:60955 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262096AbVCNK2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:28:52 -0500
Date: Fri, 11 Mar 2005 23:24:28 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/5] audit mips fix
Message-ID: <20050311232428.GA4402@linux-mips.org>
References: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net> <20050310171429.GB26269@linux-mips.org> <20050311095839.77d7a350.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311095839.77d7a350.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 09:58:39AM +0900, Yoichi Yuasa wrote:

> > > Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> > > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > 
> > > @@ -307,7 +308,7 @@ asmlinkage void do_syscall_trace(struct 
> > >  {
> > >  	if (unlikely(current->audit_context)) {
> > >  		if (!entryexit)
> > > -			audit_syscall_entry(current, regs->orig_eax,
> > > +			audit_syscall_entry(current, regs->regs[2],
> > 
> > Wrong.  regs[2] can will contain the syscall return value and can be
> > modified by ptrace also.
> 
> Thank you for your comment,
> I consider a good way based on your comment. 
> 
> Do you already have a good idea?

Basically do what x86 did, keep a copy of the the original regs[2] around.
The only potencial problem with this approach is debuggers might be
affected so I want to look into that first.

  Ralf
