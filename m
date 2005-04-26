Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVDZJG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVDZJG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVDZJG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:06:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16589 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261408AbVDZJGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:06:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050417033806.65a5786a.sfr@canb.auug.org.au> 
References: <20050417033806.65a5786a.sfr@canb.auug.org.au>  <26687.1113576302@redhat.com> 
To: torvalds@osdl.org
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Using __user with compat_uptr_t
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 26 Apr 2005 10:06:12 +0100
Message-ID: <4872.1114506372@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I've added a couple of structures for dealing with 32-bit -> 64-bit upgrade of
NFS4 mounts. They represent the NFS4 mount information provided by userspace
and they contain some pointers to further userspace data. Should these further
userspace pointers be labelled __user?

For example, is this right?:

	struct compat_nfs_string {
		compat_uint_t len;
		compat_uptr_t __user data;
	};

Or is this right?:

	struct compat_nfs_string {
		compat_uint_t len;
		compat_uptr_t data;
	};

Now it makes no difference to the compiler, but it might affect the checker
tool.

David
