Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWE3TRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWE3TRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWE3TRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:17:07 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:2225 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932433AbWE3TRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:17:06 -0400
Date: Tue, 30 May 2006 13:17:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp, "Stephen C. Tweedie" <sct@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       jitendra@linsyssoft.com, cmm@us.ibm.com
Subject: Re: [UPDATE][13/24]ext3 enlarge file size
Message-ID: <20060530191707.GK5964@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp,
	"Stephen C. Tweedie" <sct@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	jitendra@linsyssoft.com, cmm@us.ibm.com
References: <20060530212540sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530212540sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2006  21:25 +0900, sho@tnes.nec.co.jp wrote:
> > >  	/* This constant is calculated to be the largest file size for a
> > >  	 * dense, 4k-blocksize file such that the total number of
> > >  	 * sectors in the file, including data and all indirect blocks,
> > >  	 * does not exceed 2^32. */
> > > +	if (sizeof(blkcnt_t) < sizeof(u64)) {
> > > +		upper_limit = 0x1ff7fffd000LL;
> > > +	}
> > > +	/* With CONFIG_LSF on, file size is limited to blocksize*(4G-1) */
> > > +	else { 
> > > +		upper_limit = (1LL << (bits + 32)) - (1LL << bits);
> > > +	}
> > 
> > This doesn't take into account that there will be some number of extra
> > blocks on the file for {dt}indirect blocks.  There was some discussion
> > among ext3 developers to use another field in the inode to allow the
> > i_blocks count to grow up to 2^48 bits in conjunction with this
> > patch, which will remove any worry about additional metadata blocks
> > and also allow future growth without yet another COMPAT flag.
> 
> I'm considering using l_i_frag and l_i_fsize as the high bits of
> i_blocks for 48-bits, besides i_blocks in fs blocksize.  Is there any
> comment?

Ted or Stephen, would you care to comment?  These are the same fields
used by the earlier patch "Pushing ext3 file size limits beyond 2TB"
by Goldwyn Rodrigues <Goldwynr@noida.hcltech.com>.  Having this under
the same RO_COMPAT_HUGE_FILE makes a lot of sense.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

