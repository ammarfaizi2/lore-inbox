Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSENGDR>; Tue, 14 May 2002 02:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315223AbSENGDQ>; Tue, 14 May 2002 02:03:16 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:32944 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315222AbSENGDP>;
	Tue, 14 May 2002 02:03:15 -0400
Date: Tue, 14 May 2002 16:00:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, bjornw@axis.com, davidm@hpl.hp.com,
        paulus@au.ibm.com, engebret@us.ibm.com, jes@trained-monkey.org,
        ralf@gnu.org, schwidefsky@de.ibm.com, davem@redhat.com,
        gniibe@m17n.org, ak@suse.de
Subject: [PATCH] Signal cleanups part1: siginfo rationalisation
Message-Id: <20020514160043.05fbd4f1.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.canb.auug.org.au/15-si.1.1.diff.gz

[Please do not flame me too much, just be happy that I did not post
the whole 120K patch :-)]

This patch creates asm-generic/siginfo.h and uses it to remove a
lot of duplicate code in the various asm-*/siginfo.h files.  Some
if it is a little ugly, but I think it will be worth it just to
help us eliminate some of the bugs that have come from code copying.

diffstat looks like this:

 asm-alpha/siginfo.h   |  212 -----------------------------------------
 asm-arm/siginfo.h     |  230 ---------------------------------------------
 asm-cris/siginfo.h    |  229 ---------------------------------------------
 asm-generic/siginfo.h |  254 ++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-i386/siginfo.h    |  230 ---------------------------------------------
 asm-ia64/siginfo.h    |  145 ++--------------------------
 asm-m68k/siginfo.h    |  176 ----------------------------------
 asm-mips/siginfo.h    |  156 ++----------------------------
 asm-mips64/siginfo.h  |  155 ++----------------------------
 asm-parisc/siginfo.h  |  225 --------------------------------------------
 asm-ppc/siginfo.h     |  227 --------------------------------------------
 asm-ppc64/siginfo.h   |  228 --------------------------------------------
 asm-s390/siginfo.h    |  156 ------------------------------
 asm-s390x/siginfo.h   |  156 ------------------------------
 asm-sh/siginfo.h      |  229 ---------------------------------------------
 asm-sparc/siginfo.h   |  164 --------------------------------
 asm-sparc64/siginfo.h |  172 +--------------------------------
 asm-x86_64/siginfo.h  |  229 ---------------------------------------------
 18 files changed, 326 insertions(+), 3247 deletions(-)

so you can see there was LOTS of duplication :-)

Let me know if it is too ugly, otherwise, please apply.  This builds
on i386 and ppc64 and shouldn't (in theory) change the object code
produced (modulo some static/extern inlines).

I intent to follow this with more code consolidation and some bug fixes
to the siginfo handling code.

This is CC'd to all the architecture maintainers in the hope that they
will check that I have not broken them badly.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
