Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUBAWbT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbUBAWbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:31:19 -0500
Received: from mta5-svc.business.ntl.com ([62.253.164.45]:54486 "EHLO
	mta5-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S265539AbUBAWbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:31:17 -0500
Message-ID: <401D7E16.5060203@durham.ac.uk>
Date: Sun, 01 Feb 2004 22:30:46 +0000
From: Ben Schofield <b.w.schofield@durham.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Toshiba IDE support: drivers/ide/pci/generic.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been having some problems with the IDE controller on my aged 
Portege 3440CT's port replicator, which I think I've now fixed, and I'd 
appreciate someone else's opinion before I submit a patch.

The problem is that the controller reports itself with a vendor ID of 
1179 (Toshiba) and a device ID of 0105 (unknown). In the 2.4.18 kernel, 
this was fine, since drivers/ide/ide-pci.c recognised it as an unknown 
IDE device and all was well.

Somewhere between 2.4.18 and 2.4.22, the PCI IDE code seems to have been 
re-organised, and ide/generic.c seems not to have all the necessary code 
for unrecognised IDE devices. However, 1179:0103 is listed there as a 
Toshiba Piccolo controller, and adding 1179:0105 with the same data 
makes things work fine.

Toshiba Piccolo support seems to have been removed entirely from 
generic.c in 2.6.2-rc3-bk1. This seems to have affected at least Jérôme 
Augé, who submitted a patch for a similar problem on 08/01 this year, 
containing

#define PCI_DEVICE_ID_TOSHIBA_PICCOLO 0x0102

So, I would guess that it's safe to assume at least 1179:0102, 1179:0103 
and 1179:0105 are Toshiba Piccolo controllers.

Should I submit this as a patch? If I should, which kernel versions 
should I submit it against?

Thanks in advance,

Ben.

