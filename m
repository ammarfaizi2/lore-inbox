Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTH3LV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 07:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTH3LVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 07:21:25 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:30177 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id S263496AbTH3LVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 07:21:24 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Date: Sat, 30 Aug 2003 11:49:19 +0100
User-Agent: KMail/1.5.3
References: <200308281548.44803.tomasz_czaus@go2.pl> <200308282002.00758.gothick@gothick.org.uk> <20030828151708.0b13dd82.rddunlap@osdl.org>
In-Reply-To: <20030828151708.0b13dd82.rddunlap@osdl.org>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308301149.19944.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 Aug 2003 23:17, Randy.Dunlap wrote:
> Yes, the kernel has decided that your processor only has 1 Bank of
> MCE register data to report.  I don't know how/why.  Sorry.

Could it be something to do with this (in arch/i386/kernel/cpu/mcheck/k7.c)?

	if (l & (1<<8))	/* Control register present ? */
		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
	nr_mce_banks = l & 0xff;

	for (i=1; i<nr_mce_banks; i++) {

Check out the "for".  Or am I reading this wrong?

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
