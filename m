Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUK3PoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUK3PoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUK3PoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:44:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:7655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262138AbUK3PoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:44:07 -0500
Date: Tue, 30 Nov 2004 07:43:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tvrtko.ursulin@sophos.com
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com, urban@teststation.com
Subject: Re: [BUG ?] smbfs open always succeeds
In-Reply-To: <OF080E710F.7E04A0F5-ON80256F5C.0053BD9B-80256F5C.00542AB4@sophos.com>
Message-ID: <Pine.LNX.4.58.0411300741270.22796@ppc970.osdl.org>
References: <OF080E710F.7E04A0F5-ON80256F5C.0053BD9B-80256F5C.00542AB4@sophos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004 tvrtko.ursulin@sophos.com wrote:
> 
> I investigated a bit and found a nfs_open function at 
> linux-2.6.9/fs/nfs/inode.c line 906 which also always returns 0. So is 
> this a network filesystem way of handling opens and not a bug after all? I 
> am not sure though that both nfs and smbfs operate in the same way and am 
> not claiming that.

Many networked filesystems end up doing most of the _real_ permissions
checking at IO time, not opens. That said, "open()" should return
definitive errors as early as possible, but sometimes you really have the
case that the real error only happens when you try to read or write
something.

Not saying that smbfs is right, just explaining that it _might_ be right. 

Urban, did you see the thread?

		Linus
