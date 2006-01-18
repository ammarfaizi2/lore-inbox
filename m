Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWARFEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWARFEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWARFEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:04:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbWARFEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:04:22 -0500
Date: Tue, 17 Jan 2006 21:03:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       dwmw2@infradead.org
Subject: Re: [PATCH] pepoll_wait ...
Message-Id: <20060117210318.1f4212f0.akpm@osdl.org>
In-Reply-To: <43CDC21C.7050608@redhat.com>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
	<43CDC21C.7050608@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> Davide Libenzi wrote:
> > The attached patch implements the pepoll_wait system call, that extend
> > the event wait mechanism with the same logic ppoll and pselect do. The
> > definition of pepoll_wait is: [...]
> 
> I definitely ACK this patch, it's needed for the same reasons we need
> pselect and ppoll.
> 

It busts most architectures.

fs/eventpoll.c: In function `sys_pepoll_wait':
fs/eventpoll.c:727: error: `TIF_RESTORE_SIGMASK' undeclared (first use in this function)

It seems that the preferred way to fix this is to sprinkle #ifdef
TIF_RESTORE_SIGMASK all over the code.

