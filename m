Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUEGQ5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUEGQ5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUEGQ5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:57:39 -0400
Received: from srvr1.mousebusiness.com ([66.80.37.197]:64783 "HELO
	srvr1.mousebusiness.com") by vger.kernel.org with SMTP
	id S263159AbUEGQ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:57:35 -0400
Message-ID: <20040507165714.13562.qmail@srvr1.mousebusiness.com>
From: Artur Jasowicz <kernel@mousebusiness.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.26 compile errors on PPC
Date: Fri, 07 May 2004 11:57:14 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yellow Dog Linux running on a PowerMac. While recompiling fresh copy of 
2.4.26 downloaded from kernel.org, I ran into two problems: 

1. Compiling file
linux-2.4.26/drivers/char/agp/agpgart_be.c
returned:
agpgart_be.c:96: #error "Please define flush_cache." 

I looked up code near line 96 of agpgart_be.c and compared it against the 
sources of kernel v. 2.4.19. The diference was that in 2.4.26 line 84 was 
missing "|| defined(__powerpc__)". It should read: 

#elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__) || 
defined(__powerpc__) 

instead of 

#elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__) 


2. Compiling file
linux-2.4.26/drivers/scsi/dpt_i2o.c
returned:
dpt_i2o.c:90: parse error before `2'
dpt_i2o.c:90: warning: large integer implicitly truncated to unsigned type 

Again, compared against v. 2.4.19, looks like lines starting at line 87 
should read:
#else
       (-1),(-1),
#endif 

instead of: 

#else
       (-1),(-1)
#endif 

The comma was missing. 
