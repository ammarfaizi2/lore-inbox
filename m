Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUEYWvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUEYWvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUEYWvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:51:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265115AbUEYWvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:51:43 -0400
Date: Tue, 25 May 2004 19:53:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "David S. Miller" <davem@redhat.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>, doug@easyco.com,
       linux-kernel@vger.kernel.org, cramerj@intel.com, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, jgarzik@pobox.com
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Message-ID: <20040525225308.GA5344@logos.cnet>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF618C@orsmsx402.amr.corp.intel.com> <20040525144759.0e51cfd9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525144759.0e51cfd9.davem@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:47:59PM -0700, David S. Miller wrote:
> On Tue, 25 May 2004 14:20:23 -0700
> "Feldman, Scott" <scott.feldman@intel.com> wrote:
> 
> > Marcelo Tosatti wrote:
> > 
> > > It seems we are calling alloc_skb(GFP_KERNEL) from inside an 
> > > interrupt handler. Oops. 
> > 
> > We're calling dev_alloc_skb() from hard interrupt context, but it uses
> > GFP_ATOMIC, not GFP_KERNEL, so this is OK, right?  I don't see the
> > problem with e1000.
> 
> Neither do I, where is the detailed backtrace of this GFP_KERNEL
> allocation supposedly from interrupt context?

That was just a very wrong guess, I must admit. 

Actually what seems to be happening is an e1000 IRQ while 
trying to free memory (shrink_caches()) which tries to 
allocate more memory. 

Locked caused by extremely high load it seems.

You know better than me.
