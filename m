Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSJQSsN>; Thu, 17 Oct 2002 14:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSJQSsN>; Thu, 17 Oct 2002 14:48:13 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22798 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261894AbSJQSsM>;
	Thu, 17 Oct 2002 14:48:12 -0400
Date: Thu, 17 Oct 2002 11:53:52 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017185352.GA32537@kroah.com>
References: <20021017195015.A4747@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017195015.A4747@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 07:50:16PM +0100, Christoph Hellwig wrote:
> I've been auditing the LSM stuff a bit more..
> 
> They have registered an implemented a syscall, sys_security
> that does nothing but switch into the individual modules
> based on the first argument, i.e. it's ioctl() switching
> on the security module instead of device node.  Yuck.
> 
> Patch below removes it (no intree users), maybe selinux/etc
> folks should send their actual syscall for review instead..

No, don't remove this!
Yes, it's a big switch, but what do you propose otherwise?  SELinux
would need a _lot_ of different security calls, which would be fine, but
we don't want to force every security module to try to go through the
process of getting their own syscalls.

And other subsystems in the kernel do the same thing with their syscall,
like networking, so there is a past history of this usage.

Linus, please do not apply.

thanks,

greg k-h
