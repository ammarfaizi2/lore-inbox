Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSKKQXO>; Mon, 11 Nov 2002 11:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSKKQXO>; Mon, 11 Nov 2002 11:23:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41034 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265815AbSKKQXL>; Mon, 11 Nov 2002 11:23:11 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	<3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
	<20021105171230.A11443@in.ibm.com>
	<20021105150048.H1408@almesberger.net>
	<20021109212103.GA239@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2002 09:27:05 -0700
In-Reply-To: <20021109212103.GA239@elf.ucw.cz>
Message-ID: <m165v4ax7q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> I have very similar problem in swsusp (need to deactivate DMA
> devices), and driverfs^H^H^H^H^Hsysfs framework seems to be suitable
> for that.

Yes.  The problem and the solutions are very similar.  Because you are
restoring the kernel code I don't think we can use the same functions,
but similar work needs to be done.    The correct hook for reboots,
halts, kexec, and  other cases where the kernel is going away is
device_shutdown which currently calls device->shutdown().  Since the
implementation has changed recently to avoid other problems no one
actually implements the shutdown method at the moment.  Once that
happens we can probably kill the reboot notifiers.  But there is a lot
of driver work to do on that score.

Eric
