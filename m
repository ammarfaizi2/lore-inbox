Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268537AbUILJI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbUILJI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268541AbUILJI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:08:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:24552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268537AbUILJIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:08:55 -0400
Date: Sun, 12 Sep 2004 02:06:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: kaigai@ak.jp.nec.com, hugh@veritas.com, wli@holomorphy.com,
       takata.hirokazu@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_inc_return() for i386[1/5] (Re:
 atomic_inc_return)
Message-Id: <20040912020641.4bce3ce2.akpm@osdl.org>
In-Reply-To: <20040912082538.GA87823@muc.de>
References: <Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain>
	<200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp>
	<20040911160532.07216174.akpm@osdl.org>
	<20040912082538.GA87823@muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Sat, Sep 11, 2004 at 04:05:32PM -0700, Andrew Morton wrote:
> > kaigai@ak.jp.nec.com (Kaigai Kohei) wrote:
> > >
> > > 
> > > [1/5] atomic_inc_return-linux-2.6.9-rc1.i386.patch
> > >   This patch implements atomic_inc_return() and so on for i386,
> > >   and includes runtime check whether CPU is legacy 386.
> > >   It is same as I posted to LKML and Andi Kleen at '04/09/01.
> > > 
> > 
> > Can we not use the `alternative instruction' stuff to eliminate the runtime
> > test?
> 
> Yes, we could. I suggested this to Kaigai-san earlier, but
> he decided that it was too complicated because he would have needed
> to add an additional alternative() macro with enough parameters.
> 
> Given that atomic instructions are quite costly anyways and the jump
> should be very predictable he's probably right that it wouldn't 
> be worth the effort. 
> 

Hm.  Well if these things only have a few callsites then OK.  But if we go
and do something like implementing atomic_inc() or up_read() or whatever
with atomic_add_return() then we'd need to do something from a codesize
POV.

