Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUI2QxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUI2QxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUI2QxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:53:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13455 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268553AbUI2QxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:53:07 -0400
Message-ID: <415AE866.7090007@pobox.com>
Date: Wed, 29 Sep 2004 12:52:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>, Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: 3c59x 00:00:00:00:00:00 MAC failure
References: <20040929163023.GA17899@devserv.devel.redhat.com> <20040929174530.D16537@flint.arm.linux.org.uk>
In-Reply-To: <20040929174530.D16537@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Sep 29, 2004 at 12:30:23PM -0400, Alan Cox wrote:
> 
>>The 3com EEPROM has a checksum but unfortunately it seems that a zapped
>>EEPROM returning all zero values passes the checksum test fine and we try
>>and use it. 
>>
>>
>>--- drivers/net/3c59x.c~	2004-09-29 17:23:42.964453264 +0100
>>+++ drivers/net/3c59x.c	2004-09-29 17:28:40.358242536 +0100
>>@@ -1295,6 +1295,13 @@
>> 		for (i = 0; i < 6; i++)
>> 			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
>> 	}
>>+	/* Unfortunately an all zero eeprom passes the checksum and this
>>+	   gets found in the wild in failure cases. Crypto is hard 8) */
>>+	if (memcmp(dev->dev_addr, "\0\0\0\0\0", 6) == 0) {
> 
> 
> Shouldn't this be using is_valid_ether_addr() ?

Yes.

	Jeff


