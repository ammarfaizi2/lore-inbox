Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSAMDpx>; Sat, 12 Jan 2002 22:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSAMDpn>; Sat, 12 Jan 2002 22:45:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35029 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287337AbSAMDpb>;
	Sat, 12 Jan 2002 22:45:31 -0500
Date: Sat, 12 Jan 2002 22:45:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Craig Christophel <merlin@transgeek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: buffer.c lock_kernel() -- removal
In-Reply-To: <20020110102805.536F8C738A@smtp.transgeek.com>
Message-ID: <Pine.GSO.4.21.0201122243040.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jan 2002, Craig Christophel wrote:

> Included is a patch against buffer.c that removes the 
> lock_kernel()/unlock_kernel() pairs in the few functions that they exist.  
> 
> This is for 2.5>2.5.2-pre10.
> 
> I beleive that I checked all of the member functions for locking schematics 
> but if you can prove me wrong -- go for it.   The only issue I can see would 

... and in the very first chunk we have
  
> -	lock_kernel();
>  	sync_inodes_sb(sb);
>  	DQUOT_SYNC(sb);
>  	lock_super(sb);
>  	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
>  		sb->s_op->write_super(sb);
>  	unlock_super(sb);
> -	unlock_kernel();

i.e. method that used to have BKL loses it.  Unless you are willing to post
the results of audit for all filesystems - sorry, no go.

