Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVLBBlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVLBBlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVLBBlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:41:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:12509 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932715AbVLBBlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:41:07 -0500
Message-ID: <438FA62D.2040707@pobox.com>
Date: Thu, 01 Dec 2005 20:41:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Final 2.4.x SATA updates
References: <20051201214837.GA25256@havoc.gtf.org> <20051201231008.GA7921@codepoet.org>
In-Reply-To: <20051201231008.GA7921@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Erik Andersen wrote: > On Thu Dec 01, 2005 at
	04:48:37PM -0500, Jeff Garzik wrote: > >>Now that ATAPI support is
	pretty stable, the 2.4 version of libata will >>be receiving its final
	updates soon. Here is the current backport, >>for testing and feedback.
	> > > Awesome. 2.4.x lacks KM_IRQ0 in kmap_types.h > > gcc -D__KERNEL__
	-I/usr/src/linux-2.4.32/include -Wall -Wstrict-prototypes
	-Wno-trigraphs -fno-strict-aliasing -fno-common -fomit-frame-pointer
	-Os -falign-functions=2 -falign-jumps=2 -falign-labels=2
	-falign-loops=2 -pipe -mpreferred-stack-boundary=2 -march=i486 -DMODULE
	-nostdinc -iwithprefix include -DKBUILD_BASENAME=libata_core
	-DEXPORT_SYMTAB -c libata-core.c > libata-core.c: In function
	`ata_sg_clean': > libata-core.c:2427: error: `KM_IRQ0' undeclared
	(first use in this function) > libata-core.c:2427: error: (Each
	undeclared identifier is reported only once > libata-core.c:2427:
	error: for each function it appears in.) > libata-core.c: In function
	`ata_sg_setup': > libata-core.c:2701: error: `KM_IRQ0' undeclared
	(first use in this function) > make[2]: *** [libata-core.o] Error 1
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Thu Dec 01, 2005 at 04:48:37PM -0500, Jeff Garzik wrote:
> 
>>Now that ATAPI support is pretty stable, the 2.4 version of libata will
>>be receiving its final updates soon.  Here is the current backport,
>>for testing and feedback.
> 
> 
> Awesome.  2.4.x lacks KM_IRQ0 in kmap_types.h
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.32/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fomit-frame-pointer -Os -falign-functions=2 -falign-jumps=2 -falign-labels=2 -falign-loops=2 -pipe -mpreferred-stack-boundary=2 -march=i486  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=libata_core  -DEXPORT_SYMTAB -c libata-core.c
> libata-core.c: In function `ata_sg_clean':
> libata-core.c:2427: error: `KM_IRQ0' undeclared (first use in this function)
> libata-core.c:2427: error: (Each undeclared identifier is reported only once
> libata-core.c:2427: error: for each function it appears in.)
> libata-core.c: In function `ata_sg_setup':
> libata-core.c:2701: error: `KM_IRQ0' undeclared (first use in this function)
> make[2]: *** [libata-core.o] Error 1

hmmm, interesting.  Easy enough to fix.  I guess I didn't build on a 
highmem box.

	Jeff



