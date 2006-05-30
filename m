Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWE3MYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWE3MYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWE3MYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:24:42 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:35554 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751460AbWE3MYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:24:41 -0400
To: adilger@clusterfs.com
Cc: cmm@us.ibm.com, jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tytso@mit.edu, sct@redhat.com
Subject: Re: [UPDATE][12/24]ext3 enlarge blocksize
Message-Id: <20060530212434sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Tue, 30 May 2006 21:24:34 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On May 26, 2006, Andreas wrote:
> At least part of this patch can be included into the patch series that
> Mingming has posted to allow larger block sizes on architectures that
> support it.  This doesn't need a separate COMPAT flag itself, since
> older kernels will already refuse to mount a filesystem with 
> large blocks.

Do you mention block size?  I don't use the COMPAT flag for large block
size, but for >2G blocks.

> On May 25, 2006  21:49 +0900, sho@tnes.nec.co.jp wrote:
> > @@ -1463,11 +1463,17 @@ static int ext3_fill_super (struct super
> > +	if (blocksize > PAGE_SIZE) {
> > +		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
> > +		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
> > +		       blocksize, PAGE_SIZE, sb->s_id);
> > +		goto failed_mount;
> > +	}
> > +
> >  	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
> > -	    blocksize > EXT3_MAX_BLOCK_SIZE) {
> > +	    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {
> 
> We may as well just change EXT3_MAX_BLOCK_SIZE to be 65536, 
> because no other
> code uses this value.  It is already 65536 in the e2fsprogs.

Agree.

> 
> > -		printk(KERN_ERR 
> > -		       "EXT3-fs: Unsupported filesystem 
> blocksize %d on %s.\n",
> > -		       blocksize, sb->s_id);
> > +		printk(KERN_ERR "EXT3-fs: Unsupported 
> filesystem blocksize %d on %s.\n",
> > +				 blocksize, sb->s_id);
> 
> I'm not sure why you changed the formatting of this message 
> to now be longer
> than 80 columns.

Oops, you are right.

Thanks a lot, Andreas!


Cheers, sho


