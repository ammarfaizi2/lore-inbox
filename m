Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWHNHZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWHNHZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWHNHZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:25:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:44964 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751582AbWHNHZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=as0DO8vyvsjkyPMWS0rPkCw7GZeLfuVr3oZpOh/9JEgaeFVZKPGm3jyoGvQBg0CAg/2MNh6pjV3ACzSldkf9NXmcJjg3/01qfnCALLcXSS7nShByvzeNiKSMjunEhyHham8hNcyZ4fXVVY6m01eKCHqz6tF6BevV1bKOUKIjClI=
Message-ID: <9a8748490608140025w3257f315jcceccf05d200437f@mail.gmail.com>
Date: Mon, 14 Aug 2006 09:25:53 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: [PATCH] XFS: remove pointless conditional testing 'nmp' vs NULL in fs/xfs/xfs_rtalloc.c::xfs_growfs_rt()
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
In-Reply-To: <20060814110942.C2698880@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608130016.51136.jesper.juhl@gmail.com>
	 <20060814110942.C2698880@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Sun, Aug 13, 2006 at 12:16:50AM +0200, Jesper Juhl wrote:
> > In fs/xfs/xfs_rtalloc.c::xfs_growfs_rt() there's a completely useless
> > conditional at the error_exit label.
> > The 'if (nmp)' check is pointless and might as well be removed for two
> > reasons.
> >
> > 1) if 'nmp' is NULL then kmem_free() will end up calling kfree() with a NULL
> >    argument - which in turn will just cause a return from kfree(). No harm
> >    done.
>
> Thats valid.
>
> > 2) At the beginning of the function there's an assignment; '*nmp = *mp;' so
>
> Thats not.  Theres no assignment at the start of the function;
> theres one inside the main body of the loop 20+ lines into it,
> and right after a mem alloc with flags requiring no failure.
> Later that local variable is freed then set to NULL inside the
> loop, before continuing the next iteration...
>
> Really this code would be better if reworked slightly to just
> allocate nmp once before entering the loop, and then free it
> once at the end... we wouldn't need a goto, just a few breaks
> in the loop and a conditional transaction cancel.
>
> > This patch gets rid of the pointless check.
>
> Hmm, seems like code churn that makes the code slightly less
> obvious, but thats just me... I'd prefer a tested patch that
> implements the above suggestion, to be honest. :)
>
Ok, I'll see what I can come up with.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
