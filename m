Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWJBUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWJBUqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWJBUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:46:19 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:6515 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965094AbWJBUqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:46:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=CbQBh3nuNEXpb9GEFQKLscX7PcpjurTv0gBlw11dS7xLzaTMFN47KYjRBD5Eax9ex4oXL9XylJQYC5WMh1rL/+p3fUsxonobcmewUzBDk7aq/x013bYY62KB0dFPnxMHwh27/yDQCB3mPEzna67cG34lMkp1k2U7j4TUe/LLw2w=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Mon, 2 Oct 2006 13:46:11 -0700
User-Agent: KMail/1.7.1
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org>
In-Reply-To: <20061002132116.2663d7a3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021346.13135.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only downside I can think of for dropping pt_regs is that now it's harder
to just find the IRQ handler in a driver ... it's previously been all but
guaranteed that the _only_ use of that type is the IRQ logic.  The upsides
surely outweigh that.

> >  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
> >      something different depending on whether it's been supplied with a regs
> >      pointer or not.

gaak!  where did that come from?  I'll be surprised if removing
that causes any problem at all.

- Dave

