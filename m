Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJWJoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJWJoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 05:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUJWJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 05:44:18 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:33035 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263818AbUJWJoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:44:17 -0400
Date: Sat, 23 Oct 2004 10:44:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: getting rid of inter_module_xx
Message-ID: <20041023094413.GA30137@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e473391041022100835da7baf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391041022100835da7baf@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 01:08:08PM -0400, Jon Smirl wrote:
> I'm looking at getting rid of DRM's use of inter_module_xx. DRM makes
> use of this to locate and use the AGP module. AGP is an optional
> module since some system only have PCI graphics.
> 
> Right now DRM uses inter_module_get("AGP") to locate the module if it
> exists. It then changes behavior if this call secedes or fails.
> 
> If I remove inter_module_get("AGP") and use the symbols directly, such
> as agp_backend_acquire(), how do I resolve the symbol link when AGP is
> not loaded? If the symbols link as NULL DRM will see that and act
> correctly.

not at all.  Everything else in the kernel is compile-time depencies.
Just make the agp backend module mandatory if CONFIG_AGP is set, you'll
lose tons of complexity at a minimum amount of used memory, and as an
added benefit look like the rest of the kernel.

