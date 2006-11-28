Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756360AbWK1Wea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbWK1Wea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbWK1Wea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:34:30 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:41529 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1756360AbWK1We2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:34:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mXRtEp5N1z3gxr2f7nkdz08gJT8PzS3VqjQz3zXztmIp+sYbQ9P6zGj9tOXUu8booBgj4ifiZ00JpthqVLzekQh4dftPR8ei1RFLehegFWjqqhg/ocqKK8SOJeT1Rzep8xPqzLy+b7ITQYA9TLCvmjqj2pFTSb+fGYBGhP04YH8=
Message-ID: <9a8748490611281434g3741045v5e7f952f633e08d3@mail.gmail.com>
Date: Tue, 28 Nov 2006 23:34:27 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       trivial@kernel.org
In-Reply-To: <Pine.LNX.4.64.0611281425220.4244@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611282317.14020.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0611281425220.4244@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 28 Nov 2006, Jesper Juhl wrote:
> >
> > In kernel/sys.c::sys_prctl() the argument named 'arg2' is very clearly
> > of type 'unsigned long', and when compiling with "gcc -W" gcc also warns :
> >   kernel/sys.c:2089: warning: comparison of unsigned expression < 0 is always false
> >
> > So this patch removes the test of "arg2 < 0".
>
> No, we don't do this.
>
> This is why we don't compile with "-W". Gcc is crap.
>
> The fact is, if it's unsigned, it's not something that the programmer
> should have to care about. We should write our code to be readable and
> obviously safe, and that means that
>
>         if (x < 0 || x > MAX)
>                 return -ERROR;
>
> is the _right_ way to do things, without having to carry stupid context
> around in our heads.
>
> If the compiler (whose _job_ it is to carry all that context and use it to
> generate good code) notices that the fact that "x" is unsignes means that
> one of the tests is unnecessary, that does not make it wrong.
>
> Gcc warns for a lot of wrong things. This is one of them.
>
> Friends don't let friends use "-W".
>
Hehe, ok, I'll stop cleaning this stuff up then.
Nice little hobby out the window there ;)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
