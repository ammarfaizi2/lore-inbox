Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFJTiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFJTiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFJTiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:38:18 -0400
Received: from shamrock.dyndns.org ([213.146.117.139]:10003 "EHLO
	shamrock.taprogge.wh") by vger.kernel.org with ESMTP
	id S261186AbVFJTiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:38:10 -0400
Date: Fri, 10 Jun 2005 21:38:02 +0200
From: Jens Taprogge <jens.taprogge@post.rwth-aachen.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: TPM on Thinkpad T43
Message-ID: <20050610193802.GA27033@ranger.taprogge.wh>
Mail-Followup-To: Jens Taprogge <jens.taprogge@post.rwth-aachen.de>,
	Kylene Jo Hall <kjhall@us.ibm.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kylie,

I have followed your discussion on LKML titled "TPM on IBM thinkcenter
S51".  I seem to have a very similar problem with the TPM in a T43
laptop.

I added the additional PCI IDs but that is not enough to make the driver
detect the chip.  Additionally the value of NSC_SID_INDEX is 0xFF
instead of 0xFE. 

Changing that in the driver gives the following debug output:
	tpm_nsc 0000:00:1f.0: NSC TPM detected
	tpm_nsc 0000:00:1f.0: NSC LDN 0xff, SID 0xff, SRID 0xff
	tpm_nsc 0000:00:1f.0: NSC SIOCF1 0xff SIOCF5 0xff SIOCF6 0xff SIOCF8 0xff
	tpm_nsc 0000:00:1f.0: NSC IO Base0 0xffff
	tpm_nsc 0000:00:1f.0: NSC IO Base1 0xffff
	tpm_nsc 0000:00:1f.0: NSC Interrupt number and wakeup 0xff
	tpm_nsc 0000:00:1f.0: NSC IRQ type select 0xff
	tpm_nsc 0000:00:1f.0: NSC DMA channel select0 0xff, select1 0xff
	tpm_nsc 0000:00:1f.0: NSC Config 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff
	tpm_nsc 0000:00:1f.0: NSC PC21100 TPM revision 31

Trying to read from /sys/class/misc/tpm0/device/pcrs results in:
	tpm_nsc 0000:00:1f.0: IBF timeout
	tpm_nsc 0000:00:1f.0: tpm_transmit: tpm_send: error 4294967291

I am guessing that this is indeed not a NSC chip. 

I also tried using the Atmel driver by adding the same PCI IDs. But
again the reading of registers 4..7 indicated it is not.

Do you have an idea on how to get the device working?

Best Regards
Jens

PS: I am not subscribed to LKML, so please send copies of replies to me.
