Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966539AbWKTTf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966539AbWKTTf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966537AbWKTTf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:35:27 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:43939 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966535AbWKTTf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:35:26 -0500
Message-ID: <4562036E.3020409@garzik.org>
Date: Mon, 20 Nov 2006 14:35:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Arnd Bergmann <arnd@arndb.de>, Chris Snook <csnook@redhat.com>,
       Jay Cliburn <jacliburn@bellsouth.net>, romieu@fr.zoreil.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
References: <20061119203050.GD29736@osprey.hogchain.net>	<200611200057.45274.arnd@arndb.de>	<45614769.4020005@redhat.com>	<200611201322.00495.arnd@arndb.de> <20061120100202.6a79e382@freekitty>
In-Reply-To: <20061120100202.6a79e382@freekitty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Using common MII code is good, but one problem with the existing MII code is that
> it doesn't work when device is down. This makes it impossible to set speed/duplex
> before device comes up.


That's not true at all.  drivers/net/mii.c uses caller-provided locking 
in all cases, and there is nothing that prevents the common code from 
being called when the interface is down.

You are probably thinking about all the netif_running() checks found in 
the drivers, particularly in the ->begin() hook.

	Jeff


