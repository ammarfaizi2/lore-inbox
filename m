Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263472AbUEKTbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUEKTbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUEKTbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:31:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:10201 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263472AbUEKTba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:31:30 -0400
Date: Tue, 11 May 2004 12:30:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: kenneth.w.chen@intel.com, geoff@linux.jf.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511123058.7bd47df3.akpm@osdl.org>
In-Reply-To: <20040511122859.33c763ef.akpm@osdl.org>
References: <20040511121126.73f5fdeb.akpm@osdl.org>
	<200405111923.i4BJN6F17770@unix-os.sc.intel.com>
	<20040511122859.33c763ef.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> > >  del_again:
> >  >  	ret += del_timer(timer);
> >  > +	if (!ret)
> >  > +		return 0;
> >  >
> >  >  	for_each_cpu(i) {
> >  >  		base = &per_cpu(tvec_bases, i);
> > 
> > 
> >  Hehe ... , first thing we tried :-). But has problem that if timeout
> >  function is running while del_timer_sync() is called, it returns
> >  without waiting.
> 
> eh?  If del_timer() returns non-zero, that means that the timer was
> successfully deleted before it triggered.

s/non-zero/zero/
