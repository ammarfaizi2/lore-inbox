Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVBDWLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVBDWLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbVBDWGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:06:30 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:6035 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261295AbVBDVvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:51:25 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] 2.6.11-rc3-mm1: fix swsusp with gcc 3.4
Date: Fri, 4 Feb 2005 22:51:53 +0100
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org> <20050204201135.GD19408@stusta.de>
In-Reply-To: <20050204201135.GD19408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502042251.54316.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 of February 2005 21:11, Adrian Bunk wrote:
> On Fri, Feb 04, 2005 at 10:33:50AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.11-rc2-mm2:
> >...
> > +swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch
> > 
> >  swsusp fix
> >...
> 
> This broke compilation with gcc 3.4:
[-- snip --]

BTW, it requires the following bugfix, on top of the Adrian's patch.

Greets,
Rafael

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-04 22:33:52.000000000 +0100
+++ new/kernel/power/swsusp.c	2005-02-04 22:32:36.000000000 +0100
@@ -614,9 +614,9 @@
 	struct pbe *pbe;
 
 	while (pblist) {
-		pbe = pblist + PB_PAGE_SKIP;
-		pblist = pbe->next;
+		pbe = (pblist + PB_PAGE_SKIP)->next;
 		free_page((unsigned long)pblist);
+		pblist = pbe;
 	}
 }
 


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
