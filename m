Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUI0UPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUI0UPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUI0UPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:15:32 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:15123 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267298AbUI0UPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:15:13 -0400
Date: Mon, 27 Sep 2004 21:15:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Christoph Hellwig <hch@infradead.org>,
       Antony Suter <suterant@users.sourceforge.net>,
       List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [PATCH] __VMALLOC_RESERVE export
Message-ID: <20040927211504.A27577@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tonnerre <tonnerre@thundrix.ch>,
	Antony Suter <suterant@users.sourceforge.net>,
	List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
References: <1096304623.9430.8.camel@hikaru.lan> <20040927181229.A25704@infradead.org> <20040927195510.GD17487@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927195510.GD17487@thundrix.ch>; from tonnerre@thundrix.ch on Mon, Sep 27, 2004 at 09:55:10PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Sep 27, 2004 at 06:12:29PM +0100, Christoph Hellwig wrote:
> > On Tue, Sep 28, 2004 at 03:03:43AM +1000, Antony Suter wrote:
> > > __VMALLOC_RESERVE itself is not exported but is used by something that
> > > is. This patch is against 2.6.9-rc2-bk11
> > > 
> > > This is required by the nvidia binary driver 1.0.6111
> > 
> > And the driver does absolutely nasty things it shouldn't do.  This is an
> > implementation detail that absolutely should not be exported.
> 
> NVidia isn't the only user...
> 
> Every  kernel  module  that  uses  just anything  that  uses  the  old
> __VMALLOC_RESERVE define was broken without this patch.

NVidia doesn't have a monopoly on crappy drivers, news at eleven..

__VMALLOC_RESERVE/VMALLOC_RESERVE is only used either in arch/i386 or
defined to MAXMEM whichs is also not used outside of arch/{i386,x86_64,mips}.

Doesn't exactly sounds like a published interface, heh?  Especially as there's
not sane way to use it outside memory managment code.
