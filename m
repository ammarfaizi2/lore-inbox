Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUIATSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUIATSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIATSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:18:46 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:33863 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267406AbUIATSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:18:44 -0400
Date: Wed, 1 Sep 2004 21:20:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Carsten Milling <cmil@hashtable.de>
Subject: Re: [PATCH][PPC32] Fix the 'checkbin' target
Message-ID: <20040901192054.GA7219@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Carsten Milling <cmil@hashtable.de>
References: <20040901180356.GD19730@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901180356.GD19730@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 11:03:56AM -0700, Tom Rini wrote:
> Hello.
> 
> Currently, the checkbin target on PPC32 isn't quite right.  First, one
> of the tests (to ensure that some instructions are known to gas) is
> never actually invoked because 'checkbin' doesn't know about stuff set
> in .config, so we always have the 'else' case run.  This changes to
> always running the test and telling the user to upgrade to at least
> binutils 2.12.1.  The next problem is that we were doing $(AS) -o
> /dev/null ... in both that test, as well as another.  The problem here
> is that the checkbin target is run on the install targets, meaning that
> /dev/null will get unlinked when the test passes.  To get around this we
> use .tmp_gas_check as the output file instead.
> 
> Assuming Sam doesn't object, I hope this can go in quickly.  Thanks.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Looks good to me - and it solves the critical /dev/null
bug in ppc.

Linus please apply.

	Sam
