Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWAFSxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWAFSxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWAFSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:53:18 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:27557 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751414AbWAFSxS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:53:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bnOFWQzhoOBRxVF2XLJcyau9ZLQJL+hwoU+h51HKO1LXKGzb9B78ohZiI7ey98+nWmnwqIeF+wMaTHPAEMxpHA2Kt0XfDQXgA8XdcgwOglZj41gyzNZ9JM1UwadUB80By2rg2HstkNHxUaD1sU9JBK4Mnm5BcdfK1ammVUQ+rpQ=
Message-ID: <9a8748490601061053q48a9968emb39cc8dcdaad11c3@mail.gmail.com>
Date: Fri, 6 Jan 2006 19:53:15 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] bio: gcc warning fix.
Cc: Khushil Dep <khushil.dep@help.basilica.co.uk>,
       Al Viro <viro@ftp.linux.org.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106184810.GR3389@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
	 <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
	 <20060106184810.GR3389@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Jens Axboe <axboe@suse.de> wrote:
> On Fri, Jan 06 2006, Jesper Juhl wrote:
> > gcc is right to warn in the sense that it doesn't know if
> > bvec_alloc_bs() will read or write into idx when its address is passed
>
> The function is right there, on top of bio_alloc_bioset(). It's even
> inlined. gcc has absolutely no reason to complain.
>
Right, gcc should be smarter in that case... hmm, I wonder if it warns
if you build with -funit-at-a-time ...

> > to it. But since we know that bvec_alloc_bs() only reads from it after
>
> bio_alloc_bioset() you mean.
>
Actually I did mean that bvec_alloc_bs() only reads the value of *idx
after it has assigned a value to it, but ofcourse there's no way for
gcc to warn about the use inside that function since there it has to
assume that whatever value of the variable being passed as a pointer
is the intended one.
Of course bio_alloc_bioset() also only reads from idx after
bvex_alloc_bs() has initialized it which is why the warning is bogus.

> > having assigned a value we know that gcc's warning is wrong, idx can
> > never *actually* be used uninitialized.
>
> Indeed, that's the whole point. For the original submitter, you are not
> the first to submit this. See archives for basically the same thread as
> this one...
>
> --
> Jens Axboe
>
>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
