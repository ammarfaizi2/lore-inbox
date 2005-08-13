Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVHMQ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVHMQ5J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVHMQ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:57:08 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:6296 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932215AbVHMQ5H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:57:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AZBi08TB0dSGSsf3BWGo060+q6s1h5+gzmiX5RtC2BJdNnvFkWfUssbvAFoXojaE3mmSy0WJ9OX889SlDA6NTFheBqgulpna/daMcZaPavXKXEvGxLL7Vf41Y+mubIPKxCPfJXvBeVS0hAURtdpb3qj7jU3MZczvsQaTHk6FxAE=
Message-ID: <bda6d13a05081309575498f1bb@mail.gmail.com>
Date: Sat, 13 Aug 2005 09:57:02 -0700
From: Joshua Hudson <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
In-Reply-To: <1123951810.3187.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2005-08-12 at 09:35 -0700, Linus Torvalds wrote:
> >
> > On Thu, 11 Aug 2005, Steven Rostedt wrote:
> > >
> > > Found the problem.  It is a bug with mmap_kmem.  The order of checks is
> > > wrong, so here's the patch.  Attached is a little program that reads the
> > > System map looking for the variable modprobe_path.  If it finds it, then
> > > it opens /dev/kmem for read only and mmaping it to read the contents of
> > > modprobe_path.
> >
> > I'm actually more inclined to try to deprecate /dev/kmem.. I don't think
> > anybody has ever really used it except for some rootkits. It only exists
> > in the first place because it's historical.
> >
> > We do need to support /dev/mem for X, but even that might go away some
> > day.
> >
> > So I'd be perfectly happy to fix this, but I'd be even happier if we made
> > the whole kmem thing a config variable (maybe even default it to "off").
> 
I believe rootkit detectors, as well as some versions of ps (wchan
field) use kmem.
