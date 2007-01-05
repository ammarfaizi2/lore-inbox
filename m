Return-Path: <linux-kernel-owner+w=401wt.eu-S1161130AbXAEO7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbXAEO7n (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbXAEO7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:59:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:48739 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161130AbXAEO7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:59:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cRAE5Q0KgEoB58dQ7+ZiHZB/viwRgOJ8u3G5lKPZUAYfR9N+WLxQ1PNWZo4Lwi3xZbnNkoctKs5/rRHavK2WEV593Ib0/gOKH3QjtU3lydY8IE3/9PjgJhEwvnwe/ULIx3+sgsOiJazu2U+2Uq0KZvnxbGz4kS3jyWZP+WwFAq4=
Message-ID: <9a8748490701050659r3715aa48j883c26201005d26c@mail.gmail.com>
Date: Fri, 5 Jan 2007 15:59:41 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: open(O_DIRECT) on a tmpfs?
Cc: "Hugh Dickins" <hugh@veritas.com>, "Bill Davidsen" <davidsen@tmr.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490701050658n39f82791yb3d2e3c80f237a7e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701041653250.12920@blonde.wat.veritas.com>
	 <003f01c7302f$e72164b0$0200a8c0@nuitysystems.com>
	 <9a8748490701050658n39f82791yb3d2e3c80f237a7e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 04/01/07, Hua Zhong <hzhong@gmail.com> wrote:
> > > I see that as a good argument _not_ to allow O_DIRECT on
> > > tmpfs, which inevitably impacts cache, even if O_DIRECT were
> > > requested.
> > >
> > > But I'd also expect any app requesting O_DIRECT in that way,
> > > as a caring citizen, to fall back to going without O_DIRECT
> > > when it's not supported.
> >
> > According to "man 2 open" on my system:
> >
> >        O_DIRECT
> >               Try to minimize cache effects of the I/O to and from this file.
> >               In  general  this will degrade performance, but it is useful in
> >               special situations, such as  when  applications  do  their  own
> >               caching.  File I/O is done directly to/from user space buffers.
> >               The I/O is synchronous, i.e., at the completion of the  read(2)
> >               or write(2) system call, data is guaranteed to have been trans-
> >               ferred.  Under Linux 2.4 transfer sizes, and the  alignment  of
> >               user  buffer and file offset must all be multiples of the logi-
> >               cal block size of the file system. Under Linux 2.6 alignment to
> >               512-byte boundaries suffices.
> >               A semantically similar interface for block devices is described
> >               in raw(8).
> >
> > This says nothing about (probably disk based) persistent backing store. I don't see why tmpfs has to conflict with it.
> >
> > So I'd argue that it makes more sense to support O_DIRECT on tmpfs as the memory IS the backing store.
> >
>
> I'd agree.  O_DIRECT means data will go direct to backing store, so if
> RAM *is* the backing store as in the tmpfs case, then I see why
> O_DIRECT should fail for it...
>
Whoops, that should of course have read " then I *DON'T* see why
O_DIRECT should fail" .

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
