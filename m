Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWG3ROM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWG3ROM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWG3ROM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:14:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27417 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751325AbWG3ROK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:14:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oZVw5hJWyOj5ibeR3fS3TqccDBTeeRWFg5EMf6aRiqkU8w3sJNatIOT76lJiuzZ5EB8pOcSKMUJt1hJ5VkFSMm2KBmwUtXL8QFh81CkG4P+r4jo0tNhW55QeCW+6suJoIZPLgyvJRSzLlQG++CYAc0IwhqX/11xace92OiFqqQo=
Message-ID: <9a8748490607301014rf04b6cew9d991635a7834277@mail.gmail.com>
Date: Sun, 30 Jul 2006 19:14:06 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Joe Perches" <joe@perches.com>, "Martin Waitz" <tali@admingilde.org>,
       "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
       "Christoph Hellwig" <hch@infradead.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Valdis Kletnieks" <Valdis.Kletnieks@vt.edu>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Randy Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <m3ac6rkp8c.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607301830.01659.jesper.juhl@gmail.com>
	 <m3ac6rkp8c.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Hi,
>
Hi Krzysztof,


> Jesper Juhl <jesper.juhl@gmail.com> writes:
>
> > This is a series of patches that try to be an initial step towards making
> > the kernel build -Wshadow clean.
>
> I'm not sure such patches improve situation.
>
> > It'll help us keep our namespaces separate.
>
> Nope, it's exactly opposite - now we have separate namespaces and
> -Wshadow reduces that separation.
>

I don't agree. -Wshadow lets the compiler help you ensure that you
don't accidentally use a symbol from a local scope when you think you
are using one from an enclosing scope (global or not).
Bugs resulting from such use can be hard to track down and if we can
get the compiler to help us avoid them I think that's a win.


> Currently you don't have to worry about the universe when you write
> a piece of code, and more importantly the universe doesn't have to
> worry about each function and each private variable. I'm not sure
> changing that is a good idea.

I think it's a good thing that we have to take a little more care when
choosing global function and variable names... Take up() for example -
in my (very humble) oppinion that is a very bad name for a global
function - it clashes too easily with local function and variable
names, and a programmer who's not careful may end up calling the
global up() when he wants the local and vice versa (a much better name
would have been sem_up() - should we change that???).
I think it's a good think if we in the future name our global stuff
with more care and stick a big fat warning in the face of programmers
who introduce local stuff that shadows something else.

I don't agree with you and I don't know how to convince you, but I
still appreciate your feedback.
Thanks.

I'll leave it to people higher in the hierarchy to decide if these
patches should be applied or not ;)

Keep that feedback flowing people :-)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
