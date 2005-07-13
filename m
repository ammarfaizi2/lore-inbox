Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVGMXBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVGMXBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVGMW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:59:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61636 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262270AbVGMW5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:57:18 -0400
Subject: pci_size() error condition
From: John Rose <johnrose@austin.ibm.com>
To: ink@jurassic.park.msu.ru
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1121295192.23038.15.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 13 Jul 2005 17:53:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone lend an explanation of the following?

	/* base == maxbase can be valid only if the BAR has
	   already been programmed with all 1s.  */
	if (base == maxbase && ((base | size) & mask) != mask) {
		printk("%s: 2 returning 0\n", __FUNCTION__);
		return 0;
	}

Before a recent change, mask was a 64-bit number.  The second part of
the if statement would always resolve to true, since the 32-bit bitop
would never equal the 64-bit mask.  So the second part of the if
statement was ineffectual up until very recently.

After the recent change, this is no longer the case.  Nonzero PCI sizes
are generating bogus resource records for some PPC64 devices.  So for
cases of base == maxbase, why would we ever want to return a nonzero
value?  What is the intended purpose of the second part of that
conditional?

Thanks-
John

