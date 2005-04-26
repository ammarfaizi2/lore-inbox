Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVDZOjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVDZOjh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDZOjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:39:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:31912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261495AbVDZOjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:39:10 -0400
Date: Tue, 26 Apr 2005 07:40:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Using __user with compat_uptr_t
In-Reply-To: <4872.1114506372@redhat.com>
Message-ID: <Pine.LNX.4.58.0504260737040.18901@ppc970.osdl.org>
References: <20050417033806.65a5786a.sfr@canb.auug.org.au>  <26687.1113576302@redhat.com>
  <4872.1114506372@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Apr 2005, David Howells wrote:
> 
> For example, is this right?:
> 
> 	struct compat_nfs_string {
> 		compat_uint_t len;
> 		compat_uptr_t __user data;
> 	};

Nope. That makes "data" itself (the compat-pointer, not the thing it
points to) be marked as being in user space, which is not right.

> Or is this right?:
> 
> 	struct compat_nfs_string {
> 		compat_uint_t len;
> 		compat_uptr_t data;
> 	};

Yes. Now, when you use "compat_ptr()" on that thing, compat_ptr() will do 
the proper thing, and results in a "void __user *", so assuming you 
convert the pointer correctly, it will always end up having the right user 
annotation.

(Except on MIPS, where compat_ptr() doesn't, but MIPS hasn't been updated 
to do any sparse checking anyway).

		Linus
