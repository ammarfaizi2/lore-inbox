Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751029AbWFENNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWFENNv (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWFENNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:13:51 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49803 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750788AbWFENNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:13:50 -0400
Date: Mon, 5 Jun 2006 15:13:11 +0200
From: Johann Lombardi <johann.lombardi@bull.net>
To: Andreas Dilger <adilger@clusterfs.com>, sho@tnes.nec.co.jp
Cc: cmm@us.ibm.com, jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][12/24]ext3 enlarge blocksize
Message-ID: <20060605131311.GB2606@chiva>
References: <20060525214902sho@rifu.tnes.nec.co.jp> <20060526120032.GN5964@schatzie.adilger.int>
MIME-Version: 1.0
In-Reply-To: <20060526120032.GN5964@schatzie.adilger.int>
User-Agent: Mutt/1.5.11+cvs20060403
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/06/2006 15:17:20,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/06/2006 15:17:22,
	Serialize complete at 05/06/2006 15:17:22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 06:00:32AM -0600, Andreas Dilger wrote:
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
> We may as well just change EXT3_MAX_BLOCK_SIZE to be 65536, because no other
> code uses this value.  It is already 65536 in the e2fsprogs.

AFAICS, ext3_dir_entry_2->rec_len will overflow with a 64kB blocksize.
Do you know how ext2 handles this?

Cheers,

Johann
