Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVIMIlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVIMIlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVIMIlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:41:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751142AbVIMIlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:41:21 -0400
Date: Tue, 13 Sep 2005 01:40:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, xemul@sw.ru,
       hugh@veritas.com
Subject: Re: [PATCH] error path in setup_arg_pages() misses
 vm_unacct_memory()
Message-Id: <20050913014008.0ee54c62.akpm@osdl.org>
In-Reply-To: <43268C21.9090704@sw.ru>
References: <4325B188.10404@sw.ru>
	<20050912132352.6d3a0e3a.akpm@osdl.org>
	<43268C21.9090704@sw.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> maybe it is worth moving vm_acct_memory() out of 
>  security_vm_enough_memory()?

I think that would be saner, yes.  That means that the callers would call
vm_acct_memory() after security_enough_memory(), if that succeeded.

