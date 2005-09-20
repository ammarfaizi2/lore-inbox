Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbVITRM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbVITRM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVITRM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:12:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932720AbVITRMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:12:25 -0400
Date: Tue, 20 Sep 2005 10:11:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: penberg@cs.Helsinki.FI, alan@lxorguk.ukuu.org.uk, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: p = kmalloc(sizeof(*p), )
Message-Id: <20050920101128.70fec697.akpm@osdl.org>
In-Reply-To: <20050920123149.GA29112@flint.arm.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	<84144f0205092004187f86840c@mail.gmail.com>
	<20050920114003.GA31025@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI>
	<20050920123149.GA29112@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
>  Since some of the other major contributors to the kernel appear to
>  also disagree with the statement, I think that the entry in
>  CodingStyle must be removed.

Nobody has put forward a decent reason for doing so.  "I want to grep for
initialisations" is pretty pointless because a) it won't catch everything
anyway and b) most structures are allocated and initialised at a single
place and many of those which aren't should probably be converted to do
that anyway.

The broader point is that you're trying to optimise for the wrong thing. 
We should optimise for those who read code, not for those who write it.

Every time I see such a type-unsafe allocation in a patch I have to go hunt
down the definition of the lhs.  Which is sometimes in a header file, often
one which hasn't been indexed yet.  Is a pita.

