Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQL2DCI>; Thu, 28 Dec 2000 22:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbQL2DB6>; Thu, 28 Dec 2000 22:01:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:1386 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129525AbQL2DBk>; Thu, 28 Dec 2000 22:01:40 -0500
Date: Fri, 29 Dec 2000 03:29:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jure Pecar <pegasus@telemach.net>
Cc: linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229032953.A9810@athlon.random>
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net>; from pegasus@telemach.net on Fri, Dec 29, 2000 at 02:32:32AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 02:32:32AM +0100, Jure Pecar wrote:
> Hi all,
> 
> I'm expiriencing a problem with thttpd web server
> (www.acme.com/software/thttpd) on recent linux 2.2 kernels with Andrea's
> VM-global patches. Without the patch server runs normally with its usual

Before the -7 revision the VM-global was sharing a memory corruption bug with
vanilla 2.2.x. VM-global was incidentally hiding such bug extremely well though
(but with heavy load and using LVM snapshotting I triggered it even under
VM-global-6, so then I spotted such last leftover too and the strict fix for
such MM corruption bug got merged into 2.2.18pre2x too, and at the same time I
released VM-global-7)

I need to know exactly which kernel sources you were using (and also the
compiler of course ;)

> dose of complaints on the linux platform (it's being developed on BSD
> afaik), but with the patch it runs ok for about three days (depends on
> traffic i guess), then enters into some state where it reports 'out of
> memory' for every larger file (>1Mb) it starts serving and dies. When it

out of memory looks an userspace message, so it looks like malloc request was
too large (it could happen because of an userspace corruption in the 'size'
parameter for example).

> comes back up it dies again whitin 10 seconds. As this is not happening
> on a stock kernel and the restart of the server itself has no efect, i
> conclude it has to be something there in the VM-global that thttpd
> doesnt really like. As the VM-global seems to be the only cure for the
> VM_do_try_to_free_pages problem, which is an issue for me too, i'd
> really like to hear some official words on this before 2.2.19 comes out
> with VM-global ... and while i'm at it, can we expect ide patch in
> 2.2.19 too?

Even if you are using VM-global-7 with only this information it's non obvious
that VM-global-7 (the one included 19pre3) is the source of your problem.

So if you were using the -7 revision please check the logs and the console for
Oopses and try to strace the daemon to see how it dies. It's also not clear
what it means that restarting the server itself has no effect, as far I can
tell it could even be an userspace issue (some rc script that doesn't cope with
an unclean exit of the server?). And besides the webserver, how does the rest
of the system behaves when the problem appears? There are too many
possibilities, we need to restrict our search.

You were using -6 revision as first thing you can try to reproduce with
2.2.19pre3 after checking the compiler. If you send me your .config I can send
you a binary image to test.

Thanks for the feedback,
Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
