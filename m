Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVIKCem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVIKCem (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 22:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVIKCem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 22:34:42 -0400
Received: from mail.tor.primus.ca ([216.254.136.21]:15754 "EHLO
	smtp-01.primus.ca") by vger.kernel.org with ESMTP id S932439AbVIKCel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 22:34:41 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: akpm@osdl.org
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Date: Sat, 10 Sep 2005 22:34:28 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509102234.28659.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I noticed your mail about this bug in a discussion on PCI patches for 2.6.13, I emailed the list with some info
about this bug, so here it is again, perhaps this can clear up what the problem is, sorry I don't have a patch,
I don't understand the kernel well enough for that.

drivers/pci/probe.c: In function `pci_read_bases':
drivers/pci/probe.c:166: warning: large integer implicitly truncated to unsigned type
drivers/pci/probe.c:216: warning: large integer implicitly truncated to unsigned type

I've tracked this down to pci_size, and two #define's in include/linux/pci.h

#define  PCI_BASE_ADDRESS_MEM_MASK      (~0x0fUL)
#define PCI_ROM_ADDRESS_MASK    (~0x7ffUL)

pci_size expects 3 u32 arguments,but from what I can tell, on 64 bit arch's the two above 
defines expand to 64bit values, and are truncated when being passed.

I'm not sure how to go about fixing this, if pci_size should accept a u64 or if the defines should
be changed. Is this bug dangerous? What should be done to fix it?

-- 
Gabriel A. Devenyi
ace@staticwave.ca
