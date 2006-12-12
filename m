Return-Path: <linux-kernel-owner+w=401wt.eu-S1750837AbWLLBh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWLLBh1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWLLBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:37:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58787 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbWLLBh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:37:26 -0500
Date: Mon, 11 Dec 2006 17:29:07 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Erik Jacobson <erikj@sgi.com>, guillaume.thouvenin@bull.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-Id: <20061211172907.305473cf.zaitcev@redhat.com>
In-Reply-To: <1165881167.24721.73.camel@localhost.localdomain>
References: <20061207232213.GA29340@sgi.com>
	<20061208192027.18a1e708.zaitcev@redhat.com>
	<20061209210913.GA15159@sgi.com>
	<20061209183409.67b54d01.zaitcev@redhat.com>
	<1165881167.24721.73.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 15:52:47 -0800, Matt Helsley <matthltc@us.ibm.com> wrote:

> 	I'm shocked memcpy() introduces 8-byte stores that violate architecture
> alignment rules. Is there any chance this a bug in ia64's memcpy()
> implementation? I've tried to read it but since I'm not familiar with
> ia64 asm I can't make out significant parts of it in
> arch/ia64/lib/memcpy.S.

The arch/ia64/lib/memcpy.S is probably fine, it must be gcc doing
an inline substitution of a well-known function.

A commenter on my blog mentioned seeing the same thing in the past.
(http://zaitcev.livejournal.com/107185.html?thread=128945#t128945)

It's possible that applying (void *) cast to the first argument of memcpy
would disrupt this optimization. But since we have a well understood
patch by Erik, which only adds a penalty of 32 bytes of stack waste
and 32 bytes of memcpy, I thought it best not to bother with heaping
workarounds.

-- Pete
