Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313042AbSC0PlM>; Wed, 27 Mar 2002 10:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313040AbSC0PlC>; Wed, 27 Mar 2002 10:41:02 -0500
Received: from air-2.osdl.org ([65.201.151.6]:59776 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S312714AbSC0Pks>;
	Wed, 27 Mar 2002 10:40:48 -0500
Date: Wed, 27 Mar 2002 07:40:43 -0800
From: Bob Miller <rem@osdl.org>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 process accounting bombs out
Message-ID: <20020327074043.A2280@doc.pdx.osdl.net>
In-Reply-To: <m3bsdamrlw.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 01:50:35AM -0500, John Covici wrote:
> Whenever I try to start the init script for process accounting I get
> the following error:
> 
> Mar 27 00:02:02 ccs kernel: kernel BUG at acct.c:169!
> Mar 27 00:02:02 ccs kernel: invalid operand: 0000
> Mar 27 00:02:02 ccs kernel: CPU:    0
> Mar 27 00:02:02 ccs kernel: EIP:    0010:[acct_file_reopen+8/208]
> Not tainted
> Mar 27 00:02:02 ccs kernel: EFLAGS: 00010246
> 
> The system doesn't go down, but is there any way to fix this?
> 
> Thanks.
> 
> -- 
>          John Covici
>          covici@ccs.covici.com

Apply the patch below.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.538  
#	       kernel/acct.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/21	rem@doc.pdx.osdl.net	1.538
# Fixed acct.c code by removing the BUG_ON code because it doesn't work
# on UP systems.
# --------------------------------------------
#
diff -Nru a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	Thu Mar 21 11:32:05 2002
+++ b/kernel/acct.c	Thu Mar 21 11:32:05 2002
@@ -166,8 +166,6 @@
 {
 	struct file *old_acct = NULL;
 
-	BUG_ON(!spin_is_locked(&acct_globals.lock));
-
 	if (acct_globals.file) {
 		old_acct = acct_globals.file;
 		del_timer(&acct_globals.timer);
