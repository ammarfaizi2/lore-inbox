Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVIRBQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVIRBQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 21:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVIRBQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 21:16:43 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:30982 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751270AbVIRBQm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 21:16:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LzlZQzgLd7GyLi9/3YT672B/izymofFLfLCbE6aRklVyQjrFd6IunVCTcyVRE6ouoRH3GhsWozQkyr4ck/ElcJNGBZxbFRFzwlDNvm7fWlSkmh4xflEHz4l7vujfncAc+UnB6f2ki8oXxQOn2RfI7L3WbEnFqea/tPjzPO8xOb0=
Message-ID: <9a87484905091718163bb72e58@mail.gmail.com>
Date: Sun, 18 Sep 2005 03:16:40 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Why don't we separate menuconfig from the kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3d5n7kwwz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m364szk426.fsf@defiant.localdomain>
	 <9a874849050917174635768d04@mail.gmail.com>
	 <m3d5n7kwwz.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Sep 2005 03:05:32 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> writes:
> 
> > What exactely is it you want to make a sepperate package?
> 
> Just the menuconfig (mconf) at first. OTOH it might make sense to
> move them all.
> 

And if you do that, then you'd be shipping a kernel source that it
would be impossible for users to configure without installing
sepperate tools - and tools (unlike for example gcc) that very few
people would have a need for outside configuring their kernel.
Not a good idea in my oppinion.


> > menuconfig is just a little bit of the kbuild system which also
> > includes xconfig, config, gconfig, oldconfig, etc.  menuconfig is just
> > a dialog based frontend to the kbuild system which consists of
> > configuration options, help texts, dependency info etc.
> 
> Sure, that's what I mean. It's used for configuring the kernel, but
> other packages use it (well, some version) too. Example: busybox.
> 
> There is no much point in keeping more than one copy. They are
> completely independent of the kernel, all the kernel wants is to pass

I think there's a point; the kernel source should contain its own
configuration tools.
Just think of how many users would complain that "the kernel is
broken, I can't configure it" and similar. Also, what would ensure
that the config/build tools would always stay in sync with other
kernel changes?  Right now things stay in sync since everyone are
using the same version of the tools that ship with any given kernel
and if something breaks it's fixed up along with everything else. Move
it out of the kernel tree and you'll end up having users trying to use
old tools to build a new kernel (or new tools to build an old kernel)
and there's bound to be breakage at some point - why have those extra
problems?


> them some Kconfig file and expect data in .config. (oldconfig uses
> .config.old).
> 
if you extract a fresh kernel source and copy your old .config to
.config in the new kernel source dir, then "make oldconfig" will read
that .config and write a new one as well...

> There is a question about config language and possible future changes.
> Not a serious problem IMHO.
> 
I disagree.


> > I don't think it makes much sense to split the parts of kbuild that
> > make up menuconfig out into a standalone thing. kbuild (and thus
> > menuconfig) has little use outside the kernel.
> 
> It's not exactly the case.

If someone wants to use the tools outside the kernel, then let them
fork off a version and maintain that out-of tree. The in-kernel and
out-of-kernel could borrow code and fixes from eachother if
needed/wanted, but I personally believe there needs to be a version
shipping as part of the source tree.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
