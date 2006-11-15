Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030988AbWKOUoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030988AbWKOUoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030991AbWKOUoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:44:03 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37069 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030988AbWKOUoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:44:01 -0500
Date: Wed, 15 Nov 2006 20:49:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061115204915.1d0717db@localhost.localdomain>
In-Reply-To: <20061115202418.GC3875@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se>
	<20061112212941.GA31624@flint.arm.linux.org.uk>
	<20061112220318.GA3387@elte.hu>
	<20061112235410.GB31624@flint.arm.linux.org.uk>
	<20061114110958.GB2242@elf.ucw.cz>
	<1163522062.14674.3.camel@mindpipe>
	<20061115202418.GC3875@elf.ucw.cz>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 21:24:18 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2006-11-14 11:34:21, Lee Revell wrote:
> > On Tue, 2006-11-14 at 12:09 +0100, Pavel Machek wrote:
> > > Suspending with mounted floppy is a user error.
> > 
> > Huh?  How so?
> 
> Floppy is removable, and you are expected to umount removable devices
> before suspend.

That seems pretty crude. There are lots of cases where an apparently
removable device is/should be preserved properly and left mounted (eg
builtin CF).

We really want to be smarter than that - which means the drivers ought to
be doing stuff in their suspend/resume paths to figure out if the media
changed when really possible (eg IDE removable)

Floppy is probably not too fixable, but calling it a "user error" is
insulting - user expectation is reasonable that suspend/resume should
just work. The implementation is just rather trickier/nonsensical in this
case.
