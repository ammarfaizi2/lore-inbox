Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbTE1Uqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTE1Uqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:46:47 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:62930 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264866AbTE1Uqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:46:46 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Andrew Morton" <akpm@digeo.com>, "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.70: CODA breaks boot
Date: Wed, 28 May 2003 22:00:06 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEPLEBAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030528043600.650a2f82.akpm@digeo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

 >> ...it oopses in kmem_cache_create, called from release_console_sem and
 >>  coda_init_inodecache.

 > You'll be needing this one.
 > 
 >  fs/coda/inode.c |    6 +++---
 >  1 files changed, 3 insertions(+), 3 deletions(-)
 > 
 > diff -puN fs/coda/inode.c~coda-typo-fix fs/coda/inode.c
 > --- 25/fs/coda/inode.c~coda-typo-fix	2003-05-27 22:27:11.000000000 -0700
 > +++ 25-akpm/fs/coda/inode.c	2003-05-27 22:27:27.000000000 -0700
 > @@ -69,9 +69,9 @@ static void init_once(void * foo, kmem_c
 >  int coda_init_inodecache(void)
 >  {
 >  	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
 > -					     sizeof(struct coda_inode_info),
 > +				sizeof(struct coda_inode_info),
 > -					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
 > +				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
 > -					     init_once, NULL);
 > +				init_once, NULL);
 >  	if (coda_inode_cachep == NULL)
 >  		return -ENOMEM;
 >  	return 0;

That patch has me puzzled. Other than changing the white space, what actual
change to the code does it make? I can't see any.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.484 / Virus Database: 282 - Release Date: 27-May-2003

