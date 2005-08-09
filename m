Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVHICfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVHICfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 22:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVHICfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 22:35:15 -0400
Received: from ozlabs.org ([203.10.76.45]:694 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932411AbVHICfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 22:35:14 -0400
Subject: Re: Unreliable Guide to Locking - Addition?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kedar Sovani <kedars@gmail.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5edf7fc905080806117df1ab32@mail.gmail.com>
References: <5edf7fc905080806117df1ab32@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 12:35:06 +1000
Message-Id: <1123554907.13481.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 18:41 +0530, Kedar Sovani wrote:
>     when the last atomic_dec_and_test() (the last == the one which
> returns 0) is being called on the object, the object is usually not
> accessible to others (list_del()) and hence the  simultaneous
> atomic_inc() call never occurs.

Yes, a reference count must count references.  Of course, you can get
around with with "atomic_dec_and_lock", but I hate that primitive as it
has scalability issues (it can't be translated to RCU).

I'll look and see if I can make this requirement explicit.

Thanks!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

