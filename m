Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932851AbWAFSls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851AbWAFSls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbWAFSls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:41:48 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:24198 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932851AbWAFSlr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:41:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CVQAi+TC9AdeKPJh9vEUDDOuXwHbR+D8VuaGyCQTUaTowTOzhxl7ta+lqnY4FFH7ljErTYUK6jj3k54toTkn86DxaQ3W2MpYHi8g/YSxSkMe48ei7ltMX3PmXZjZ7BboUaRx9Sk7oetB2JQGc87fHw2ivVoylZosBg3HlhEeQrw=
Message-ID: <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
Date: Fri, 6 Jan 2006 19:41:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Khushil Dep <khushil.dep@help.basilica.co.uk>
Subject: Re: [PATCH] bio: gcc warning fix.
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, axboe@suse.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Khushil Dep <khushil.dep@help.basilica.co.uk> wrote:
> I wonder however whether this is not correct? I was always taught to
> initialise variables so there is no doubt as to their starting value?
>
There is no doubt, the idx variable is used on the very next line,
it's address is being passed to bvec_alloc_bs() which as the very
first thing it does fills in a value or returns NULL (in which case
idx is undefined anyway).

So there's no doubt at all that idx will always get a value assigned to it.

gcc is right to warn in the sense that it doesn't know if
bvec_alloc_bs() will read or write into idx when its address is passed
to it. But since we know that bvec_alloc_bs() only reads from it after
having assigned a value we know that gcc's warning is wrong, idx can
never *actually* be used uninitialized.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
