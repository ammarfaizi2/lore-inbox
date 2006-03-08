Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWCHL3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWCHL3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWCHL3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:29:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38605 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932493AbWCHL3m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:29:42 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <440E2EE8.10708@shaw.ca>
References: <5NONi-2hp-3@gated-at.bofh.it> <5NQ2U-462-29@gated-at.bofh.it>
	 <5NRLg-6LJ-31@gated-at.bofh.it> <5NRUR-6Yo-11@gated-at.bofh.it>
	 <5NUSF-30Z-5@gated-at.bofh.it>  <440E2EE8.10708@shaw.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 11:35:13 +0000
Message-Id: <1141817713.7605.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 19:10 -0600, Robert Hancock wrote:
> Alan Cox wrote:
> > You must have a strange kernel Andi. Mine marks them as volatile
> > unsigned char * references.
> 
> Well, that and the fact that IO memory should be mapped as uncacheable 
> in the MTRRs should ensure that readl and writel won't be reordered on 
> i386 and x86_64.. except in the case where CONFIG_UNORDERED_IO is 
> enabled on x86_64 which can reorder writes since it uses nontemporal 
> stores..

You need both

real/writel need the volatile to stop gcc removing/reordering the
accesses at compiler level, and the mtrr/pci bridge stuff then deals
with bus level ordering for that CPU.

