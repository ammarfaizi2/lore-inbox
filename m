Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUH1PMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUH1PMC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUH1PMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:12:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:730 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266894AbUH1PLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:11:44 -0400
Date: Sat, 28 Aug 2004 17:11:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch][0/3] BUG -> BUG_ON conversions
Message-ID: <20040828151137.GA12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

in the following mails are the first [1] three patches that convert

  if(foo)
	BUG():

to

  BUG_ON(foo);


This makes the code slightly better readable and it might result in 
slightly better code with recent gcc versions due to the "unlikely" in 
the definition of BUG_ON (it might not be a measurable difference, but  
it comes for free).


Obviosly, in constructs like

  if (foo) {
	printk(KERN_ERR "some error");
	BUG();
  }

or

  switch (foo) {
  case A:
	...
	break;
  case B:
	...
	break;
  default:
	BUG();
  }


BUG() can't be replaced by BUG_ON(), and it's therefore unchanged.
  

cu
Adrian

[1] I plan to send more such patches.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

