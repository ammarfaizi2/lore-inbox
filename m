Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWBMWPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWBMWPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWBMWPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:15:38 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:32984 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030211AbWBMWPh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:15:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KlBRXKItStqVHRD/CTKOxXWjVEVlGIGu8ZMNeNEW83F5zaAPkbt4IKxD54WQFdk7by7gQBk2muCHr11Kb5qMwuRG2HGfQdsdx55RLGkw2xnZ8JWe7T3D8U3WSvUz696QkyJ1nXMqF2EGADe3/uQhfv+q9cd9+XVDVxhEF6z0tqA=
Message-ID: <9a8748490602131415r5c6cd7by3a3d0bc03e27bd83@mail.gmail.com>
Date: Mon, 13 Feb 2006 23:15:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: [PATCH] tty reference count fix
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1139861610.3573.24.camel@amdx2.microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1139861610.3573.24.camel@amdx2.microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Paul Fulghum <paulkf@microgate.com> wrote:
> Fix hole where tty structure can be released when reference
> count is non zero. Existing code can sleep without tty_sem
> protection between deciding to release the tty structure
> (setting local variables tty_closing and otty_closing)
> and setting TTY_CLOSING to prevent further opens.
> An open can occur during this interval causing release_dev()
> to free the tty structure while it is still referenced.
>
> This should fix bugzilla.kernel.org
> [Bug 6041] New: Unable to handle kernel paging request
>
> In Bug 6041, tty_open() oopes on accessing the tty structure
> it has successfully claimed. Bug was on SMP machine
> with the same tty being opened and closed by
> multiple processes, and DEBUG_PAGEALLOC enabled.
>
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jesper Juhl <jesper.juhl@gmail.com>
>

I just applied the patch to 2.6.16-rc3 and booted the patched kernel.
Unfortunately I can't tell you if it fixes the bug since I never
successfully reproduced it, it just happened once out of the blue.
What I can tell you though is that the patched kernel seems to behave
just fine and doesn't seem to introduce any regressions on my system -
but my testing has been quite limited so far.

Not the best feedback, I know, but it's the best I can give you at the moment.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
