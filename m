Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWEVKdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWEVKdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWEVKdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:33:24 -0400
Received: from verein.lst.de ([213.95.11.210]:22947 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750732AbWEVKdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:33:23 -0400
Date: Mon, 22 May 2006 12:32:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, bcrl@kvack.org, cel@citi.umich.edu,
       zach.brown@oracle.com, linux-kernel@vger.kernel.org, raven@themaw.net
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write instead
Message-ID: <20060522103246.GA28133@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com> <20060521180037.3c8f2847.akpm@osdl.org> <20060522053450.GA22210@lst.de> <20060522022917.3e563261.akpm@osdl.org> <20060522023519.2541f082.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522023519.2541f082.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 02:35:19AM -0700, Andrew Morton wrote:
> The loop driver plays with file_operations.write() also.  The code should
> be reviewed and tested against filesystems which use LO_FLAGS_USE_AOPS as
> well as against those which do not, please.

The LO_FLAGS_USE_AOPS stuff is broken, please drop it from -mm.  I
explained to the RedHAt guy in detail on how to get it right.

That beeing said the bu isn't autofs using ->write directly which is
done in a lot of places but the pipe code not setting it to
do_sync_write.
