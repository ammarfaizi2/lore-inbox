Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUIFMp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUIFMp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUIFMps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:45:48 -0400
Received: from legaleagle.de ([217.160.128.82]:39069 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S267890AbUIFMpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:45:35 -0400
Date: Mon, 06 Sep 2004 14:45:38 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
 <20040904153902.6ac075ea.akpm@osdl.org>
In-Reply-To: <20040904153902.6ac075ea.akpm@osdl.org>
User-Agent: nail 11.6pre 9/6/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I discussed file->file sendfile with Linus a while back and he said
>
> > I think it was about doing a 2GB file-file sendfile, and see your system
> > grind to a halt without being able to kill it.
> > 
> > That said, we have some of the same problems with just regular read/write 
> > too. sendfile just makes it easier.
> > 
> > We should probably make read/write be interruptible by _fatal_ signals.  
> > It would require a new task state, though (TASK_KILLABLE or something, and
> > it would show up as a normal 'D' state).
>
> I don't know how much of a problem this is in practice

It is an even more serious problem in my experience. I have been
using sendfile() in my cp command at <http://heirloom.sourceforge.net>
for quite some time, and I quickly decided to send files separated in
some decently sized blocks. Otherwise if a whole file is sent at once
and the source file is e.g. on an uncached floppy disk, cp will become
uninterruptible for about a minute, which is a serious usability flaw.
The user might discover that he is copying the wrong file, or he might
simply change his mind and like to abort the copy or whatever. A
performance gain of only 10 % is neglegible in comparison to this
problem. Thus I think if copyfile() would not be interruptible by SIGINT
and friends, its practical value would be quite limited.

	Gunnar
