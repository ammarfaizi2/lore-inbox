Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUEHKwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUEHKwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUEHKwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:52:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:3054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264138AbUEHKwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:52:39 -0400
Date: Sat, 8 May 2004 03:52:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: manfred@colorfullife.com, davej@redhat.com, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508035206.04e14f39.akpm@osdl.org>
In-Reply-To: <20040508102823.GY17014@parcelfarce.linux.theplanet.co.uk>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<20040508102823.GY17014@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> Bzzert.  ->d_vfs_flags modifications are under dcache_lock; ->d_flags ones
>  are *not* - they are up to whatever filesystem code happens to use them.

All but one of the d_vfs_flags modifications are under ->d_lock, so I fixed
that one up, converted all the d_flags modifiers to take ->d_lock and moved
everything over to d_flags.
