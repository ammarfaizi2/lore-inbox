Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVFITxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVFITxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVFITxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 15:53:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27068
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262460AbVFITxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 15:53:41 -0400
Date: Thu, 09 Jun 2005 12:53:24 -0700 (PDT)
Message-Id: <20050609.125324.88476545.davem@davemloft.net>
To: pavel@ucw.cz
Cc: vda@ilport.com.ua, abonilla@linuxwireless.org, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050609104205.GD3169@elf.ucw.cz>
References: <200506090909.55889.vda@ilport.com.ua>
	<20050608.231657.59660080.davem@davemloft.net>
	<20050609104205.GD3169@elf.ucw.cz>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 9 Jun 2005 12:42:05 +0200

> I'm not saying it should not work automagically. But it is wrong to
> start transmitting on wireless as soon as kernel boots. It should stay
> quiet in the radio until it is either told to talk or until interface
> is upped.

I agree.

There is a similar problem in the Acenic driver, it brings the
link up and receives broadcast packets as soon as the driver
is loaded.  Mostly this is because the driver inits the chip
and registers the IRQ handler at probe time, whereas nearly
every other driver does this at ->open() time.

