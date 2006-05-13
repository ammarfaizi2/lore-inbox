Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWEMU7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWEMU7W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 16:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEMU7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 16:59:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:4325 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751334AbWEMU7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 16:59:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RMtY5PuO2mQAE0ZvdgprmNnQ9W8TRObPBbOlUhgEu+aOCbRL82Fo606K1tZAHRTcP4dkrdcp3ZMJcX9s3JvHN04NznWQiL4ewGiYQKdlK4VS4sp90IbV2P/kmPaiJ/zNuhnktQhUMUGKhqik20J1d0l33/9XO1OQQSnnvrs5TLA=
Message-ID: <9a8748490605131359h18f47e89o1f8545269fbf3502@mail.gmail.com>
Date: Sat, 13 May 2006 22:59:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Subject: Re: [PATCH] a few small mconf improvements
Cc: linux-kernel@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
       "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>,
       "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <Pine.LNX.4.64.0605082337280.32445@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605071749.28822.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0605082337280.32445@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/06, Roman Zippel <zippel@linux-m68k.org> wrote:
>
>
> On Sun, 7 May 2006, Jesper Juhl wrote:
>
> >  - rename main() arguments from "ac"/"av" to the more common "argc"/"argv".
>
> conf.c and qconf.cc do the same, it's a personal preference.
>
Fair enough.


> >  - when unlinking lxdialog.scrltmp, the return value of unlink() is not
> >    checked. The patch adds a check of the return value and bails out if
> >    unlink() fails for any reason other than ENOENT.
>
> The check is not needed, the worst that can happen is a misbehaving
> lxdialog and you certainly have bigger problems than this, if the unlink
> should fail. In the long term this should go away anyway.
>
Ok, your call.


> >  - if the sscanf() call in conf() fails and stat==0 && type=='t', then
> >    we'll end up dereferencing a NULL 'sym' in sym_is_choice(). The patch
> >    adds a NULL check of 'sym' to that path and bails out with a big fat
> >    error message if that should ever happen (better than just crashing
> >    IMHO).
>
> That error message is as useful to the normal user as a segfault - mconf
> doesn't work. Since it shouldn't happen, this check adds no real value,
> the user still has to provide enough information to reproduce the problem
> and at this point it makes no difference, whether I get this message or I
> see where it stops with gdb.
>
I disagree a little here. It may not really matter to you if you get a
report of a crash or if you get a report that mconf spewed an error
message, but to the user who experiences it (should it ever happen)
there's a difference - it's either "the damn thing crashed on me, what
a piece of crap" or "the damn thing crashed on me, but at least it
told me something went wrong, so now I can report it"... Printing an
error and exiting cleanly is IMHO always preferable to a crash - users
respond better to that and it's the "right" thing to do.

What about the other bits of the patch? are those OK?
Want me to send an updated patch - or?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
