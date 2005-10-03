Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVJCEKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVJCEKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVJCEKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:10:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932144AbVJCEKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:10:24 -0400
Date: Sun, 2 Oct 2005 21:10:14 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Christopher Li <usb-devel@chrisli.org>
Cc: chrisl@vmware.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: PATCH] incrase usbdevfs bulk buffer size
Message-Id: <20051002211014.195ff1c3.zaitcev@redhat.com>
In-Reply-To: <20051002193422.GH3453@64m.dyndns.org>
References: <20051001202059.GE3453@64m.dyndns.org>
	<20051002150829.35107f91.zaitcev@redhat.com>
	<20051002193422.GH3453@64m.dyndns.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005 15:34:22 -0400, Christopher Li <usb-devel@chrisli.org> wrote:

> > 16K is an order 2 allocation on systems with 4KB pages, such as
> > Opteron. It kinda sorta works, but not really.
> > 
> > This looks like a requirement to think about a better API. []
> 
> I think the API is kind of fine in this aspect. The usbdevfs should be
> able to take bigger than 16K, but the internal copy of the urb does not
> have to use kmalloc on data buffers.

You miss an important detail here, namely that single URBs do not have
a capability to transfer to a discotiguous buffer. As long as you try
to map one transfer insive VMware to one URB, one and only one kmalloc
has to be done. But if splitting the transfer is acceptable, there is
no reason to up the maximum buffer size in usbfs. But the above is IMHO
only, and perhaps I miss something as well.

-- Pete
