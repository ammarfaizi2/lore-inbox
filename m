Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVKGPEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKGPEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVKGPEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:04:39 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:31368 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932188AbVKGPEi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:04:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nq20v/HszcNTXMpQS25dMopEUyo5/jrbk1ZLYJshS50nyAqs8dX8eFEaQT8aEJQTv6izgHz992EmrL4X4H6P7pmYOKmWz4p74RqjLeo/YVmq24h2IF75+doPa/TbyfRP+BmG3VbmUa1uBJWzVMaUWpt2f1PlwQYYtJOkXjpgr10=
Message-ID: <29495f1d0511070704x27a6d987h29f10dc18bc9fd18@mail.gmail.com>
Date: Mon, 7 Nov 2005 07:04:37 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Subject: Re: negative timeout can be set up by setsockopt system call
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436F67BF.2020708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436F67BF.2020708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Ram Gupta <ram.gupta5@gmail.com> wrote:
> On 11/4/05, Nish Aravamudan <nish.aravamudan@gmail.com>
>  >
>  > In Ram's specific case, I think, the call path is sys_setsockopt() ->
>  > sock_setsockopt() -> sock_set_timeout, which has a definition of:
>  >
>  > static int sock_set_timeout(long *timeo_p, char __user *optval, int
> optlen)
>
>  >> Exactly right.

Ok.

>  > Ram, what is the expected behavior of negative values in the timeval?
>  > And what are you seeing happen right now?
>  >
>  > As of 2.6.14, looks like we convert any non-zero values into jiffies
>  > and store them in sk->sk_{rcv,snd}timeo...
>  >
>  I don't see any problem from the kernel side but the application
> times out immediately causing certain failures as the schedule_timeout
> returns immediately in case of negative values. Shouldn't there be a
> check for negative values and return error to the application so that
> it can handle it.

I mean more along the lines of what does a man-page say the kernel
should be doing if you request a negative timeout? More explicitly,
what made you think negative timeouts should have a specific effect?

When you say schedule_timeout() returns immediately, I assume your
logs are filling up with "schedule_timeout: wrong timeout ..." ? (You
may need to bump your loglevel). If not, then schedule_timeout() isn't
getting a negative value.

Thanks,
Nish
