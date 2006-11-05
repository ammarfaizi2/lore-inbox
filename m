Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161689AbWKET7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161689AbWKET7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161690AbWKET7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 14:59:06 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:29053 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161689AbWKET7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 14:59:05 -0500
Subject: Re: [PATCH 1/2] sunrpc: add missing spin_unlock
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: riesebie@lxtec.de, Akinobu Mita <akinobu.mita@gmail.com>,
       linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Olaf Kirch <okir@monad.swb.de>
In-Reply-To: <20061105114533.4f57f333.akpm@osdl.org>
References: <20061028185554.GM9973@localhost>
	 <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost>
	 <1162744516.26989.43.camel@twins>  <20061105114533.4f57f333.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 20:58:59 +0100
Message-Id: <1162756740.14695.9.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 11:45 -0800, Andrew Morton wrote:
> On Sun, 05 Nov 2006 17:35:16 +0100
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > On Sun, 2006-10-29 at 22:37 +0900, Akinobu Mita wrote:
> > > auth_domain_put() forgot to unlock acquired spinlock.
> > > 
> > > Cc: Olaf Kirch <okir@monad.swb.de>
> > > Cc: Andy Adamson <andros@citi.umich.edu>
> > > Cc: J. Bruce Fields <bfields@citi.umich.edu>
> > > Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> > > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > 
> > Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > I just found this too while trying to get .19-rc4-git up and running on
> > a machine here - took me a few hours.
> > 
> > It made my kernel decidedly unhappy :-(
> > 
> > Andrew, could you push this and:
> >   http://lkml.org/lkml/2006/11/3/109
> > into .19 still? - those patches are needed to make todays git happy on
> > my machine.
> 
> OK.

Thanks!

> I wonder if this will fix http://bugzilla.kernel.org/show_bug.cgi?id=7457

The scheduling while atomic part looks familiar, the rest not so.

Worth giving it a shot though...

On my machine it was the keventd workqueue that got messed up.
I have some patches that:
 - add debug_show_held_locks(current) to might_sleep() and schedule()
 - check in_atomic() and lockdep_depth after each workqueue function
   and print the last function executed
 - name some 'old_style_spin_init' locks

I'll post those patches after a cleanup...

