Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWG0RHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWG0RHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWG0RHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:07:49 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:46221 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751776AbWG0RHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:07:48 -0400
Date: Thu, 27 Jul 2006 20:07:47 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <1154017809.13509.64.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0607272006050.7152@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> 
 <1154012822.13509.52.camel@localhost.localdomain> 
 <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com> 
 <1154016589.13509.56.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0607271858380.6287@sbz-30.cs.Helsinki.FI>
 <1154017809.13509.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 19:01 +0300, ysgrifennodd Pekka J Enberg:
> > Yes revoke calls it too, but is that sufficient, or do we need ->revoke?
> > Ouch. You are right. I need to stick that invalidate_inode_pages2 
> > back in there. The do_fsync call takes care of writes only, obviously. 
 
On Thu, 27 Jul 2006, Alan Cox wrote:
> Actually that isn't true either - it takes care of *regular file*
> writes. Devices will need a revoke hook and thats really probably only
> right. If they don't have one just -EOPNOTSUPP, you can check it before
> you begin any other processing so its easy to check.

Ah, you're right. So I'll make a generic_file_revoke and f_ops->revoke 
that can be used by filesystems to do sync and inode page invalidation. 
That hook should be sufficient for device drivers too?

				Pekka
