Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWAJJTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWAJJTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWAJJTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:19:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932118AbWAJJTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:19:02 -0500
Date: Tue, 10 Jan 2006 01:18:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-Id: <20060110011844.7a4a1f90.akpm@osdl.org>
In-Reply-To: <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	<d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> This arch-independent routine copies data to a memory-mapped I/O region,
>  using 32-bit accesses.  It does not guarantee access ordering, nor does
>  it perform a memory barrier afterwards.  This style of access is required
>  by some devices.

Not providing orderingor barriers makes this a rather risky thing to export
- people might use it, find their driver "works" on one architecture, but
fails on another.

I guess the "__" is a decent warning of this, and the patch anticipates a
higher-level raw_memcpy_toio32() which implements those things, yes?

How come __raw_memcpy_toio32() is inlined?
