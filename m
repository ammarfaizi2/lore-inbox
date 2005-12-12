Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVLLUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVLLUaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVLLUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:30:52 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:23955 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750989AbVLLUav convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:30:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=htO80mSh+NwFjCyx2EzcHO4qhEJU0dCvdbZUca4z380ppfZW1Gu04Us3UEPFHXWk61yR722htg/3OCq7r0oiAWluNZNlRPvVzkhEi+nfmmenCo/LEHKfTjh1Ihkbi6/5grIVHnXrTc8/0njowwZqAIvL4eKpDgROrecWAa/uGj8=
Message-ID: <9a8748490512121230j7ae8058dy6b5994e472976f43@mail.gmail.com>
Date: Mon, 12 Dec 2005 21:30:50 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: Richard Henderson <rth@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ashutosh Naik <ashutosh.naik@gmail.com>, anandhkrishnan@yahoo.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <20051212202019.GA28131@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <20051212111322.40be4cfe.akpm@osdl.org>
	 <20051212192746.GE19245@redhat.com> <20051212202019.GA28131@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/05, Greg KH <greg@kroah.com> wrote:
> On Mon, Dec 12, 2005 at 11:27:46AM -0800, Richard Henderson wrote:
> > On Mon, Dec 12, 2005 at 11:13:22AM -0800, Andrew Morton wrote:
> > > Do we really need to do this at runtime?
> >
> > Probably.  One could consider this a security hole...
>
> Huh?  You are root and loading a kernel module.  You can do much worse
> things at this point in time than messing around with existing symbols
> :)
>
Sure, but having  insmod <foo>  crash the kernel is bad.

In my oppinion the kernel should be robust against accidental loading
of the wrong module. If the symbols of the module clashes with
in-kernel symbols, the logical thing is to reject the module load.

Sure you can do a lot worse things as root, but being able to cause a
crash with a standard tool such as insmod is pretty nasty and
something you can easily get into by accident.  You can't prevent root
from purposely screwing with the kernel, but accidental mis-loading of
a wrong module shouldn't cause a crash.


> I think it should be a build-time thing if possible.
>
If there's a way to revent it 100% at build time I'd agree, but if not
I'd say a runtime solution is required.

Just my 0.02 euro.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
