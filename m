Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVJBWJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVJBWJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 18:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVJBWJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 18:09:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750737AbVJBWJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 18:09:01 -0400
Date: Sun, 2 Oct 2005 15:08:29 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Christopher Li <chrisl@vmware.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: PATCH] incrase usbdevfs bulk buffer size
Message-Id: <20051002150829.35107f91.zaitcev@redhat.com>
In-Reply-To: <20051001202059.GE3453@64m.dyndns.org>
References: <20051001202059.GE3453@64m.dyndns.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2005 16:20:59 -0400, Christopher Li <chrisl@vmware.com> wrote:

> I hit this limit with running ehci in the VM. The a single ehci
> qTD transfer buffer can be 5 pages long, that is 20K. [...]

Even 16K is too much, IMHO.

> I can complicate the user space part to work around that,
> but it seems much simpler just allow usbdevfs to accept bigger buffers.

It seems, yes. However, I assure you that this is not going to
work for anyone who has anything reasonable swapped out, because
of the kmalloc().

16K is an order 2 allocation on systems with 4KB pages, such as
Opteron. It kinda sorta works, but not really.

This looks like a requirement to think about a better API. Also,
the things that Harald was trying to fix, with pids and signals,
just tell me that something was really wrong from the start.

-- Pete
