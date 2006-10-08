Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWJHWtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWJHWtv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWJHWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:49:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:11358 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932082AbWJHWtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:49:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K8zEWsTTXeKvMbCMo9tGzr3wIcq+kvMjCDEOpb2zoRa38xh++yAAQcg6qt0iFMa7iOEQCli39NcvsMe+KpOg+kSou/pp6u9Gv/sLgUq4xD6xRjkFV+NOnNxJ+YlQo2PNuKN8Qg0TOZ50xumcKfnMabAFAoLF19fUurwK5kOSYFs=
Message-ID: <9a8748490610081549v255baf35m9a5f52bfb81bb4dc@mail.gmail.com>
Date: Mon, 9 Oct 2006 00:49:50 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Funky "Blue screen" issue while rebooting from X with 2.6.18-git21
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org
In-Reply-To: <20061008215110.GF4152@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com>
	 <20061008174759.GF6755@stusta.de> <20061008183406.GA4496@ucw.cz>
	 <9a8748490610081446y6103a9b1o491ce87250beabfb@mail.gmail.com>
	 <20061008215110.GF4152@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > >> > I have a strange "problem" with 2.6.18-git21 that I've never had with
> > >> > any previous kernel. If I open up an xterm in X, su to root and
> > >> > 'reboot' (or 'shutdown -r now') I instantly get a blue screen that
> > >> > persists until the box actually reboots.
> > >>
> > >> Pavel, is this a known issue or should Jesper bisect?
> > >
> > >Jesper should show it is kernel problem and not userland race.
> > >
> >
> > Jesper will try to do that ;-)
> >
> >
> > >If userspace does kill -15 -1; kill -9 -1, and X fails to shut down in
> > >time, it is userland problem ('should wait for X to shut down').
> > >
> >
> > Well, I just checked my initscript that is run when going into
> > runlevels 0 & 6, and it does this :
> >
> > (...)
> >
> > # Kill all processes.
> > # INIT is supposed to handle this entirely now, but this didn't always
> > # work correctly without this second pass at killing off the processes.
> > # Since INIT already notified the user that processes were being killed,
> > # we'll avoid echoing this info this time around.
> > if [ ! "$1" = "fast" ]; then # shutdown did not already kill all processes
> >  /sbin/killall5 -15
> >  /bin/sleep 5
> >  /sbin/killall5 -9
> > fi
>
> ...so, if X takes more than five seconds to shut down, you kill it
> with -9, resulting in blue screen. Too bad, and not an kernel problem.
>
> Try inserting something like
>
>         while ps -aux | grep myXserver;
>                 sleep 1;
>         done
>
> alternatively, remove/shorten the sleep and you should experience blue
> screen in 2.6.17.
>

I'll try and test these things and report back in a few days when I've
gathered some data.


> > kernels, but since somewhere in the 2.6.18-rc series I've experienced
> > this "blue screen" problem once in a while and I've also had a problem
> > with the screen going all white when switching from X to a plain tty
> > and back (once it goes white it stays that way permanently until I
> > reboot) - I *never* see those issues when running 2.6.17.x and
> > earlier.
>
> Maybe something got slower in 2.6.18?
>                                                                 Pavel
>
Perhaps...

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
