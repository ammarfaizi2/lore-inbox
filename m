Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWG0QLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWG0QLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWG0QLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:11:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16276 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751481AbWG0QLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:11:40 -0400
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <Pine.LNX.4.58.0607271858380.6287@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <1154012822.13509.52.camel@localhost.localdomain>
	 <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com>
	 <1154016589.13509.56.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0607271858380.6287@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 17:30:09 +0100
Message-Id: <1154017809.13509.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 19:01 +0300, ysgrifennodd Pekka J Enberg:
> Yes revoke calls it too, but is that sufficient, or do we need ->revoke?
> Ouch. You are right. I need to stick that invalidate_inode_pages2 
> back in there. The do_fsync call takes care of writes only, obviously. 

Actually that isn't true either - it takes care of *regular file*
writes. Devices will need a revoke hook and thats really probably only
right. If they don't have one just -EOPNOTSUPP, you can check it before
you begin any other processing so its easy to check.

Alan
