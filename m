Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279973AbRJ3PPB>; Tue, 30 Oct 2001 10:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279972AbRJ3POv>; Tue, 30 Oct 2001 10:14:51 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:61711 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S279974AbRJ3POi>; Tue, 30 Oct 2001 10:14:38 -0500
Date: Tue, 30 Oct 2001 15:15:07 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@caldera.de>
Subject: Re: [PATCH] syscall exports - against 2.4.14-pre3
Message-ID: <20011030151505.B7294@compsoc.man.ac.uk>
In-Reply-To: <20011029173711.B24272@caldera.de> <3BDE7D22.8000006@purplet.demon.co.uk> <20011030113731.A14808@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030113731.A14808@caldera.de>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 11:37:31AM +0100, Christoph Hellwig wrote:

> This is not only racy (no locking!) but also a loophole for binary
> modules to do all kinds of crap (see http://www.sysinternals.com/linux/
> utilities/filemon.shtml for details).  In early 2.5 I will submit a patch
> to remove the export, let's see wether it will be accepted.

This means that "funky" modules that do overload system calls will break
irredeemably. Yes, it's ugly, and dangerous, but is definitely useful in
a small number of situations.

What would nice is a "transparent" binfmt a module could add, that always is
first on the binfmt chain and lets things pass through, 
plus some method to intercept syscalls nicely.

A transparent binfmt could be ref-counted also, avoiding the SMP module unload
races in these types of modules.

Before you ask, yes I tried the user-space methods of tracing syscall behaviour.
It was not only unreliable and racy, but slow as hell.

regards
john

-- 
"If the software that a company produces isn't reliable, adding a bunch of
'Mother, may I' rules to the language and the code won't fix it."
	- Pete Becker
