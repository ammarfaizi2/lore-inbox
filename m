Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268591AbUJPDUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268591AbUJPDUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 23:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268590AbUJPDUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 23:20:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51903 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268582AbUJPDUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 23:20:46 -0400
Date: Sat, 16 Oct 2004 04:20:44 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, akpm@osdl.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       gnb@sgi.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20041016032044.GB16153@parcelfarce.linux.theplanet.co.uk>
References: <200409271103.39913.jbarnes@engr.sgi.com> <200409291555.29138.jbarnes@engr.sgi.com> <20040930071541.GA201816@sgi.com> <Pine.LNX.4.60.0409302317590.3449@poirot.grange> <20041016003809.GA299051@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016003809.GA299051@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 05:38:09PM -0700, Jeremy Higdon wrote:
> -	(void) RD_REG_WORD(&reg->mailbox4); /* PCI posted write flush */
> +	/* Enforce mmio write ordering; see comment in qla1280_isp_cmd(). */
> +	mmiowb();

I really don't think we want a comment by every mmiowb() explaining what
it does.  We needed one by the write flush because it had two potential
meanings, and we didn't want people overoptimising it away.  But mmiowb()
is clear and unambiguous.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
