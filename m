Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVBVNAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVBVNAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVBVNAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:00:37 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:57200 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262288AbVBVNAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:00:30 -0500
Message-ID: <1109077222.421b2ce6739f8@webmail.tu-harburg.de>
Date: Tue, 22 Feb 2005 14:00:22 +0100
From: Jan Blunck <j.blunck@tu-harburg.de>
To: Alex Tomas <alex@clusterfs.com>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
References: <1109073273.421b1d7923204@webmail.tu-harburg.de> <m3vf8kx0ll.fsf@bzzz.home.net>
In-Reply-To: <m3vf8kx0ll.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Tomas <alex@clusterfs.com>:

> >>>>> Jan Blunck (JB) writes:
>
>  >> 1) i_sem protects dcache too
>
>  JB> Where? i_sem is the per-inode lock, and shouldn't be used else.
>
> read comments in fs/namei.c:read_lookup()
>

i_sem does NOT protect the dcache. Also not in real_lookup(). The lock must be
acquired for ->lookup() and because we might sleep on i_sem, we have to get it
early and check for repopulation of the dcache.

> we've already done this for ext3. it works.
> it speeds some loads up significantly.
> especially on big directories.
> and you can control this via mount option,
> so almost zero cost for fs that doesn't support pdirops.

Ok.

Jan
