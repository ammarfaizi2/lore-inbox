Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946706AbWKAIVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946706AbWKAIVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946703AbWKAIVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:21:10 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:35001 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1946701AbWKAIVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:21:08 -0500
Date: Wed, 01 Nov 2006 09:21:06 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC, PATCH] dont insert sockets/pipes dentries into
 dentry_hashtable.
In-reply-to: <20061031.231954.23010447.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <454858F2.5020206@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061025084726.GE18364@nuim.ie>
 <20061025.230615.92585270.davem@davemloft.net>
 <200610311948.48970.dada1@cosmosbay.com>
 <20061031.231954.23010447.davem@davemloft.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Tue, 31 Oct 2006 19:48:48 +0100
> 
>> We currently insert sockets/pipes dentries into the global dentry
>> hashtable.  This is *useless* because there is currently no way
>> these entries can be used for a lookup(). (/proc/xxx/fd/xxx uses a
>> different mechanism)
> 
> It turns out that while procfs uses a different "mechanism", those
> procfs symlinks do point to the real socket dentry, so when you
> readlink() on it you do d_path() on the real socket dentry.
> 
> If you unhash these things, I'm pretty sure you'll see an ugly
> "(deleted)" at the end of the symlink string for /proc/$pid/fd/$X
> files that are sockets or something like that.

No no, my patch takes care of that.

You still see the right link for pipes and sockets on /proc/$pid/fd/XXX

And " (deleted)" is correctly added to deleted files.


> 
> Al Viro just suggested a way around this to me:
> 
> 1) Just mark the dentry HASHED by hand in the dentry flags, but don't
>    actually hash it.
> 
> 2) Create a special dentry->d_deleted method for sockets that returns
>    0 and clears by hand the HASHED flag bit in the dentry (see what
>    dput() does when this happens).
> 
> It's an abuse but it will work.
> 
Why hack when a proper thing can be done ?

