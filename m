Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272818AbTHEOlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272821AbTHEOlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:41:14 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:31392 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S272818AbTHEOlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:41:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.4 vs 2.6 versions of include/linux/ioport.h
Date: Tue, 5 Aug 2003 10:41:08 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051041.08078.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.9.38] at Tue, 5 Aug 2003 09:41:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

In the 2.4 includes, find this in ioport.h
----
/* Compatibility cruft */
#define check_region(start,n)   __check_region(&ioport_resource, 
(start), (n))
[snip]
extern int __check_region(struct resource *, unsigned long, unsigned 
long);
----
But in the 2.6 version, find this:
----
/* Compatibility cruft */
[snip]
extern int __check_region(struct resource *, unsigned long, unsigned 
long);
[snip]
static inline int __deprecated check_region(unsigned long s, unsigned 
long n)
{
        return __check_region(&ioport_resource, s, n);
}
----
First, the define itself is missing in the 2.6 version.

Many drivers seem to use this call, and in that which I'm trying to 
build, the nforce and advansys modules use it.  And while the modules 
seem to build, they do not run properly.

I cannot run 2.6.x for extended tests because of the advansys breakage 
this causes.  I also haven't even tried to run X because of the 
nforce error reported when its built, the same error as attacks the 
advansys code.

Can I ask why this change was made, and is there a suitable 
replacement call available that these drivers could use instead of 
check_region(), as shown here in a snip from advansys.c?
----
if (check_region(iop, ASC_IOADR_GAP) != 0) {
...
if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
...

Hopeing for some hints here.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

