Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVHUFIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVHUFIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 01:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVHUFIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 01:08:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51095 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750799AbVHUFIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 01:08:34 -0400
Date: Sun, 21 Aug 2005 06:11:31 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: s390 build fix.
Message-ID: <20050821051131.GH29811@parcelfarce.linux.theplanet.co.uk>
References: <20050821043839.GA28550@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821043839.GA28550@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 12:38:39AM -0400, Dave Jones wrote:
> {standard input}: Assembler messages:
> {standard input}:397: Error: symbol `.Litfits' is already defined
> {standard input}:585: Error: symbol `.Litfits' is already defined
> 
> Newer gcc's inline this it seems, which blows up.

Eeek...  Much easier (and already sent to Linus):

diff -urN RC13-rc6-git2-arm-float/arch/s390/kernel/cpcmd.c RC13-rc6-git2-s390/arch/s390/kernel/cpcmd.c
--- RC13-rc6-git2-arm-float/arch/s390/kernel/cpcmd.c	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git2-s390/arch/s390/kernel/cpcmd.c	2005-08-10 20:38:56.000000000 -0400
@@ -46,9 +46,9 @@
 				"lra	3,0(%4)\n"
 				"lr	5,%5\n"
 				"diag	2,4,0x8\n"
-				"brc	8, .Litfits\n"
+				"brc	8, 1f\n"
 				"ar	5, %5\n"
-				".Litfits: \n"
+				"1: \n"
 				"lr	%0,4\n"
 				"lr	%1,5\n"
 				: "=d" (return_code), "=d" (return_len)
@@ -64,9 +64,9 @@
 				"sam31\n"
 				"diag	2,4,0x8\n"
 				"sam64\n"
-				"brc	8, .Litfits\n"
+				"brc	8, 1f\n"
 				"agr	5, %5\n"
-				".Litfits: \n"
+				"1: \n"
 				"lgr	%0,4\n"
 				"lgr	%1,5\n"
 				: "=d" (return_code), "=d" (return_len)
