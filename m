Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVINNNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVINNNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVINNNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:13:06 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:37041 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965188AbVINNNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:13:05 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.13: More on drivers/block/loop.c
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050914135118.A25087@pixie.comlab>
References: <20050909132725.C23462@pixie.comlab>
	 <20050914135118.A25087@pixie.comlab>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Wed, 14 Sep 2005 14:12:48 +0100
Message-Id: <1126703569.331.30.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 13:51 +0100, Ian Collier wrote:
> Vanilla 2.6.13 doesn't crash.
> 
> However, unpack a fresh copy of 2.6.13, edit include/linux/loop.h to
> change LO_KEY_SIZE from 32 to 1844, and *boom*.  [Don't ask me why
> 1844... that's just what PPDD wants.]
> 
> It's crashing somewhere in loop_set_status_old, probably during the
> call to copy_from_user, but the crash messages aren't that helpful as
> they are different each time, often seem to happen during an interrupt,
> and usually contain pages of recursive calls to do_page_fault and
> error_code.
> 
> The loop_set_status_old function has two local variables, each of which
> is now 1812 bytes longer than it was, and I'm wondering if it's a stack
> overflow problem.  How much stack is a kernel function allowed to use,
> anyway?
> 
> Replacing these variables with kmalloc'd pointers seems to stop the crashes
> anyway, so I'll pass that tip on to the PPDD folks.

Not surprising.  The _entirety_ of the kernel, i.e. not just each
function, has either 4k or 8k of stack (depending on a .config option)
so having two local variables of 1812 bytes each is _guaranteed_ to blow
the stack.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

