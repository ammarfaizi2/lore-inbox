Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277484AbRJEQkZ>; Fri, 5 Oct 2001 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277483AbRJEQkP>; Fri, 5 Oct 2001 12:40:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7221 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277484AbRJEQkJ>; Fri, 5 Oct 2001 12:40:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
In-Reply-To: <E15pFHW-00041w-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Oct 2001 10:30:19 -0600
In-Reply-To: <E15pFHW-00041w-00@the-village.bc.nu>
Message-ID: <m1zo76xd5w.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > On Thu, 4 Oct 2001, Linus Torvalds wrote:
> > 
> > > The reason the kernel refuses to honour it, is that MAP_DENYWRITE is an
> > > excellent DoS-vehicle - you just mmap("/etc/passwd") with MAP_DENYWRITE,
> > > and even root cannot write to it.. Vary nasty.
> > 
> > <nit>
> > I _really_ doubt that something does write() on /etc/passwd.  Create a
> > file and rename it over the thing - sure, but that's it.
> > </nit>
> 
> The MAP_DENYWRITE rule was added a long time ago because people found actual
> workable DoS attacks

Do you have any details.  I would like to figure out what it takes to
export MAP_DENYWRITE safely to userspace.

Currently checking to see if the file is executable looks good
enough.  I don't see any case where this would be a problem, unless
someone has set their permissions wrong.  

The fix for bad permission (during a DOS attack) is either:
	chmod correct_permissions foo
	lsof foo | xargs kill
or:
        chmod correct_permissions foo
	mv foo bar
        cp -a bar foo
        rm bar

Which looks fairly straight forward.

Eric
