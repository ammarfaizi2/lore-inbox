Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSGQCMB>; Tue, 16 Jul 2002 22:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318195AbSGQCMB>; Tue, 16 Jul 2002 22:12:01 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:36994 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318194AbSGQCMA>;
	Tue, 16 Jul 2002 22:12:00 -0400
Date: Wed, 17 Jul 2002 12:12:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: rmk@arm.linux.org.uk, bjornw@axis.com, davidm@hpl.hp.com, paulus@samba.org,
       anton@samba.org, engebret@us.ibm.com, jes@trained-monkey.org,
       ralf@gnu.org, schwidefsky@de.ibm.com, davem@redhat.com, gniibe@m17n.org,
       ak@suse.de
Subject: [PATCH] consolidate asm/signal.h
Message-Id: <20020717121215.2b9f5ac2.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch creates asm-generic/signal.h and consolidates as much as
possible out of the various asm/signal.h filesin into it.  Please
test (especially the architecture maintiners).

The patch is at http://www.canb.auug.org.au/~sfr/2.5.26-si.1.diff.gz

The diffstat looks like this:

 asm-alpha/signal.h   |   77 +-------------
 asm-arm/signal.h     |  159 -----------------------------
 asm-cris/signal.h    |  169 -------------------------------
 asm-generic/signal.h |  271 +++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-i386/signal.h    |  173 --------------------------------
 asm-ia64/signal.h    |  117 +---------------------
 asm-m68k/signal.h    |  168 -------------------------------
 asm-mips/signal.h    |   73 +------------
 asm-mips64/signal.h  |   67 +-----------
 asm-parisc/signal.h  |   99 +++---------------
 asm-ppc/signal.h     |  141 --------------------------
 asm-ppc64/signal.h   |  137 -------------------------
 asm-s390/signal.h    |  146 ---------------------------
 asm-s390x/signal.h   |  146 ---------------------------
 asm-sh/signal.h      |  158 -----------------------------
 asm-sparc/signal.h   |   82 +++++----------
 asm-sparc64/signal.h |   79 ++++----------
 asm-x86_64/signal.h  |  150 +---------------------------
 linux/signal.h       |    4 
 19 files changed, 406 insertions(+), 2010 deletions(-)

The only semantic change should be the removal of SIGUNUSED from all
architecures except i386 and parisc (and I don't know why they still
use it).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
