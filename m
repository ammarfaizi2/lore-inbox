Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVGRPsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVGRPsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGRPsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:48:38 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:32170 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261533AbVGRPs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:48:26 -0400
Date: Sun, 17 Jul 2005 19:47:43 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
       suparna@in.ibm.com, tytso@mit.edu
Subject: Re: [Ext2-devel] [RFC] [PATCH 2/4]delayed allocation for ext3
Message-ID: <20050718014743.GB6427@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
	suparna@in.ibm.com, tytso@mit.edu
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com> <1121622041.4609.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121622041.4609.25.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 17, 2005  10:40 -0700, Mingming Cao wrote:
> @@ -373,6 +373,7 @@ struct ext3_inode {
>  #define EXT3_MOUNT_BARRIER		0x20000 /* Use block barriers */
>  #define EXT3_MOUNT_NOBH			0x40000 /* No bufferheads */
>  #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
> + #define EXT3_MOUNT_DELAYED_ALLOC	0xC0000 /* Delayed Allocation */

This doesn't make sense.  DELAYED_ALLOC == QUOTA | NOBH?

> +     {Opt_delayed_alloc, "delalloc"},

Is this a replacement for Alex's delalloc code?  We also use delalloc for
that code and if they are not interchangeable it will cause confusion
about which one is in use.

> +     if (test_opt(sb, DELAYED_ALLOC)) {
> +             if (!(test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)) {
> +                     printk(KERN_WARNING "EXT3-fs: Ignoring delall option - "
> +                             "its supported only with writeback mode\n");

Should be "ignoring delalloc option".
 
Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

