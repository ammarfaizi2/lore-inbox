Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUIJHtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUIJHtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUIJHtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:49:53 -0400
Received: from trantor.org.uk ([213.146.130.142]:7645 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S266263AbUIJHte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:49:34 -0400
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040908103922.GD9795@lkcl.net>
References: <20040908100946.GA9795@lkcl.net>
	 <20040908103922.GD9795@lkcl.net>
Content-Type: text/plain
Date: Fri, 10 Sep 2004 08:49:28 +0100
Message-Id: <1094802568.8495.49.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 11:39 +0100, Luke Kenneth Casson Leighton wrote:
> ... did i sent a patch?
> 
> did i send a patch??  i don't _think_ so *lol* :)

heh :)

IMO the number of constraints involed here make using this patch fairly
involved (for something security related at least) in that, as you said,
you have to:

 - be careful to use ACCEPT rules only
 - be careful that you do:
    1. remove fw rules
    2. upgrade software
    3. replace rules

plus the fastpath code looks very hairy with at least 3 locks taken and
O(num_tasks * max_fds) unpreemptable in softirq...

There has to be a simpler approach, perhaps passing in a path, looking
up the dentry in current namespace and setting an unused flag in
d_vfs_flags? That way you could just match on skb->sk->sk_socket->file-
>f_dentry.

I don't know enough about VFS to know if that's really possible. I mean
would you need vfsmnt too to make it accurate across namespaces? and if
so, could dcookie infrastructure be used?

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

