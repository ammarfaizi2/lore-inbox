Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVF3NpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVF3NpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVF3NpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:45:00 -0400
Received: from verein.lst.de ([213.95.11.210]:60112 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261225AbVF3Noa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:44:30 -0400
Date: Thu, 30 Jun 2005 15:44:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, cotte@de.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xip cleanups
Message-ID: <20050630134423.GA14319@lst.de>
References: <20050628120159.GA1745@lst.de> <200506281421.09893.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506281421.09893.arnd@arndb.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 02:21:09PM +0200, Arnd Bergmann wrote:
> On Dinsdag 28 Juni 2005 14:01, Christoph Hellwig wrote:> ?int> -ext2_clear_xip_target(struct inode *inode, int block) {> -???????sector_t sector = block*(PAGE_SIZE/512);> +ext2_clear_xip_target(struct inode *inode, int block)> +{> +???????sector_t sector = block * (PAGE_SIZE/512);> ????????unsigned long data;> ????????int rc;> ?> ????????rc = __inode_direct_access(inode, sector, &data);> -???????if (rc)> -???????????????return rc;> -???????clear_page((void*)data);> -???????return 0;> +???????if (!rc)> +???????????????clear_page(data);> +???????return rc;> ?}
> Did you try building it? While most of your changes areobviously correct, passing an unsigned long value to clear_pagewithout a cast isn't.

On what hardware? ;-)  Ok, that one is indeed bogus.

Btw, you mailer totally messed up the quoted part.

