Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWHTEFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWHTEFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 00:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWHTEFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 00:05:06 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:15341 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751646AbWHTEFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 00:05:05 -0400
Message-ID: <44E7E112.3010500@student.ltu.se>
Date: Sun, 20 Aug 2006 06:12:02 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org, drzeus-sdhci@drzeus.cx
Subject: Re: [Patch] Signedness issue in drivers/net/phy/phy_device.c
References: <1156008815.18192.3.camel@alice>
In-Reply-To: <1156008815.18192.3.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn wrote:

>hi,
>  
>
hello

>while checking gcc 4.1 -Wextra warnings, I stumbled across the following
>two warnings:
>
>drivers/net/phy/phy_device.c:528: warning: comparison of unsigned expression < 0 is always false
>drivers/net/phy/phy_device.c:546: warning: comparison of unsigned expression < 0 is always false
>
>Since phy_read() returns an integer and can return negative values, it
>seems to me the best way to get proper error handling working again
>is to make val an int. Currently it is an u32, so the < 0 check
>always fails.
>
>Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>
>--- linux-2.6.18-rc4/drivers/net/phy/phy_device.c.orig	2006-08-19 18:22:56.000000000 +0200
>+++ linux-2.6.18-rc4/drivers/net/phy/phy_device.c	2006-08-19 18:24:49.000000000 +0200
>@@ -513,7 +513,7 @@ EXPORT_SYMBOL(genphy_read_status);
> 
> static int genphy_config_init(struct phy_device *phydev)
> {
>-	u32 val;
>+	int val;
>  
>
Would it not be preferable to use a 's32' instead of an 'int'? After 
all, it seem 'val' needs to be 32 bits.

Just a thought
/Richard
