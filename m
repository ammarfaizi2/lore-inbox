Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264732AbSJRGOH>; Fri, 18 Oct 2002 02:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbSJRGOH>; Fri, 18 Oct 2002 02:14:07 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:7409 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264732AbSJRGOG>; Fri, 18 Oct 2002 02:14:06 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 18 Oct 2002 00:17:01 -0600
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andi Kleen <ak@muc.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statfs64 no longer missing
Message-ID: <20021018061701.GA18925@clusterfs.com>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	Benjamin LaHaise <bcrl@redhat.com>, Andi Kleen <ak@muc.de>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20021016140658.GA8461@averell> <shs7kgipiym.fsf@charged.uio.no> <15789.64263.606518.921166@wombat.chubb.wattle.id.au> <20021017000111.GA25054@averell> <20021017154102.D30332@redhat.com> <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2002  10:19 +1000, Peter Chubb wrote:
> -int fat_statfs(struct super_block *sb,struct statfs *buf)
> +int fat_statfs(struct super_block *sb, struct kstatfs *buf)
>  {
>  	int free,nr;
>         
>  	if (MSDOS_SB(sb)->cvf_format &&
>  	    MSDOS_SB(sb)->cvf_format->cvf_statfs)
>  		return MSDOS_SB(sb)->cvf_format->cvf_statfs(sb,buf,
> -						sizeof(struct statfs));
> +						sizeof(struct kstatfs));

How about
 		return MSDOS_SB(sb)->cvf_format->cvf_statfs(sb, buf,
							    sizeof(*buf));
> +struct statfs64 {
> +	long f_type;
> +	long f_bsize;
> +	long long f_blocks;
> +	long long f_bfree;
> +	long long f_bavail;
> +	long long f_files;
> +	long long f_ffree;
> +	__kernel_fsid_t f_fsid;
> +	long f_namelen;
> +	long f_frsize;
> +	long f_spare[5];
>  };

Wasn't Dave Miller just saying that passing "long" between user-space
and the kernel is just a bad idea?  Should we use "__u32" and "__u64"
here instead?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

