Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUHCWmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUHCWmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUHCWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:42:31 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:25476 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266901AbUHCWm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:42:28 -0400
Date: Wed, 4 Aug 2004 00:42:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803224200.GO2241@dualathlon.random>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random> <20040803213856.GB10978@devserv.devel.redhat.com> <20040803215150.GM2241@dualathlon.random> <20040803150118.Q1924@build.pdx.osdl.net> <20040803221121.GN2241@dualathlon.random> <20040803153335.R1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803153335.R1924@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 03:33:35PM -0700, Chris Wright wrote:
> I just mean in general the only time it's valid to drop the binding
> (which includes dropping refcount on the user struct) should be when
> the object is destroyed.

yep, agreed.

> > Maybe it's just that those are incremental patches and I'm missing the
> > other part of the patch, but reading those patches I can't see where the
> > user_subtract_mlock happens when I truncate an hugetlbfs file (or delete
> > it or whatever). Sure it can't be munlock releasing/_updating_ the user-struct
> > accounting for fs persistent storage. But if other code takes care of it
> > then maybe you want to delete the user_subtract_mlock function and use
> > the other piece that already existed for truncate.
> 
> Heh, yeah in a place like hugetlb_put_quota?

yep. that's the kind of function I was looking for to update/release the
accounting, but it's not there, and sure it wasn't there in the previous
patch either.
