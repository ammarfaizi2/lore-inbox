Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWIIUNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWIIUNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWIIUNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 16:13:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48851 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964819AbWIIUNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 16:13:36 -0400
Subject: Re: Driver_data is probably zero in serverworks IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marton Balint <cus@fazekas.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.61.0609091840170.30278@cinke.fazekas.hu>
References: <Pine.LNX.4.61.0609091840170.30278@cinke.fazekas.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 21:36:37 +0100
Message-Id: <1157834197.6877.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 19:19 +0200, ysgrifennodd Marton Balint:
> Please take a look at commit f201f5046ddaeeccb036bdf6848549bf5cb51bb1.
> This commit introduced the usage of the PCI_DEVICE macro, but this macro 
> does not set class and class_mask so I think now we set .class instead of 
> .driver_data. The drivers that are also affected by this commit may 
> have similar problems.

Yes it looks to be the case, and PCI_DEVICE_CLASS() macros don't help as
they assign in differing orders.

The following drivers appear to be broken from this

Aec62xx.c			All	
Serverworks.c			OSB4/CSB5/CSB6/CSB6-2/HT1000


Actual breakage will affect CSB6/CSB6-2/HT1000, and all the AEC6xxx
chips in various ways.

Unfortunately it appears I missed the bug, nobody checked the diff and
nobody ever ran -mm with these chipsets so it somehow got through. I'll
look at rolling a patch but it might be Monday. Until then anyone
rolling a 2.6.18 tree should revert the PCI table changes in serverworks
and aec62xx.

Alan


