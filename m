Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSIOXyN>; Sun, 15 Sep 2002 19:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSIOXyN>; Sun, 15 Sep 2002 19:54:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3090 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318326AbSIOXyM>; Sun, 15 Sep 2002 19:54:12 -0400
Date: Sun, 15 Sep 2002 16:59:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Wilcox <willy@debian.org>
cc: mingo@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: problem with "Use CLONE_KERNEL for the common kernel thread
 flags"?
In-Reply-To: <20020915225419.F10583@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0209151657450.1586-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Matthew Wilcox wrote:
> 
> Seems to me like you missed something in your latest changeset:
> 
> -#define CLONE_SIGNAL   (CLONE_SIGHAND | CLONE_THREAD)
> +#define CLONE_KERNEL   (CLONE_FS | CLONE_FILES | CLONE_SIGHAND)
> -       kernel_thread(init, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
> +       kernel_thread(init, NULL, CLONE_KERNEL);
> 
> init used to be spawned with CLONE_THREAD and no longer is.  Was this
> intentional?

Yup. CLONE_THREAD has some new semantics these days, and is not
necessarily at all what a kernel thread wants any more. It used to not
matter at all, but these days it means that it gets put on the same thread
group list as the parent, which means that it won't show up on the global
list of processes any more (since it is considered a "subthread" of the
thread group leader).

		Linus

