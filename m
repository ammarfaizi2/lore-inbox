Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUJCUDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUJCUDI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUJCUDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:03:07 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:63446 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S268104AbUJCUDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:03:04 -0400
Date: Mon, 04 Oct 2004 05:03:20 +0900 (JST)
Message-Id: <20041004.050320.78713249.taka@valinux.co.jp>
To: trond.myklebust@fys.uio.no
Cc: marcelo.tosatti@cyclades.com, iwamoto@valinux.co.jp, haveblue@us.ibm.com,
       akpm@osdl.org, linux-mm@kvack.org, piggin@cyberone.com.au,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] memory defragmentation to satisfy high order allocations
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1096831287.9667.61.camel@lade.trondhjem.org>
References: <20041003140723.GD4635@logos.cnet>
	<20041004.033559.71092746.taka@valinux.co.jp>
	<1096831287.9667.61.camel@lade.trondhjem.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Pages for NFS also might be pinned with network problems.
> > One of the ideas is to restrict NFS to allocate pages from
> > specific memory region, sot that all memory except the region
> > can be hot-removed. And it's possible to implementing whole
> > migrate_page method, which may handled stuck pages.
> 
> Why do you want to special-case this?
>
> The above is a generic condition: any filesystem can suffer from the
> equivalent problem of a failure or slow response in the underlying
> device. Making an NFS-specific hack is just counter-productive to
> solving the generic problem.

However, while network is down network/cluster filesystems might not
release pages forever unlike in the case of block devices, which may
timeout or returns a error in case of failure.

Each filesystem can control what the migration code does.
If it doesn't have anything to help memory migration, it's possible
to wait for the network coming up before starting memory migration,
or give up it if the network happen to be down. That's no problem.

Thank you,
Hirokazu Takahashi.

