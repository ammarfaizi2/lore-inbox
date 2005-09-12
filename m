Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVILUZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVILUZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVILUZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:25:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932214AbVILUZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:25:15 -0400
Date: Mon, 12 Sep 2005 13:23:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, xemul@sw.ru,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] error path in setup_arg_pages() misses
 vm_unacct_memory()
Message-Id: <20050912132352.6d3a0e3a.akpm@osdl.org>
In-Reply-To: <4325B188.10404@sw.ru>
References: <4325B188.10404@sw.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
>  This patch fixes error path in setup_arg_pages() functions, since it 
>  misses vm_unacct_memory() after successful call of 
>  security_vm_enough_memory(). Also it cleans up error path.

Ugh.  The identifier `security_vm_enough_memory()' sounds like some
predicate which has no side-effects.  Except it performs accounting.  Hence
bugs like this.

It's a shame that you mixed a largeish cleanup along with a bugfix - please
don't do that in future.

Patch looks OK to me.  Hugh, could you please double-check sometime?
