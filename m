Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293526AbSBZFxy>; Tue, 26 Feb 2002 00:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293524AbSBZFxp>; Tue, 26 Feb 2002 00:53:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2573 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293522AbSBZFxa>; Tue, 26 Feb 2002 00:53:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ext3 and undeletion
Date: 25 Feb 2002 21:53:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a5f7s4$2o1$1@cesium.transmeta.com>
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <02022518330103.01161@grumpersII>
By author:    Tom Rauschenbach <tom@rauschenbach.mv.com>
In newsgroup: linux.dev.kernel
>
> On Monday 25 February 2002 12:20, Mike Fedyk wrote:
> > On Mon, Feb 25, 2002 at 12:06:29PM -0500, Dan Maas wrote:
> > > > but I don't want a Netware filesystem running on Linux, I
> > > > want a *native* Linux filesystem (i.e. ext3) that has the
> > > > ability to queue deleted files should I configure it to.
> > >
> > > Rather than implementing this in the filesystem itself, I'd first try
> > > writing a libc shim that overrides unlink(). You could copy files to
> > > safety, or do anything else you want, before they actually get deleted...
> >
> > Yep, more portable.
> 
> But it only works if everything get linked with the new library.
> 

What's a lot worse is that the kernel cannot chose to garbage-collect
it.  One reason to put undelete in the kernel is that that files in
limbo can be reclaimed as the disk space is needed for other users,
and you don't risk getting ENOSPC due to the disk being full with
ghosts.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
