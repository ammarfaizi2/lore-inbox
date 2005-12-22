Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVLVFFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVLVFFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVLVFFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 00:05:54 -0500
Received: from mverd138.asia.info.net ([61.14.31.138]:5711 "EHLO
	kao2.melbourne.sgi.com") by vger.kernel.org with ESMTP
	id S965047AbVLVFFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 00:05:53 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2 - kzalloc() considered harmful for debugging. 
In-reply-to: Your message of "Mon, 19 Dec 2005 02:20:59 -0800."
             <20051219022059.36443421.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Dec 2005 16:05:42 +1100
Message-ID: <31970.1135227942@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005 02:20:59 -0800, 
Andrew Morton <akpm@osdl.org> wrote:
>Or we could special-case kzalloc() and kstrdup() in slab.c - use
>builtin_return_address(1) if builtin_return_address(0) is within those
>functions.  Dunno if that's worth the fuss though.

builtin_return_address(1) on i386 only works with stack frame pointers.
Without stack frame pointers, builtin_return_address(1) gets garbage.
builtin_return_address(0) is the only value that is guaranteed to work
with and without stack frame pointers.

Even with frame pointers, tail recursion confuses builtin_return_address(1)
on i386.

