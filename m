Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUGDU7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUGDU7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 16:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUGDU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 16:59:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:50561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265776AbUGDU7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 16:59:51 -0400
Date: Sun, 4 Jul 2004 13:58:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: greg@kroah.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-Id: <20040704135842.48a32219.akpm@osdl.org>
In-Reply-To: <m2fz88ugrw.fsf@telia.com>
References: <m2lli36ec9.fsf@telia.com>
	<m2u0wqqdpl.fsf@telia.com>
	<20040702150819.646b6103.akpm@osdl.org>
	<20040702224720.GA7969@kroah.com>
	<20040702155945.5c375bd2.akpm@osdl.org>
	<m27jtm0z7q.fsf@telia.com>
	<20040702165132.575cba5b.akpm@osdl.org>
	<m2fz88ugrw.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> But anyway, if __bdevname() leaks a module reference it should get
>  fixed, right?

Yes.  The questions is, where's the bug?  Who should be undoing the
module_get() which happened via

	__bdevname
	->get_gendisk
	  ->kobj_lookup
	    ->ata_probe
	      ->get_disk
	        ->try_module_get

?
