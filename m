Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUAETaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUAETaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:30:01 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:29592 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S265163AbUAET37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:29:59 -0500
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Mon, 5 Jan 2004 13:29:54 -0600 (CST)
Message-Id: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu>
To: davem@redhat.com, gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
Cc: berkley@cs.wustl.edu, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The pci layer is modifying the sg list, and then placing a zero
in the length field. pci-gart.c at line 453 (2.6.0 sources) checks this length field
after a retry, sees that it is zero, and bughalts.
	As Justin points out, SOMEBODY needs to reset the sg list, or kick the error
back up far enough to recreate it completely. Or just don't bother to
combine the entries. A machine with 8GB or more can stand to lose a few bytes.
How many hardware devices can handle a 1MB+ I/O buffer being passed to them anyway?

berkley
