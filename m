Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVBVJSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVBVJSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBVJSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 04:18:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:24519 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262251AbVBVJSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 04:18:46 -0500
Date: Tue, 22 Feb 2005 01:18:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in
 __find_get_block_slow
Message-Id: <20050222011821.2a917859.akpm@osdl.org>
In-Reply-To: <4219BC1A.1060007@zensonic.dk>
References: <4219BC1A.1060007@zensonic.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas S. Iversen" <zensonic@zensonic.dk> wrote:
>
> But if I do
> 
>  dd if=/dev/zero of=/mnt/testfile count=N, N>6
> 
>  I get into an endless loop in __find_get_block_slow. 

The only way in which __find_get_block_slow() can loop is if something
wrecked the buffer_head ring at page->private: something caused an internal
loop via bh->b_this_page.

Are you sure that's where things are hanging?  That it's not stuck on a
spinlock?

A sysrq-P trace might help.
