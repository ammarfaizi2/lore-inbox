Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUJQUCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUJQUCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQUCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:02:50 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:63257 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269284AbUJQUCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:02:45 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GUdGsKBCNQV/TPwmGUPbmUpCjzjBkWNVVH4aopmYDUbj58B1DubLp8iq5dmL6SFlEhluTl1s+HnR8hDv569XdRmt1P1nc6RPJ/6vFss+GaFhAdvVwNRA64x/bJvaar2jup/jeyGi9Z4adSmbuFeCdE6wACmiyIeacfml/GOubd8
Message-ID: <5d6b6575041017130213344fac@mail.gmail.com>
Date: Sun, 17 Oct 2004 22:02:44 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Martijn Sipkema <martijn@entmoot.nl>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <004601c4b489$c3486f80$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
	 <5d6b65750410170840c80c314@mail.gmail.com>
	 <000801c4b46f$b62034b0$161b14ac@boromir>
	 <5d6b65750410171033d9d83ab@mail.gmail.com>
	 <002b01c4b483$b2bef130$161b14ac@boromir>
	 <5d6b657504101712336468303c@mail.gmail.com>
	 <004601c4b489$c3486f80$161b14ac@boromir>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 21:42:04 +0100, Martijn Sipkema <martijn@entmoot.nl> wrote:
> From: "Buddy Lucas" <buddy.lucas@gmail.com>
> > On Sun, 17 Oct 2004 20:58:39 +0100, Martijn Sipkema <martijn@entmoot.nl> wrote:
> > > >
> > > > But then I am one of those who thinks it's sane to check for
> > > > EWOULDBLOCK on a nonblocking socket after blocking in select().
> > >
> > > A POSIX comliant implementation would never do this.
> >
> > Here's your own quote, from a couple of hundred mails ago:
> >
> > > According to POSIX:
> >
> > > A descriptor shall be considered ready for reading when a call to an
> > >  input function with O_NONBLOCK clear would not block, whether or not
> > >  the function would transfer data successfully.
> >
> > You concluded from this that, if select() says a descriptor is
> > readable, the subsequent recvmsg() must not block. The point is, from
> > your quote I cannot deduct anything but: a recvmsg() on a descriptor
> > that is readable must not block -- which makes perfect sense.
> >
> > But unless POSIX also says something about the conservability of
> > "readability" of descriptors, specifically in between select() and
> > recvmsg(), your conclusion is just wrong.
> 
> But with the current Linux implementation it is possible that a call to select()
> returns while a call to recvmsg() would have blocked, and that is not
> correct according to POSIX.

Come on. Those are different things. (If POSIX says this explicitly,
it's even more broken than I thought.)

> And I indeed read this as meaning that the first recvmsg() after the select()
> may not block.

Well, then you *are* wrong. ;-)


Cheers,
Buddy
