Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbULGQVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbULGQVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbULGQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:21:42 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:16565 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261854AbULGQVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:21:21 -0500
Subject: Re: Bug in kmem_cache_create with duplicate names
From: Steven Rostedt <rostedt@goodmis.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <41B5CD41.9050102@osdl.org>
References: <1102434056.25841.260.camel@localhost.localdomain>
	 <41B5CD41.9050102@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 07 Dec 2004 11:21:16 -0500
Message-Id: <1102436476.25841.265.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 07:33 -0800, Randy.Dunlap wrote:

> Duplicate name can just return NULL.  NOTE:  Such a change most
> likely requires an audit of all callers of kmem_cache_create()
> to be sure that they check its return value.  There's a gcc
> attribute that can be added to the function prototype to
> warn if the function is called without looking at its
> return value, although just doing
> 	x = kmem_cache_create(...);
> and ignoring x probably evades the warning.
> 

I would hope that the kernel does check the return, since it still can
fail for other reasons an return a NULL, and it is more likely to fail
for other reasons, since this will already BUG on the duplicate case.
But your suggestion is probably a good one, and I'm sure there are
probably other calls that should have that same check.

-- Steve
