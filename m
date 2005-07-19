Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVGSAc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVGSAc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 20:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGSAc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 20:32:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:29392 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261763AbVGSAcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 20:32:39 -0400
Subject: Re: [Ext2-devel] [RFC] [PATCH 2/4]delayed allocation for ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Mingming Cao <cmm@us.ibm.com>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, suparna@in.ibm.com, tytso@mit.edu
In-Reply-To: <20050718014743.GB6427@schatzie.adilger.int>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
	 <1121622041.4609.25.camel@localhost.localdomain>
	 <20050718014743.GB6427@schatzie.adilger.int>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Jul 2005 17:25:13 -0700
Message-Id: <1121732713.6025.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 19:47 -0600, Andreas Dilger wrote:
> On Jul 17, 2005  10:40 -0700, Mingming Cao wrote:
> > @@ -373,6 +373,7 @@ struct ext3_inode {
> >  #define EXT3_MOUNT_BARRIER		0x20000 /* Use block barriers */
> >  #define EXT3_MOUNT_NOBH			0x40000 /* No bufferheads */
> >  #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
> > + #define EXT3_MOUNT_DELAYED_ALLOC	0xC0000 /* Delayed Allocation */
> 
> This doesn't make sense.  DELAYED_ALLOC == QUOTA | NOBH?

My fault. I will fix it.

> 
> > +     {Opt_delayed_alloc, "delalloc"},
> 
> Is this a replacement for Alex's delalloc code?  We also use delalloc for
> that code and if they are not interchangeable it will cause confusion
> about which one is in use.
> 

Well, basically "delalloc" concept is same - whether we use it on
current ext3 layout or with new extent layout doesn't matter.


> > +     if (test_opt(sb, DELAYED_ALLOC)) {
> > +             if (!(test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)) {
> > +                     printk(KERN_WARNING "EXT3-fs: Ignoring delall option - "
> > +                             "its supported only with writeback mode\n");
> 
> Should be "ignoring delalloc option".

Yep.

Thanks,
Badari



