Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVADKro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVADKro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVADKrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:47:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63372 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261607AbVADKrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:47:33 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <28707.1104722227@ocs3.ocs.com.au> 
References: <28707.1104722227@ocs3.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Jim Nelson <james4765@cwazy.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy? 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Tue, 04 Jan 2005 10:46:45 +0000
Message-ID: <2583.1104835605@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens <kaos@ocs.com.au> wrote:

> >That kind of garbled output has been known to happen, but
> >the <console_sem> is supposed to prevent that (along with
> >zap_locks() in kernel/printk.c).
> 
> Using multiple calls to printk to print a single line has always been
> subject to the possibility of interleaving on SMP.  We just live with the
> risk. Printing a complete line in a single call to printk is protected by
> various locks.  Print a line in multiple calls is not protected.  If it
> bothers you that much, build up the line in a local buffer then call printk
> once.

The oops writer breaks the locks. It's _really_ annoying when oopses happen
simultaneously on separate CPUs - the oops reports end up interleaved
char-by-char.

My patch serialised oops writing.

David
