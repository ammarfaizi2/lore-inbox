Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbVLGWeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbVLGWeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbVLGWeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:34:24 -0500
Received: from serv01.siteground.net ([70.85.91.68]:64922 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751804AbVLGWeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:34:23 -0500
Date: Wed, 7 Dec 2005 14:34:14 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Subject: pcibus_to_node value when no pxm info is present for the pci bus
Message-ID: <20051207223414.GA4493@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the arches seem to return -1 for pcibus_to_node if there is no pxm
kind of proximity information for the pci busses.  Arch specific code on
those arches check if nodeid >= 0  before using the nodeid for kmalloc_node
etc. But some code paths in x86_64/i386 does not doe this --
x86_64/dma_alloc_pages() and e1000 node local descriptor (I am to blame for 
the second one).  Also, pcibus_to_node seems to be 0 when there is no pxm 
info available.

The question is, what should be the default pcibus_to_node if there is no
pxm info? Answer seems like -1 -- in which case dma_alloc_pages and e1000
driver has to be fixed.

Thanks,
Kiran
