Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWG0QB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWG0QB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWG0QB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:01:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6583 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750818AbWG0QB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:01:56 -0400
Date: Thu, 27 Jul 2006 19:01:55 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
In-Reply-To: <1154016589.13509.56.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0607271858380.6287@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> 
 <1154012822.13509.52.camel@localhost.localdomain> 
 <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com>
 <1154016589.13509.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 18:33 +0300, ysgrifennodd Pekka Enberg:
> > Don't device drivers already do that for f_ops->flush (filp_close) and

On Thu, 27 Jul 2006, Alan Cox wrote:
> ->flush is called when each closing occurs.

Yes revoke calls it too, but is that sufficient, or do we need ->revoke?

Ar Iau, 2006-07-27 am 18:33 +0300, ysgrifennodd Pekka Enberg:
> > vm_ops->close (munmap)? What revoke and frevoke do is basically
> > unmap/fsync/close on all the open file descriptors.

On Thu, 27 Jul 2006, Alan Cox wrote:
> What happens if an app is already blocked on a read when you do a
> revoke ? The nasty case answer could be "it completes later on and
> returns the users captured password"

Ouch. You are right. I need to stick that invalidate_inode_pages2 
back in there. The do_fsync call takes care of writes only, obviously. 
Thanks!

				Pekka
