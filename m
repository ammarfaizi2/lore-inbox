Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVCPSKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVCPSKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVCPSKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:10:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21717 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262719AbVCPSKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:10:44 -0500
Date: Wed, 16 Mar 2005 18:10:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Message-ID: <20050316181042.GA26788@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, kurt@garloff.de,
	Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <20050316143130.GA21959@infradead.org> <Pine.LNX.4.61.0503160959530.4104@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503160959530.4104@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 10:01:07AM -0500, Rik van Riel wrote:
> In the case of AGP, the AGPGART effectively _is_ the
> IOMMU.  Calculating the addresses right for programming
> the AGPGART is probably worth fixing.

Well, it's a half-assed one.  And some systems have a real one.

But the real problem is that virt_to_bus doesn't exist at all
on architectures like ppc64, and this patch touches files like
generic.c and backend.c that aren't PC-specific.   So you
effectively break agp support for them.

