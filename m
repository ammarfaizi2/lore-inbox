Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280744AbRKOGDk>; Thu, 15 Nov 2001 01:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280751AbRKOGDb>; Thu, 15 Nov 2001 01:03:31 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:12015 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280744AbRKOGDT>;
	Thu, 15 Nov 2001 01:03:19 -0500
Date: Wed, 14 Nov 2001 23:01:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011114230134.A5739@lynx.no>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
	Andreas Gruenbacher <ag@bestbits.at>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@oss.sgi.com
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu> <20011113062711.A1912@wotan.suse.de> <20011115160853.N588010@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115160853.N588010@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Thu, Nov 15, 2001 at 04:08:53PM +1100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  16:08 +1100, Nathan Scott wrote:
> +	if (ops) {
> +		if (flags & EA_CREATE) {
> +			if (ops->create)
> +				error = ops->create(i, name, value, size);
> +		}
> +		else if (flags & EA_REPLACE) {
> +			if (ops->replace)
> +				error = ops->replace(i, name, value, size);
> +		}
> +		else if (flags & EA_REMOVE) {
> +			if (ops->remove)
> +				error = ops->remove(i, name);
> +		}
> +		else if (ops->set)
> +			error = ops->set(i, name, value, size);
> +	}

> +	int (*create) (struct inode *, char *, void *, size_t);
> +	int (*replace) (struct inode *, char *, void *, size_t);
> +	int (*set) (struct inode *, char *, void *, size_t);

What is the distinction between "set" and "replace" or "set" and "create"?
Is it analogous to open(,O_CREAT|O_EXCL)?  If so, why are there not just
flags to distinguish the two, but also separate VFS operations?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

