Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVCJMuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVCJMuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVCJMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:50:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262578AbVCJMuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:50:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050310042217.3ba5b9bc.akpm@osdl.org> 
References: <20050310042217.3ba5b9bc.akpm@osdl.org>  <4181.1110456111@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Discard key spinlock and use RCU for key payload [try #3] 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 10 Mar 2005 12:50:08 +0000
Message-ID: <5005.1110459008@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> What's with the preempt_enable()/disable() added to __key_link()?  It's not
> obvious what is being protected from what, and why.

Ummm... Yes... They're probably not necessary. A wmb() may be required after
the klist->nkeys++ to commit to memory the fact there's now an extra key link
available, but I'm not sure that it's necessary.

Do you want me to redo the patch?

David
