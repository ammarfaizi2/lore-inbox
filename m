Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWEITDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWEITDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWEITDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:03:21 -0400
Received: from verein.lst.de ([213.95.11.210]:64995 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750829AbWEITDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:03:20 -0400
Date: Tue, 9 May 2006 21:03:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-ID: <20060509190310.GA19124@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com> <20060509120105.7255e265.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509120105.7255e265.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:01:05PM -0700, Andrew Morton wrote:
> Together these three patches shrink the kernel by 113 lines.  I don't know
> what the effect is on text size, but that's a pretty modest saving, at a
> pretty high risk level.
> 
> What else do we get in return for this risk?

there's another patch ontop which I didn't bother to redo until this is
accepted which kills a lot more code.  After that filesystems only have
to implement one method each for all kinds of read/write calls.  Which
allows to both make the mm/filemap.c far less complex and actually
understandable aswell as for any filesystem that uses more complex
read/write variants than direct filemap.c calls.  In addition to these
simplification we also get a feature (async vectored I/O) for free.

