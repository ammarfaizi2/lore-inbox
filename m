Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVBVNmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVBVNmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVBVNmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:42:10 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:9993 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262308AbVBVNmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:42:04 -0500
Message-ID: <1109079718.421b36a621d16@webmail.tu-harburg.de>
Date: Tue, 22 Feb 2005 14:41:58 +0100
From: Jan Blunck <j.blunck@tu-harburg.de>
To: Alex Tomas <alex@clusterfs.com>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] pdirops: vfs patch
References: <1109073273.421b1d7923204@webmail.tu-harburg.de> <m3vf8kx0ll.fsf@bzzz.home.net> <1109077222.421b2ce6739f8@webmail.tu-harburg.de> <m3r7j8wwy2.fsf@bzzz.home.net>
In-Reply-To: <m3r7j8wwy2.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Tomas <alex@clusterfs.com>:

> >>>>> Jan Blunck (JB) writes:
>
>  JB> i_sem does NOT protect the dcache. Also not in real_lookup(). The lock
> must be
>  JB> acquired for ->lookup() and because we might sleep on i_sem, we have to
> get it
>  JB> early and check for repopulation of the dcache.
>
> dentry is part of dcache, right? i_sem protects dentry from being
> returned with incomplete data inside, right?
>

Nope, d_alloc() is setting d_flags to DCACHE_UNHASHED. Therefore it is not found
by __d_lookup() until it is rehashed which is implicit done by ->lookup().

Jan
