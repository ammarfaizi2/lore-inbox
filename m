Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTFOQmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFOQmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:42:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12231 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262367AbTFOQmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:42:16 -0400
Date: Sun, 15 Jun 2003 09:52:01 -0700 (PDT)
Message-Id: <20030615.095201.102567075.davem@redhat.com>
To: clem@clem.clem-digital.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 -- Lost second 3c509 card
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306151650.MAA05807@clem.clem-digital.net>
References: <1055693991.7678.0.camel@rth.ninka.net>
	<200306151650.MAA05807@clem.clem-digital.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Clements <clem@clem.clem-digital.net>
   Date: Sun, 15 Jun 2003 12:50:25 -0400 (EDT)

   >From boot log:
   
   Kernel command line: auto BOOT_IMAGE=Linux ro root=341 ether=9,0x310,4,0x3c509,eth1

Yes, that explains why the second card isn't found.

The problem is:

1) the we can't assign a name to the device
   until we've registered it with the networking

2) without a name the boot argument lookup doesn't work

3) we have to register the device with the networking only
   after it is initialized

Hmmm...
