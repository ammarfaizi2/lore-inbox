Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVCGE4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVCGE4p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCGE4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:56:45 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:8953 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261552AbVCGE4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:56:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ODy6N0tPKa0J99fkxvYOUr0WEAsBfQlKdkSC8oohfKhdeVHSZzhYelQ0ebUgJmA+ZLwMajLyDm/8aS6gwoT+YhKma6GN1qSGrDc0xnI2oekambofFfENcjzfkjDFRTQ4fS8hL6FStdzEV+YFCRQYz2jXgHIe8Vu8Lmen7YOBgts=
Message-ID: <29495f1d050306205634336f05@mail.gmail.com>
Date: Sun, 6 Mar 2005 20:56:42 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 05/14] char/hvsi: use wait_event_timeout()
Cc: domen@coderock.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
In-Reply-To: <20050306193236.1dd2b3de.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050306223630.55D7C1ED3D@trashy.coderock.org>
	 <20050306193236.1dd2b3de.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005 19:32:36 -0800, Andrew Morton <akpm@osdl.org> wrote:
> domen@coderock.org wrote:
> >
> > Please consider applying. This is my first wait-queue related patch, so comments
> >  are very welcome.
> >
> >  Use wait_event_timeout() in place of custom wait-queue code. The
> >  code is not changed in any way (I don't think), but is cleaned up quite a bit
> >  (will get expanded to almost identical code).
> >
> > ...

<snip>

> >  +    if(!wait_event_timeout(hp->stateq, (hp->state == state), jiffies + HVSI_TIMEOUT))
> >  +            ret = -EIO;
> 
> wait_event_timeout()'s `timeout' arg is number-of-milliseconds-to-wait,
> not an absolute time, yes?

D'oh. I will fix this and any other timeout version that are being
pushed to you tomorrow. Sadly, wait_event*() do not take milliseconds,
but jiffies. I am hoping to push some patches to change that, but it
may have to wait a while.
 
> Also, it's conventional to put a space between the `if' and the `('.
>
> It's nice to squeeze the code into an 80-column xterm, too.

Will fix these both as well.

Thanks,
Nish
