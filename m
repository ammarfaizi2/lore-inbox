Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUIFNgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUIFNgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUIFNgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:36:17 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:4496 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267543AbUIFNgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:36:16 -0400
Date: Mon, 6 Sep 2004 15:35:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040906133523.GC25429@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904153902.6ac075ea.akpm@osdl.org> <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 September 2004 14:45:38 +0200, Gunnar Ritter wrote:
> 
> It is an even more serious problem in my experience. I have been
> using sendfile() in my cp command at <http://heirloom.sourceforge.net>
> for quite some time, and I quickly decided to send files separated in
> some decently sized blocks. Otherwise if a whole file is sent at once
> and the source file is e.g. on an uncached floppy disk, cp will become
> uninterruptible for about a minute, which is a serious usability flaw.
> The user might discover that he is copying the wrong file, or he might
> simply change his mind and like to abort the copy or whatever. A
> performance gain of only 10 % is neglegible in comparison to this
> problem. Thus I think if copyfile() would not be interruptible by SIGINT
> and friends, its practical value would be quite limited.

Using a loop of 4k sendfile commands should be easy enough to do.
Problem is that copyfile(2) should do some decent cleanup after
receiving a signal.  Hans Reiser got it right that all filesystem
operations should be atomic.

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth
