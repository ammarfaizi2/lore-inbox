Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUJXJys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUJXJys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUJXJyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:54:47 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:17144 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S261407AbUJXJyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:54:44 -0400
Date: Sun, 24 Oct 2004 11:53:45 +0200 (CEST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-2go.math.uni-giessen.de
To: Andi Kleen <ak@muc.de>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <20041023164902.GB52982@muc.de>
Message-Id: <Pine.LNX.4.58.0410241133400.17491@fb07-2go.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
 <20041023164902.GB52982@muc.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Andi Kleen (AK) wrote:

AK> >   dmesg-2.6.9-smp-noNUMA (working one)
AK> 
AK> I bet that if you fill all memory on the non NUMA setup
AK> it will crash too.
AK> 
AK> e.g. run something like this
AK> 
AK> #include <stdlib.h>
AK> #include <string.h>
AK> #include <unistd.h>
AK> #include <stdio.h>
AK> 
AK> #define MEMSIZE 
AK> main()
AK> { 
AK> 	unsigned long len = (sysconf(_SC_AVPHYS_PAGES) - 10)* getpagesize();
AK> 	char *mem = malloc(len);
AK> 	for (;;)  {
AK> 		memset(mem, 0xff, len); 
AK> 		printf(".");
AK> 	}
AK> } 

what's the difference to the program I posted (here a link to an archive:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=109567610824746&w=4

other than yours is filling the memory with 0xFF and mine with 0x00 and 
mine does it only once and yours continuously? 

BTW: I added an fflush(stdout) after the printf and after two lines of
dots on a 150 cols terminal I just stopped the Program. This is with
2.6.9-smp-noNUMA.

on a 2.6.9-smp-NUMA, running my program crashes the kernel immediately.


c ya
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
