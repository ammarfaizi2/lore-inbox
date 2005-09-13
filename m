Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVIMGtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVIMGtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVIMGtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:49:21 -0400
Received: from smtpout.mac.com ([17.250.248.71]:19170 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932407AbVIMGtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:49:19 -0400
In-Reply-To: <20050913063028.GQ25261@ZenIV.linux.org.uk>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk> <20050911220328.GE2177@mars.ravnborg.org> <20050911231601.GL25261@ZenIV.linux.org.uk> <20050912191525.GA13435@mars.ravnborg.org> <20050913063028.GQ25261@ZenIV.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A89F249-1859-45CD-B9A2-F21EE98855FB@mac.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: asm-offsets.h is generated in the source tree
Date: Tue, 13 Sep 2005 02:48:43 -0400
To: Al Viro <viro@ZenIV.linux.org.uk>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:15:25PM +0200, Sam Ravnborg wrote:
> o Use some magic define trick like:
>   - #include "ARCHDIR##foo.h"
>   - I cannot recall correct syntax but something like this is doable

The syntax for that is one of the following:

# define STR(x) #x
# define XSTR(x) STR(x)

# define SOME_ARCH_DIR foo/bar
# define STRING_INCLUDE(path) XSTR(SOME_ARCH_DIR/path)
# define ANGLE_INCLUDE(path) <SOME_ARCH_DIR/path>

Then:
# include STRING_INCLUDE(baz.h)    ==>    # include "foo/bar/baz.h"
# include ANGLE_INCLUDE(baz.h)     ==>    # include <foo/bar/baz.h>

I'm not sure what GCC version these were first supported in, but I
would try to stay away from them as a matter of principle.  They're
ugly and quite hard to read/understand.  If there were no other way,
I might use those, but since there probably is...  I dunno about
you, but those are some really icky constructions.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



