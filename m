Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWACPLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWACPLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWACPLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:11:00 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:52862 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932347AbWACPLA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:11:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQEow3SYIQcR9FgT+/jSQdEA/72dsCldn/AdpSU0PZdaWYC4Sx2sgkvYqgd+lbDCfyn0BI/iaXEJ2CTfqJ6tYXQfZxWv3Loa4RlMnSn9WkFVbuRSStuzcU7RMYSNKADvS9sk/ncBSKyHgTZbOxZzDlcb/J8CGWdq8EDVgChjA0I=
Message-ID: <728201270601030710u3fda171ft87067bb814f1f0ce@mail.gmail.com>
Date: Tue, 3 Jan 2006 09:10:57 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Query] regarding sock_ioctl in linux kernel
Cc: Satinder <jeet_sat12@yahoo.co.in>
In-Reply-To: <20051228101528.50347.qmail@web8318.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228101528.50347.qmail@web8318.mail.in.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that whenever socket is allocated it is also mapped with its
operations also as it calls sock_map_fd after sock_alloc or assigns
the sock->ops when duplicating it. Currently does not look like there
is need for the check but may be better to check to make sure there is
no ommission in new type of socket allocations in future.

regards
Ram Gupta

On 12/28/05, Satinder <jeet_sat12@yahoo.co.in> wrote:
>  Hi everybody,
>
>
> I was viewing the linux source code (version 2.6.9 )
> for socket APIs.
>
> in function sock_ioctl() [file net/socket.c.]
> I found that the kernel is handling the socket pointer
> without any check.
> Even in 'default' case it is calling
> sock->ops->ioctl() without checking whether the
> sock->ops having value or not.
>
> Is this assumed that the kernel will call the
> sock_ioctl only when the socket data structure/ file
> structure/socket substructure  exists, or there is
> some other reason for not putting checks before
> calling file operations in sock_ioctl
>
> There may be case when someone may alloc socket in
> init module and map it to file descriptor using
> sock_map_fd() and increament its reference count using
> fget().
>
> And at cleanup time it releases the socket using
> sock_release() without unmaping file descriptor and
> decreamenting the referenece count.
>
> and  socket->file would be NULL without freeing the
> inode number when sock_release returns. So at reboot
> time many network process may try to use this socket
> beacause inode is not being  released. In this case
> kernel may crash.?
>
> If anyone could explain this that would be very nice.
> Please keep me in cc.
> TIA
>
> Regards,
> Satinder
>
> Send instant messages to your online friends http://in.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
