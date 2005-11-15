Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVKOJIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVKOJIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVKOJIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:08:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751398AbVKOJIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:08:15 -0500
Date: Tue, 15 Nov 2005 09:08:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org,
       Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Allow arch to veto PC speaker beeper initialization
Message-ID: <20051115090813.GB22160@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>, vojtech@suse.cz,
	linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>
References: <17273.16792.850639.195427@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17273.16792.850639.195427@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 01:02:00PM +1100, Paul Mackerras wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> This patch provides an arch hook in the PC speaker beeper driver which
> gives the arch code an opportunity to determine whether the machine
> has an i8253 timer or not.  If it doesn't we don't want the driver to
> go poking at the i8253's ports; there might be nothing there or there
> might be something else there which would be upset by being poked at.
> 
> We want to be able to build ppc64 kernels which work both on machines
> that have an i8253 equivalent (e.g. some pSeries) and on machines that
> don't (e.g. G5 powermacs), which is why we don't just remove it from
> the config.

Wrong way around.  The architecture should provide a way to find it, not
to veto it.  It should probably use the plattform_device infrastructure.

