Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUIFOcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUIFOcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUIFOcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:32:17 -0400
Received: from mx02.qsc.de ([213.148.130.14]:5508 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268069AbUIFOcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:32:07 -0400
Date: Mon, 06 Sep 2004 16:32:06 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
 <20040904153902.6ac075ea.akpm@osdl.org>
 <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
 <20040906133523.GC25429@wohnheim.fh-wedel.de>
In-Reply-To: <20040906133523.GC25429@wohnheim.fh-wedel.de>
User-Agent: nail 11.6pre 9/6/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> On Mon, 6 September 2004 14:45:38 +0200, Gunnar Ritter wrote:
> > It is an even more serious problem in my experience. I have been
> > using sendfile() in my cp command at <http://heirloom.sourceforge.net>
> > for quite some time, and I quickly decided to send files separated in
> > some decently sized blocks. Otherwise if a whole file is sent at once
> > and the source file is e.g. on an uncached floppy disk, cp will become
> > uninterruptible for about a minute, which is a serious usability flaw.
> > The user might discover that he is copying the wrong file, or he might
> > simply change his mind and like to abort the copy or whatever. A
> > performance gain of only 10 % is neglegible in comparison to this
> > problem. Thus I think if copyfile() would not be interruptible by SIGINT
> > and friends, its practical value would be quite limited.
>
> Using a loop of 4k sendfile commands should be easy enough to do.

Heck, guess what I did (although 4k seems a bit small).

> Problem is that copyfile(2) should do some decent cleanup after
> receiving a signal.  Hans Reiser got it right that all filesystem
> operations should be atomic.

Then I don't see the point in having a copyfile system call. In
fact, I would consider to deactivate it in every kernel derivative
I'm responsible for to prevent hanging applications.

	Gunnar
