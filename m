Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263196AbVCKFcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbVCKFcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbVCKFcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:32:04 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:63740 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263196AbVCKFb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:31:59 -0500
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for
	2.6.11)
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: peterc@gelato.unsw.edu.au
Content-Type: text/plain
Date: Fri, 11 Mar 2005 00:18:27 -0500
Message-Id: <1110518308.1949.67.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb writes:

> There are three new system calls:
>
>   long   usr_pci_open(int bus, int slot, int function, __u64 dma_mask);
>          Returns a filedescriptor for the PCI device described 
>          by bus,slot,function.  It also enables the device, and sets it 
>          up as a bus-mastering DMA device, with the specified dma mask.

You forgot the PCI domain (a.k.a. hose, phb...) number.
Also, you might encode bus,slot,function according to
the PCI spec. So that gives:

long usr_pci_open(unsigned pcidomain, unsigned devspec, __u64 dmamask);

(with the user library returning an int instead of long)


