Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVHRBjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVHRBjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVHRBjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 21:39:18 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:62564 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932076AbVHRBjR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 21:39:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LboPfeozTHSF8PSpOMSkDK5IJDqzhMuVCXnGZ/CXJ8AOjo6xdZQMsqmF9c+ltwsmutIt0ZU7sv/xJTwZtbk3EBsEX9buIX26+x3Qlf3UniBq9QvuD2YtbxuPN7Rg4nkhVOgprFwycB2/lkm8/8oLSskr7R9oh2iTp+PmDZKD00k=
Message-ID: <2cd57c90050817183942b217fa@mail.gmail.com>
Date: Thu, 18 Aug 2005 09:39:16 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] struct file cleanup : the very large file_ra_state is now allocated only on demand.
Cc: Andi Kleen <ak@suse.de>, Benjamin LaHaise <bcrl@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4303D90E.2030103@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050810164655.GB4162@linux.intel.com>
	 <20050810.135306.79296985.davem@davemloft.net>
	 <20050810211737.GA21581@linux.intel.com>
	 <430391F1.9080900@cosmosbay.com>
	 <20050817211829.GK27628@wotan.suse.de>
	 <4303AEC4.3060901@cosmosbay.com> <20050817215357.GU3996@wotan.suse.de>
	 <4303D90E.2030103@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Eric Dumazet <dada1@cosmosbay.com> wrote:
> Andi Kleen a écrit :
> 
> >
> >>(because of the insane struct file_ra_state f_ra. I wish this structure
> >>were dynamically allocated only for files that really use it)
> >
> >
> > How about you submit a patch for that instead?
> >
> > -Andi
> 
> OK, could you please comment this patch ?
> 
> The problem of dynamically allocating the readahead state data is that the allocation can fail and should not be fatal.
> I made some choices that might be not good.
> 
> I also chose not to align "file_ra" slab on SLAB_HWCACHE_ALIGN because the object size is 10*sizeof(long), so alignment would loose
> 6*sizeof(long) bytes for each object.
> 
> 
> [PATCH]
> 
> * struct file cleanup : the very large file_ra_state is now allocated only on demand, using a dedicated "file_ra" slab.
>         64bits machines handling lot of sockets can save about 72 bytes per file.
> * private_data : The field is moved close to f_count and f_op fields to speedup sockfd_lookups

Why not keep the comment or fix it?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
