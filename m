Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274103AbRISQqp>; Wed, 19 Sep 2001 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274104AbRISQqf>; Wed, 19 Sep 2001 12:46:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35282 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274103AbRISQqU>; Wed, 19 Sep 2001 12:46:20 -0400
Date: Wed, 19 Sep 2001 10:47:41 -0600
Message-Id: <200109191647.f8JGlfs21635@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: paulus@samba.org
Cc: "Nick Piggin" <s3293115@student.anu.edu.au>, linux-kernel@vger.kernel.org,
        rgooch@ras.ucalgary.ca
Subject: Re: [2.4.10-pre11 OOPS] in do_generic_file_read
In-Reply-To: <15272.23190.629095.594202@cargo.ozlabs.ibm.com>
In-Reply-To: <000701c13ffb$785126d0$0200a8c0@W2K>
	<15272.23190.629095.594202@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:
> Nick Piggin writes:
> 
> > I got the following oops on startup while mounting the root filesystem.
> > Unfortunately there was no "Code" because of a bad EIP value. If anyone
> > would like more information or anything for me to test, please CC me.
> 
> I got something similar.  I would predict that you are using devfs.
> The problem is that devfs doesn't set inode->i_mapping->a_ops for a
> block device.  Ext2 (for instance) calls init_special_inode, and pre11
> added a line to that procedure to initialize that field.  But devfs
> doesn't use init_special_inode.
> 
> The patch below fixes the problem for me.  It may be that devfs should
> be calling init_special_inode instead, but that sets inode->i_fop as
> well and it looks like devfs sets that a bit differently.  Richard?

Correct. In devfs, I need to capture the open() method. So my fops
have devfs_open(), which in turn initialises file->f_op as required.
I've applied your patch to my tree. I'll be releasing a new patch
shortly.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
