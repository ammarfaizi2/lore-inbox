Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319554AbSIMI3e>; Fri, 13 Sep 2002 04:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319561AbSIMI3e>; Fri, 13 Sep 2002 04:29:34 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:33801 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319554AbSIMI3d>;
	Fri, 13 Sep 2002 04:29:33 -0400
Date: Fri, 13 Sep 2002 17:26:39 +0900 (JST)
Message-Id: <20020913.172639.63505761.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D81A200.C1B6A293@digeo.com>
References: <3D80E139.ACC1719D@digeo.com>
	<20020913.162252.56050784.taka@valinux.co.jp>
	<3D81A200.C1B6A293@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I appreciate for your kind answer.
I understand clearly.
Ok, this means new filemap_copy_from_user_iovec() also have to
use regular kmap when page fault has happened.
I'll fix it soon.

> > I updated the writev patch which may be easy to understand.
> > How about it?
> 
> Looks nice.   And yes, you hung onto the atomic kmap across multiple
> iov segments ;)  That will save a tlb invalidate per segment.

Yes.

> > But I have one question, Could let me know if you have any idea,
> > why does filemap_copy_from_user() try to call kamp()+__copy_from_user()
> > again after the first trial get fault.
> > 
> > Is there any meanings?
> 
> We're not allowed to schedule away inside atomic_kmap - must remain
> in the same task, on the same CPU etc.  So the pagefault handler
> will return immediately if we take a pagefault while copying to/from
> userspace while holding an atomic kmap.


