Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278276AbRJMHrC>; Sat, 13 Oct 2001 03:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278277AbRJMHqw>; Sat, 13 Oct 2001 03:46:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:44041 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S278276AbRJMHqf>;
	Sat, 13 Oct 2001 03:46:35 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15303.61757.56505.363551@cargo.ozlabs.ibm.com>
Date: Sat, 13 Oct 2001 17:46:05 +1000 (EST)
To: Mike Borrelli <mike@nerv-9.net>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: No love for the PPC
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Borrelli writes:

> I'm sorry about the tone of this e-mail, but it is somewhat painful when,
> after downloading a new kernel to play with, it doesn't compile on the
> ppc.  It isn't even big problems either.  A single line (#include
> <linux/pm.h>) is missing from pc_keyb.c and has been for at least three
> -ac releases.  Now, process.c in arch/ppc/kernel/ dies from an undeclared
> identifier (init_mmap).

I'm afraid I am to blame for this one.  It looks like we sent Alan a
patch which isn't appropriate for Alan's tree (because Alan's and
Linus' trees VM system is different).  Here is a patch to reverse the
breakage.

> Anyway, the real question is, why does the ppc arhitecture /always/ break
> between versions?

Well, the port maintainers don't get any earlier access to the
releases than everyone else.  So if some change breaks the compile for
PPC (or any other architecture), we just have to send a patch to Linus
or Alan and hope that it gets accepted for the next release (when
there could easily be another change that breaks things in some other
way, of course).  That said, Alan is usually very good about accepting
our patches in a timely fashion, and as I said, the process.c breakage
is our fault not his.

With Linus' trees, it would be nice if there were some restrictions on
what sort of changes can go in between the last prerelease and the
final release - if it was restricted to changes under arch/ and
include/asm-*, obvious compile fixes, or really critical bug fixes,
then there would be a better chance that the final release would work
for most architectures.  But that does not seem to be a priority at
this stage.

Paul.

diff -urN ac2412-1/arch/ppc/kernel/process.c acppc/arch/ppc/kernel/process.c
--- ac2412-1/arch/ppc/kernel/process.c	Wed Oct 10 12:38:52 2001
+++ acppc/arch/ppc/kernel/process.c	Sat Oct 13 16:50:32 2001
@@ -48,6 +48,7 @@
 
 struct task_struct *last_task_used_math = NULL;
 struct task_struct *last_task_used_altivec = NULL;
+static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
