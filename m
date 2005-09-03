Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVICV06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVICV06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 17:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVICV06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 17:26:58 -0400
Received: from relay02.pair.com ([209.68.5.16]:26632 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751133AbVICV05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 17:26:57 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Date: Sat, 3 Sep 2005 16:27:00 -0500
User-Agent: KMail/1.8.1
References: <20050904101218.GM4415@rama.de.gnumonks.org>
In-Reply-To: <20050904101218.GM4415@rama.de.gnumonks.org>
Cc: linux-kernel@vger.kernel.org
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031627.00947.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> Smartcard Reader.

Someone correct me if I'm wrong, but wouldn't these #defines be a problem with 
the new HZ flexibility:

#define	CCID_DRIVER_BULK_DEFAULT_TIMEOUT  	(150*HZ)
#define	CCID_DRIVER_ASYNC_POWERUP_TIMEOUT 	(35*HZ)
#define	CCID_DRIVER_MINIMUM_TIMEOUT 		(3*HZ)
#define READ_WRITE_BUFFER_SIZE 512
#define POLL_LOOP_COUNT				1000

/* how often to poll for fifo status change */
#define POLL_PERIOD 				(HZ/100)

In particular, 2.6.13 allows a HZ of 100, which would define POLL_PERIOD to 0. 
Your later calls to mod_timer would be setting cmx_poll_timer to the current 
value of jiffies. 

Also, you've got a typo in the comments:

* 	- adhere to linux kenrel coding style and policies

Forgive me if I'm way off - I'm just now getting my feet wet in kernel 
development. Just making comments based on what I (think) I know at this 
point.

Best Regards,
Chase Venters
