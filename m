Return-Path: <linux-kernel-owner+w=401wt.eu-S1755275AbXABGLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbXABGLy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 01:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbXABGLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 01:11:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52830 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275AbXABGLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 01:11:53 -0500
Date: Tue, 2 Jan 2007 11:41:47 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, segher@kernel.crashing.org
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20070102061147.GA30308@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221145922.16ee8dd7.khali@linux-fr.org> <1166723157.29546.281560884@webmail.messagingengine.com> <20061221204408.GA7009@in.ibm.com> <20061222090806.3ae56579.khali@linux-fr.org> <20061222104056.GB7009@in.ibm.com> <20070101223913.7b1fddbf.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070101223913.7b1fddbf.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 10:39:13PM +0100, Jean Delvare wrote:
> Hi Vivek,
> 
> Sorry for the delay, I'm just back from vacation. I tried it all again
> with 2.6.20-rc3 just in case, but the problem I've hit is still present.
> 

Hi Jean,

Problem in not fixed yet in -rc3. So testing -rc3 will not help.

Segher had suggested to use .section command to specifically mark
.text.head section as AX (allocatable and executable) to solve the
problem.

Can you please try the attached patch to see if it solves your
problem.

Thanks
Vivek


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

