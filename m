Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUDLRrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUDLRrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 13:47:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:61087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262986AbUDLRrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 13:47:04 -0400
Date: Mon, 12 Apr 2004 10:46:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brian King <brking@us.ibm.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-Id: <20040412104638.7b1d0124.akpm@osdl.org>
In-Reply-To: <407AB4FD.4070905@us.ibm.com>
References: <4072F2B7.2070605@us.ibm.com>
	<20040406172903.186dd5f1.akpm@osdl.org>
	<20040407061146.GA10413@kroah.com>
	<407487A6.8020904@us.ibm.com>
	<20040408224713.GD15125@kroah.com>
	<40770AD0.4000402@us.ibm.com>
	<20040409205344.GA5236@kroah.com>
	<20040409141511.4e372554.akpm@osdl.org>
	<20040410165322.GG1317@kroah.com>
	<20040410131137.0eff0ae2.akpm@osdl.org>
	<407AB4FD.4070905@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian King <brking@us.ibm.com> wrote:
>
> >> Ok, you've convinced me of the mess that would cause.  So what should we
>  >> do to help fix this?  Serialize call_usermodehelper()?
>  > 
>  > 
>  > May as well bring back call_usermodehelper_async() I guess.
>  > 
>  > 
>  > There are two patches here, and they are totally untested...
> 
>  I loaded the patches on my ppc64 box and they worked fine after I fixed a compile
>  bug. The attached patch fixes the compile bug and changes the call_usermodehelper
>  call in kset_hotplug to call_usermodehelper_async.

yup, thanks.  I've changed the patch in my tree so that we always perform
the fully-async operation if call_usermodehelper() is passed "wait=0".  It
gets the new code some more testing and keeps the kernel API simpler.

