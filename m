Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270746AbRHSUiB>; Sun, 19 Aug 2001 16:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270750AbRHSUhv>; Sun, 19 Aug 2001 16:37:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53801 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270746AbRHSUhl>; Sun, 19 Aug 2001 16:37:41 -0400
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Paul <set@pobox.com>, Jeff Chua <jchua@fedex.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Aug 2001 14:30:29 -0600
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
Message-ID: <m166bjokre.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua <jeffchua@silk.corp.fedex.com> writes:

> On Sun, 19 Aug 2001, Paul wrote:
> > 	Actually, it works fine for me too, _if_ I use DOS 5 as
> > the boot image, but I changed to DOS 6.22, and its has oops'd
> > every time Ive tried it that way. Its just a trigger for whatever
> > the real problem is.
> >
> > Paul
> > set@pobox.com
> 
> I'm using dosemu-1.1.1.tgz with Windows 98 [Version 4.10.2222]
> 
> Does "dos" command works for you instead of "xdos" ?
> 
> Did you check your shmmax?
> 
> Try ...
> 	echo 1000000000 >/proc/sys/kernel/shmmax

This should be totally irrelevant.  You shouldn't be able to
crash linux with dosemu unless you are doing direct hardware access.

There are a number of cases, where dosemu is different enough it has
been known to cause code to go down buggy non-common paths and cause
things to fail.  This has happened with both X and the kernel.
I suspect that is what is happening here.

Paul is dosemu configured to do any direct hardware access?

Also of interest is that this crash is not even directly triggered by
the dosemu process.  Instead an interrupt handler is doing something
bad.  

Paul If you can verify that dosemu isn't doing any direct hardware
access.  i.e. Dosemu isn't suid root, and you have no ports lines
you should be fine.

Eric


