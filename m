Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVAQMPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVAQMPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 07:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVAQMO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 07:14:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262779AbVAQMO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 07:14:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050116115841.GB13716@lst.de> 
References: <20050116115841.GB13716@lst.de> 
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] switch frw to use local_soft_irq_pending 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 17 Jan 2005 12:14:37 +0000
Message-ID: <20621.1105964077@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@lst.de> wrote:

> The newly merged frv do_IRQ code calls softirq_pending(), but always with
> the current cpu as argument - switch to local_softirq_pending().
> 
> Btw, this usage look bogus to me, any reason you need to call do_softirq
> again after you did four lines above in irq_exit(), David?

Because irq_exit() doesn't call do_softirq() in 2.4 where I developed this
arch in the first place. And because 2.6 didn't malfunction due to
do_softirq() being called twice, I didn't notice.

Actually... it's probably also bad that it calls irq_exit() first and then
__clr_MASK(). That means it runs softirq processing with at least one
interrupt level disabled:-/

David
