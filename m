Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030876AbWKULbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030876AbWKULbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030879AbWKULbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:31:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030876AbWKULbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:31:10 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061120111712.5e399d12.akpm@osdl.org> 
References: <20061120111712.5e399d12.akpm@osdl.org>  <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 21 Nov 2006 11:28:18 +0000
Message-ID: <10106.1164108498@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Could we reduce the migration pain by leaving the work_struct as-is and
> defining a new, leaner one and then incrementally migrating stuff over to
> it?

That involves more work in the end for a number of reasons:

 (1) The more common use (I think) is the immediate, not the delayed work
     item.  One of them has to change, and it'd make sense for it to be the
     latter.

 (2) The internals of kernel/workqueue.c all refer to work_struct.  They'd all
     have to change as that'd no longer be the common bit.

 (3) All the work callback functions have to change anyway, and they have to
     be handed the most common structure as their context - assuming the third
     reduction is acceptable.

 (4) All the initialisers have to change anyway as they take one fewer
     argument - assuming the third reduction is acceptable.

It'd be more feasible if the inventors of C had included C++-style function
overloading and structure inheritance, but they didn't.

David
