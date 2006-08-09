Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWHIQKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWHIQKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWHIQKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:10:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751101AbWHIQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:10:50 -0400
Date: Wed, 9 Aug 2006 17:10:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Smith <dsmith@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060809161039.GA30856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Smith <dsmith@redhat.com>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org, shemminger@osdl.org
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:01:45AM -0500, David Smith wrote:
> > +	if (p->symbol_name) {
> > +		if (p->addr)
> > +			return -EINVAL;
> > +		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
> > +	}
> 
> What if kprobe_lookup_name() fails

for that case we need the check in your snipplet below.

> or if CONFIG_KALLSYMS isn't set?

I think we should just disallow that case.  having kprobes without kallsyms
is rather pointless.  I'll send a patch to add the dependency to the Kconfig
files.

> Perhaps this needs something like:
> 
> 	if (p->symbol_name) {
> 		if (p->addr)
> 			return -EINVAL;
> 		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
> 		if (p->addr == p->offset)
> 			return -EINVAL;
> 	}
