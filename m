Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWDDFLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWDDFLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWDDFLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 01:11:12 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:23094 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964948AbWDDFLM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 01:11:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PEWvCgNVfCz7mztiVyBk/lnPyprUqOo/0ruykfr8+Bbqevg7djez6+mFn4xPjqY38uoJFbiBDeUxwqlgDRY20aONgtKap1i0FfV2TPEVNhvoo8bBEzds8WwcXi40RuD0d81/CvQwrGpW+3BacTTM/Zq2ZmWla+HqH3IcnD1MRns=
Message-ID: <661de9470604032211n3ea98a99j2fce3fd8faf39081@mail.gmail.com>
Date: Tue, 4 Apr 2006 10:41:11 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] Fix dcache race during umount
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Jan Blunck" <jblunck@suse.de>, "Kirill Korotaev" <dev@openvz.org>,
       "Olaf Hering" <olh@suse.de>
In-Reply-To: <1060404010506.27391@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060404110351.27364.patches@notabene>
	 <1060404010506.27391@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying again after some useful comments from Balbir.
> Note: the change to prune_dcache looks quite different now.
>
> NeilBrown
>
<snip>
>                 tmp = dentry_unused.prev;
> +               if (unlikely(sb)) {
> +                       /* Try to find a dentry for this sb, but don't try
> +                        * too hard, if they aren't near the tail they will
> +                        * be moved down again soon
> +                        */
> +                       int skip = count;
> +                       while (skip &&
> +                              tmp != &dentry_unused &&
> +                              list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
> +                               skip--;
> +                               tmp = tmp->prev;
> +                       }
> +               }

This code looks very similar to the first pass in dcache_shrink_sb().
I would prefer if we could re-use that code here, but that would
require creating a helper function by splitting the function.

Looks like a good solution to me.

Regards,
Balbir
