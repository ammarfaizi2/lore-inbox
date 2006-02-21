Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWBUVKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWBUVKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbWBUVKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:10:48 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:15882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932779AbWBUVKr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:10:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YGJ1VwduXqo5vlp1QRWeOnfUNzrS9f9yLzeoWGRbHmbvBSY8XvOuD7zGPv8rWzH+N5Xr9wvryFifvXebKxffJs/uDqQruFoT0kIYC3apOG4xsDqaG48JJm+SJqemrGrmoHJqT0hZedhkQIi59atH+dzl3IMk35jTYHQGDpcYfXk=
Message-ID: <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
Date: Tue, 21 Feb 2006 22:10:46 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
Cc: "Sam Ravnborg" <sam@ravnborg.org>, "Andrew Morton" <akpm@osdl.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>
In-Reply-To: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> This is quite odd and I've no idea where to start looking for the
> cause, but let me describe what I'm seeing and maybe someone can point
> me in the right direction.
>
> I'm running SMP 2.6.x kernels on a Athlon 64 X2 4400+
>

I should probably mention that the kernel I'm currently running and
observing this behaviour with is 2.6.16-rc4-mm1.

> When I build new kernels I use 'make -j' to get both CPU cores busy
> and minimize build time.
>
> I've observed that when I use 'make -j 2', 'make -j 3' or 'make -j 4'
> only ~half of my CPU resources get used during the build and when I
> look at the output it looks exactely like output from plain 'make' for
> something like 95% of the  build - that is, files get build
> sequentially, not in parallel.
> However, if I run 'make -j 5' or higher, then both cores get lots of
> work to do and utilization of both cores stay close to 100% for almost
> the entire build, and the output during the build shows lots of files
> from different directories intermixed, so it's clearly building stuf
> in parallel.
>
> I find this quite strange since anything from 'make -j 2' and up
> should be able to keep both cores resonably busy, but there seems to
> be a huge difference between j <= 4 and j > 4.
>
> Another datapoint: This is most pronounced when I am also running the
> make process nice'd. Which I usually do in order to be able to use the
> machine for other tasks while the build is in progress.
> If I don't run the build nice'd then it starts to be resonably
> parallel at j >= 3, but still doesn't *really* load both cores before
> j >= 5.
>
>
> Just to be completely clear - a few examples:
>
> This is what I usually run to load both cores well :
>
> nice make -j 5 2>&1 | tee build.log
>
> this however gives me a more or less serial build with only half the
> system resources used :
>
> nice make -j 4 2>&1 | tee build.log
>
> Without nice this loads the box somewhat OK (but not completely):
>
> make -j 3 2>&1 | tee build.log
>
> and this pretty much gives me a serial build:
>
> make -j 2 2>&1 | tee build.log
>
>
> Any good explanations for this behaviour ?
>
>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
