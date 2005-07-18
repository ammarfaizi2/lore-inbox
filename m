Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVGRRdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVGRRdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 13:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVGRRdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 13:33:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:44790 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261264AbVGRRc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 13:32:29 -0400
Subject: Re: [Ext2-devel] [RFC] [PATCH 2/4]delayed allocation for ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andreas Dilger <adilger@clusterfs.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
       suparna@in.ibm.com, tytso@mit.edu
In-Reply-To: <20050718014743.GB6427@schatzie.adilger.int>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
	 <1121622041.4609.25.camel@localhost.localdomain>
	 <20050718014743.GB6427@schatzie.adilger.int>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 18 Jul 2005 10:32:18 -0700
Message-Id: <1121707938.3912.10.camel@dyn9047017116.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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
> 


Ah...:-)  Badari used 0x80000 for DELAYED_ALLOC in the previous patch
(2.6.11 based).When moving those patches forward to 2.6.13-rc3, we found
the conflict with QUOTA, and obviously picked up a wrong value.

> > +     {Opt_delayed_alloc, "delalloc"},
> 
> Is this a replacement for Alex's delalloc code?  We also use delalloc for
> that code and if they are not interchangeable it will cause confusion
> about which one is in use.
> 

Okey, will think a new name for this feature to avoid confusion.  Alex's
delalloc is bond to extent tree structure so it's hard to be adopted
directly to the current ext3 layout, so, I'd say this work done by
Badari(inspired by Alex's work) is a different implementation.

> > +     if (test_opt(sb, DELAYED_ALLOC)) {
> > +             if (!(test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)) {
> > +                     printk(KERN_WARNING "EXT3-fs: Ignoring delall option - "
> > +                             "its supported only with writeback mode\n");
> 
> Should be "ignoring delalloc option".
>  
Fixed. 


Thanks for looking at this.

Mingming


