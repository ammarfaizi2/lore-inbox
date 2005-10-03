Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVJCJ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVJCJ7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJCJ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:59:04 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:22394 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932215AbVJCJ7C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:59:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=coGALT0yRLn7baFIVcXVJLAAH4BWHJ9R7f56cyZst1YsnRPWKaMsYePJQN1AH+DH8qIb9EwfiL9ekr52GvJlCpLWcFKLDq25MrESt5k2SK1HmKghAEJA29nJQ41BvZSYbkVujvtbjSTQAKWs0qtA+pc3o7mPHHe1WUx2gFqFMWU=
Message-ID: <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
Date: Mon, 3 Oct 2005 11:59:01 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] release_resource() check for NULL resource
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20051003094803.GC3500@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002170318.GA22074@home.fluff.org>
	 <20051002103922.34dd287d.rdunlap@xenotime.net>
	 <20051003094803.GC3500@home.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Oct 02, 2005 at 10:39:22AM -0700, Randy.Dunlap wrote:
> > On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:
> >
> > > If release_resource() is passed a NULL resource
> > > the kernel will OOPS.
> >
> > does this actually happen?  you are fixing a real oops?
> > if so, what driver caused it?
>
> I was developing a couple of new drivers, and found
> that this does not behave like kfree() which does check
> for NULL paramemters. I belive it would be helpful if
> functions like this followed the example of kfree().
>
I would agree that it makes sense for resource release functions to be
written defensively and be able to cope with being passed a NULL
resource, just like kfree(), vfree(), crypto_free_tfm() and others are
already doing.
Seems safer and allows us to get rid of checks for NULL before calling
such functions thus making code simpler, more readable and in some
cases smaller.

Just my 0.02euro

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
