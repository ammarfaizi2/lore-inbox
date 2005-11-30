Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVK3EYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVK3EYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVK3EYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:24:07 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27624 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750913AbVK3EYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:24:06 -0500
Date: Tue, 29 Nov 2005 23:21:18 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130042118.GA19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

The following emails contain the patches to convert x86-64 to store current 
in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This 
provides a significant amount of code savings (~43KB) over the current 
use of the per cpu data area.  I also tested using r15, but that generated 
code that was larger than that generated with r10.  This code seems to be 
working well for me now (it stands up to 32 and 64 bit processes and ptrace 
users) and would be a good candidate for further exposure.

		-ben

 arch/i386/oprofile/nmi_int.c         |    1 
 arch/x86_64/Makefile                 |    1 
 arch/x86_64/crypto/aes-x86_64-asm.S  |   27 +++++++++++----------
 arch/x86_64/ia32/ia32entry.S         |   17 +++++++++----
 arch/x86_64/kernel/asm-offsets.c     |    2 -
 arch/x86_64/kernel/entry.S           |   44 +++++++++++++++--------------------
 arch/x86_64/kernel/genapic_cluster.c |    1 
 arch/x86_64/kernel/genapic_flat.c    |    1 
 arch/x86_64/kernel/i387.c            |    2 -
 arch/x86_64/kernel/process.c         |    8 ++++--
 arch/x86_64/kernel/setup64.c         |   16 +++++++-----
 arch/x86_64/kernel/smpboot.c         |    6 +++-
 arch/x86_64/lib/copy_user.S          |   16 ++++++------
 arch/x86_64/lib/csum-copy.S          |   24 ++++++++++---------
 arch/x86_64/lib/getuser.S            |   12 +++------
 arch/x86_64/lib/putuser.S            |   12 +++------
 include/asm-x86_64/current.h         |    8 ------
 include/asm-x86_64/desc.h            |    1 
 include/asm-x86_64/i387.h            |    8 +++---
 include/asm-x86_64/processor.h       |   10 ++-----
 include/asm-x86_64/system.h          |    6 +---
 include/asm-x86_64/thread_info.h     |   31 +++++++++++-------------
 include/linux/seccomp.h              |   15 ++++-------
 include/linux/smp.h                  |   25 ++++++++++---------
 24 files changed, 145 insertions(+), 149 deletions(-)
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.

