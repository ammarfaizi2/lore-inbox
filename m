Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUE1FBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUE1FBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 01:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUE1FBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 01:01:04 -0400
Received: from fmr01.intel.com ([192.55.52.18]:53987 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265805AbUE1FBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 01:01:00 -0400
Date: Fri, 28 May 2004 12:50:17 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Auzanneau Gregory <mls@reolight.net>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: idebus setup problem (2.6.7-rc1)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84047998B0@PDSMSX403.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.44.0405281244220.22881-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Auzanneau Gregory wrote:
> 
> Hello,
> 
> It seems there is a problem with idebus parameter with 2.6.7-rc1.
> Indeed, it doesn't take into account lilo append.
> 
> With 2.6.7-rc1-mm1, i've got:
> Kernel command line: BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> 
> With 2.6.6-mm3, i've got:
> May 24 11:37:43 greg-port kernel: Kernel command line:
> BOOT_IMAGE=LinuxNEW ro root=304 idebus=66
> May 24 11:37:43 greg-port kernel: ide_setup: idebus=66
> May 24 11:37:43 greg-port kernel: ide: Assuming 66MHz system bus speed
> for PIO modes

My bad. I missed ide_setup(), please try below patch.

--- linux-2.6.7-rc1-mm1.orig/init/main.c	2004-05-28 12:39:15.549314064 +0800
+++ linux-2.6.7-rc1-mm1/init/main.c	2004-05-28 12:40:29.399087192 +0800
@@ -162,7 +162,7 @@ static int __init obsolete_checksetup(ch
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (len <= n && !strncmp(line, p->str, n)) {
+		if (n == 0 || (len <= n && !strncmp(line, p->str, n))) {
 			/* Already done in parse_early_param? */
 			if (p->early)
 				return 1;


Andrew, could you apply?

Thanks,
-yi

