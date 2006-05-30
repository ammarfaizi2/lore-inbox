Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWE3Gfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWE3Gfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWE3Gfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:35:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29066 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932122AbWE3Gfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:35:43 -0400
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1148964741.7704.10.camel@homer>
References: <20060529212109.GA2058@elte.hu> <1148964741.7704.10.camel@homer>
Content-Type: text/plain
Date: Tue, 30 May 2006 08:35:41 +0200
Message-Id: <1148970941.3636.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 06:52 +0200, Mike Galbraith wrote:
> On Mon, 2006-05-29 at 23:21 +0200, Ingo Molnar wrote:
> > The easiest way to try lockdep on a testbox is to apply the combo patch 
> > to 2.6.17-rc4-mm3. The patch order is:
> > 
> >   http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.17-rc4.tar.bz2
> >   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/2.6.17-rc4-mm3.bz2
> >   http://redhat.com/~mingo/lockdep-patches/lockdep-combo.patch
> > 
> > do 'make oldconfig' and accept all the defaults for new config options - 
> > reboot into the kernel and if everything goes well it should boot up 
> > fine and you should have /proc/lockdep and /proc/lockdep_stats files.
> 
> Darn.  It said all tests passed, then oopsed.


does this fix it?


type->name can be NULL legitimately; all places but one check for this
already. Fix this off-by-one.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

--- linux-2.6.17-rc4-mm3-lockdep/kernel/lockdep.c.org	2006-05-30 08:32:52.000000000 +0200
+++ linux-2.6.17-rc4-mm3-lockdep/kernel/lockdep.c	2006-05-30 08:33:09.000000000 +0200
@@ -1151,7 +1151,7 @@ int count_matching_names(struct lock_typ
 	list_for_each_entry(type, &all_lock_types, lock_entry) {
 		if (new_type->key - new_type->subtype == type->key)
 			return type->name_version;
-		if (!strcmp(type->name, new_type->name))
+		if (type->name && !strcmp(type->name, new_type->name))
 			count = max(count, type->name_version);
 	}
 


