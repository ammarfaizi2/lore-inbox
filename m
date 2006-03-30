Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWC3BjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWC3BjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWC3BjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:39:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:2234 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751422AbWC3BjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:39:01 -0500
Subject: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1143623605.5046.11.camel@openx2.frec.bull.fr>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 29 Mar 2006 17:38:50 -0800
Message-Id: <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are places in ext3 code to use "int" to represent block numbers in
kernel(not on-disk). This seems the "only" reason that why we can only
have 8TB ext3 rather than 16TB.  Most times it just a bug with no
particular reason why not use unsigned 32 bit value, so the fix is easy.

However, it is not so straightforward fix for the ext3 block allocation
code, as ext3_new_block() returns a block number, and "-1" to indicating
block allocation failure. Ext3 block reservation code, called by
ext3_new_block(), thus also use "int" for block numbers in some places.

The following patches fixed both the ext3 block allocation code, as well
as the simple ones.

This work is inspired by Takashi's extend ext2/3 file/filesystem
limitation work, but rather, it focus on ext3 filesystem limit only, and
fixed the block allocation/reservation code to support in-kernel 2**32
block number. Also thanks to Laurent for his review.

Have verified these two patches on a 64 bit machine with 10TB ext3
filesystem, fsx runs fine for a few hours. Also testes on 32 bit machine
with <8TB ext3.

Please review this patches and I appreciate comments.

The things need to be done to complete this work is the issue with
current percpu counter, which could not handle u32 type count well. 



