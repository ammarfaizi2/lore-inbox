Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWHHPmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWHHPmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWHHPmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:42:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964969AbWHHPmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:42:36 -0400
Subject: Re: [PATCH] module interface improvement for kprobes
From: David Smith <dsmith@redhat.com>
To: ananth@in.ibm.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
In-Reply-To: <20060807045213.GA12898@in.ibm.com>
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
	 <20060804155711.GA13271@infradead.org>  <20060807045213.GA12898@in.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 10:39:18 -0500
Message-Id: <1155051558.21699.26.camel@dhcp-2.hsv.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 10:22 +0530, Ananth N Mavinakayanahalli wrote:
> On Fri, Aug 04, 2006 at 04:57:11PM +0100, Christoph Hellwig wrote:

... stuff deleted ...

> > That beeing said we should probably change the kprobes interface to
> > automatically do the kallsysms name lookup for the caller.  It would simplify
> > the kprobes interface and allow us to get rid of the kallsyms_lookup_name
> > export that doesn't have a valid use except for kprobes.  With
> > that change the example kprobe would look like:
> 
> This sounds like a good idea. How about we still allow .addr atleast for
> users who know what they are doing and would want to just specify a text
> addr?
> 
> > static struct kprobe kp = {
> 	.addr		= <addr>
> 
> > 	.pre_handler	= handler_pre,
> > 	.post_handler	= handler_post,
> > 	.fault_handler	= handler_fault,
> > 	.symbol_name	= "do_fork",
> > };
> 
> The symbol_name lookup can then be done when only when .addr is non-NULL.
> 
> That said, I have a working patch I was planning to post today that
> introduces the KPROBE_ADDR macro that abstracts out the architecture-specific
> artefacts of getting the actual text address to probe, so kprobe modules
> can be made more portable. I was envisaging this to be used by the module
> writer, but with your idea, this could live in-kernel itself.
> 
> I'll cook up a patch for this in a short while.
> 
> Ananth

This does seem reasonable, so I'll abandon my patch and wait for the new
kprobes interface.

Ananth, thanks for helping out.

-- 
David Smith
dsmith@redhat.com
Red Hat, Inc.
http://www.redhat.com
256.217.0141 (direct)
256.837.0057 (fax)


