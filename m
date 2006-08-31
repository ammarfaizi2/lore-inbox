Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWHaQYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWHaQYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWHaQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:24:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46992 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932361AbWHaQYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:24:04 -0400
Message-ID: <44F70D22.2030703@cs.columbia.edu>
Date: Thu, 31 Aug 2006 12:24:02 -0400
From: Shaya Potter <spotter@cs.columbia.edu>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@fsl.cs.sunysb.edu
Subject: Re: bug in nfs in 2.6.18-rc5?
References: <44F6F80F.1000202@cs.columbia.edu> <1157040230.11347.31.camel@localhost>
In-Reply-To: <1157040230.11347.31.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Thu, 2006-08-31 at 10:54 -0400, Shaya Potter wrote:
> 
>> __lookup_hash() ends up calling the underlying fs's lookup op, i.e. 
>> nfs_lookup()
>>
>> nfs_lookup() calls nfs_reval_fsid(nd->mnt, dir, &fhandle, &fattr);
>>
>> see the bug? :)
>>
>> This doesn't seem like a unionfs bug, as one should be able to call 
>> lookup_one_len() on an NFS fs.
> 
> Did someone start handing out these promises when I wasn't looking?
> 
> AFAICS, lookup_one_len() should only be used by the filesystem itself,
> or by services like nfsd that have intimate knowledge of the
> filesystem's inner workings.
> 
> The reason why NFS would like to insist on that nameidata is that we
> need to be able to create mountpoints on the fly when we cross from one
> filesystem on the server to another. Otherwise, we cannot offer the type
> of guarantees that POSIX applications expect, such as the ability to
> provide unique permanent inode numbers.
> If we're to provide the ability for unionfs to use lookup_one_len() on
> NFS, then we will have to error out whenever we hit a case where we
> should be creating a new mountpoint. Is that acceptable?

why does the client care about server mounted file systems?  The 
server's nfsd has to tell them apart, otherwise shouldn't give them to 
the client.  Otherwise it seems like the nfsd and the nfs client have to 
have innate knowledge of each other.
