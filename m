Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVLARVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVLARVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVLARVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:21:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6824 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932347AbVLARVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:21:48 -0500
Subject: Re: Better pagecache statistics ?
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1133457315.21429.29.camel@localhost.localdomain>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
	 <1133452790.27824.117.camel@localhost.localdomain>
	 <1133453411.2853.67.camel@laptopd505.fenrus.org>
	 <20051201170850.GA16235@dmt.cnet>
	 <1133457315.21429.29.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 18:21:39 +0100
Message-Id: <1133457700.2853.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 09:15 -0800, Badari Pulavarty wrote:
> > Most of the issues you mention are null if you move the stats
> > maintenance burden to userspace. 
> > 
> > The performance impact is also minimized since the hooks 
> > (read: overhead) can be loaded on-demand as needed.
> > 
> 
> The overhead is - going through each mapping/inode in the system
> and dumping out "nrpages" - to get per-file statistics. This is
> going to be expensive, need locking and there is no single list 
> we can traverse to get it. I am not sure how to do this.

and worse... you're going to need memory to store the results, either in
kernel or in userspace, and you don't know how much until you're done.
That memory is going to need to be allocated, which in turn changes the
vm state..


