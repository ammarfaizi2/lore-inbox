Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVAFDra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVAFDra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAFDra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:47:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:59603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262710AbVAFDr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:47:28 -0500
Date: Wed, 5 Jan 2005 19:47:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: drivers/mmc/wbsd.c
Message-Id: <20050105194709.590f780c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static inline void wbsd_kunmap_sg(struct wbsd_host* host)
{
	kunmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ);
}

Guys, kunmap_atomic() takes a kernel virtual address (the value which
kmap_atomic() returned).

Passing it the address of a pageframe will have unpleasant results.
