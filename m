Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWCJAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWCJAff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWCJAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:35:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752129AbWCJAfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:33 -0500
Date: Thu, 9 Mar 2006 16:37:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, rolandd@cisco.com, gregkh@suse.de, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
Message-Id: <20060309163740.0b589ea4.akpm@osdl.org>
In-Reply-To: <1141949262.10693.69.camel@serpentine.pathscale.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> On Thu, 2006-03-09 at 16:01 -0800, Roland Dreier wrote:
> >     Bryan> Any idea what I should be using instead?
> > 
> > It depends what you're trying to do.  Hence my original question: why
> > are you doing SetPageReserved?
> 
> We're mapping some memory that the chip DMAs to into userspace, so that
> user processes can spin on memory locations without going through the
> kernel.  The SetPageReserved hack is an attempt to stop the VM from
> reclaiming those pages from us once a user process exits.

If your driver allocated these pages and never added them to the LRU then
the VM won't touch them.

If your driver owns the pages and has a ref on them then they won't get
freed at task exit-time.

If the app owns the pages and you're using get_user_pages() then your
driver owns the last ref on the pages.

> I realise that it's surely bogus, and I'd be thrilled to do something
> correct instead.  We've tried doing both SetPageReserved and get_page,
> but it hasn't work out too well so far.

We'd need to see a halfway decent description of the problem first ;)
