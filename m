Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUCPKR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCPKR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:17:28 -0500
Received: from gprs214-17.eurotel.cz ([160.218.214.17]:64899 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261166AbUCPKR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:17:26 -0500
Date: Tue, 16 Mar 2004 11:17:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Remove pmdisk from kernel
Message-ID: <20040316101715.GA2175@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz> <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz> <20040315132146.24f935c2.akpm@osdl.org> <1079379519.5350.20.camel@calvin.wpcb.org.au> <20040316005618.GB1883@elf.ucw.cz> <1079393256.2043.5.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1079393256.2043.5.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 16-03-04 12:27:36, Nigel Cunningham wrote:
> On Tue, 2004-03-16 at 13:56, Pavel Machek wrote:
> > 
> > > Most of those changes are hooks to make the freezer for more reliable.
> > > That part of the functionality could be isolated from the bulk of
> > > suspend2. Would that make you happy?
> > 
> > Yes, that would be very good. It would make it easy to see actual
> > changes..
> > 
> > [I still do not understand why those hooks are neccessary... kill
> > -SIGSTOP works, right?]
> 
> Not always. Take for example the case where you have an NFS mount and
> happen to be doing an ls when the suspend cycle is started. If you
> signal the NFSd threads before the ls thread, the NFS threads will
> refrigerate okay, but the ls thread will fail to stop because it's
> waiting for data from the nfsd threads.

Hmm, you are right that with dead nfs server, kill -SIGSTOP will fail
on ls, and similary current refrigerator will fail. I think we can
live with that.

I agree that two-stage suspend is probably neccessary (userland first,
kernel than); but that should be possible without that big changes,
right?

> The best way to test the reliability of the current freezer
> implementation is to grab Michael's test patches. They can load the
> system down with NFS access, kernel compiles, benchmarks and so on.
> You'll quickly see the freezer fail. My implementation handles those
> loads flawlessly, and where problems are found, they're easily fixed.

Your solution is more reliable, thats right.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
