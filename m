Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWJAQEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWJAQEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWJAQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:04:22 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:21139 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751220AbWJAQEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:04:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 1 Oct 2006 09:04:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/eventpoll: error handling micro-cleanup
In-Reply-To: <20061001124352.GA30263@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0610010900540.21285@alien.or.mcafeemobile.com>
References: <20061001124352.GA30263@havoc.gtf.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006, Jeff Garzik wrote:

> 
> While reviewing the 'may be used uninitialized' bogus gcc warnings,
> I noticed that an error code assignment was only needed if an error had
> actually occured.

But that saved one line of code, and there are countless occurences in the 
kernel of such code pattern ;)
In any case, fine by me and not worth further discussion.



> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -720,9 +720,10 @@ static int ep_getfd(int *efd, struct ino
>  
>  	/* Allocates an inode from the eventpoll file system */
>  	inode = ep_eventpoll_inode();
> -	error = PTR_ERR(inode);
> -	if (IS_ERR(inode))
> +	if (IS_ERR(inode)) {
> +		error = PTR_ERR(inode);
>  		goto eexit_2;
> +	}
>  
>  	/* Allocates a free descriptor to plug the file onto */
>  	error = get_unused_fd();



- Davide


