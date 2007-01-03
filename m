Return-Path: <linux-kernel-owner+w=401wt.eu-S1750817AbXACOSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbXACOSP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXACOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:18:14 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:52946 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbXACOSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:18:12 -0500
Date: Wed, 3 Jan 2007 19:48:07 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] i386 kernel instant reboot with older binutils fix
Message-ID: <20070103141807.GA8236@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20070103041645.GA17546@in.ibm.com> <20070103135326.GF20714@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103135326.GF20714@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 02:53:26PM +0100, Adrian Bunk wrote:
> On Wed, Jan 03, 2007 at 09:46:45AM +0530, Vivek Goyal wrote:
> >
> > o i386 kernel reboots instantly if compiled with binutils older than
> >   2.6.15.
> 
> Should that have been "2.15"?
> 

Yes Adrian, it should be 2.15 instead. My mistake.

Hopefully this patch should solve steve's issue too.

Reattaching the patch with corrected changelog.

Thanks
Vivek


o i386 kernel reboots instantly if compiled with binutils older than
  2.15.

o Older binutils required explicit flags to mark a section allocatable
  and executable(AX). Newer binutils automatically mark a section AX if
  the name starts with .text.

o While defining a new section using assembler "section" directive,
  explicitly mention section flags. 

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/boot/compressed/head.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/boot/compressed/head.S~jean-reboot-issue-fix arch/i386/boot/compressed/head.S
--- linux-2.6.20-rc2-reloc/arch/i386/boot/compressed/head.S~jean-reboot-issue-fix	2007-01-02 09:54:56.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/boot/compressed/head.S	2007-01-02 09:57:46.000000000 +0530
@@ -28,7 +28,7 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 
-.section ".text.head"
+.section ".text.head","ax",@progbits
 	.globl startup_32
 
 startup_32:
_
