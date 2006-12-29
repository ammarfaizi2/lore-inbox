Return-Path: <linux-kernel-owner+w=401wt.eu-S1753638AbWL2GUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbWL2GUh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbWL2GUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:20:37 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:33252 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbWL2GUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:20:37 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 29 Dec 2006 01:16:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-ID: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  is there some reason there are so many calls of the form

  memset(addr, 0, PAGE_SIZE)

rather than the apparently equivalent invocation of

  clear_page(addr)

the majority of architectures appear to define the clear_page() macro
in their include/<arch>/page.h header file, but not entirely
identically, and in some cases that definition is conditional, as with
i386:

=============================================================
#ifdef CONFIG_X86_USE_3DNOW
...
#define clear_page(page)        mmx_clear_page((void *)(page))
...
#else
...
#define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
...
#endif
============================================================

  should it perhaps be part of the CodingStyle doc to use the
clear_page() macro rather than an explicit call to memset()?  (and
should all architectures be required to define that macro?)

rday
