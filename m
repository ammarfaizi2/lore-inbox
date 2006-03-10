Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCJAHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCJAHn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbWCJAHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:07:43 -0500
Received: from mx.pathscale.com ([64.160.42.68]:22666 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751262AbWCJAHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:07:42 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada1wxbdv7a.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 16:07:42 -0800
Message-Id: <1141949262.10693.69.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:01 -0800, Roland Dreier wrote:
>     Bryan> Any idea what I should be using instead?
> 
> It depends what you're trying to do.  Hence my original question: why
> are you doing SetPageReserved?

We're mapping some memory that the chip DMAs to into userspace, so that
user processes can spin on memory locations without going through the
kernel.  The SetPageReserved hack is an attempt to stop the VM from
reclaiming those pages from us once a user process exits.

I realise that it's surely bogus, and I'd be thrilled to do something
correct instead.  We've tried doing both SetPageReserved and get_page,
but it hasn't work out too well so far.

	<b

