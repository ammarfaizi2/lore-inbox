Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFTDD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFTDD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 23:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVFTDD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 23:03:59 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:20386 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261409AbVFTDD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 23:03:56 -0400
Date: Sun, 19 Jun 2005 20:03:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Luc Van Oostenryck <lkml@looxix.net>
Cc: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org
Subject: Re: [PATCH] drivers/char/tipar.c: off by one array access
Message-Id: <20050619200351.640e55ac.rdunlap@xenotime.net>
In-Reply-To: <42B58C12.6020503@looxix.net>
References: <42B58C12.6020503@looxix.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2005 17:15:30 +0200 Luc Van Oostenryck wrote:

| In the setupt function, the delay variable is initialized with ints[2],
| but ints is declared as:
| 	int ints[2];
| 
| Since the module parameter should correspond to:
| 	tipar=timeout,delay
| 
| I suppose that the following patch fix the problem.
| 
| 
| Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
| 
| diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
| --- a/drivers/char/tipar.c
| +++ b/drivers/char/tipar.c
| @@ -407,7 +407,7 @@ tipar_setup(char *str)
|                           printk(KERN_WARNING "tipar: bad timeout value (0), "
|   				"using default value instead");
|   		if (ints[0] > 1) {
| -			delay = ints[2];
| +			delay = ints[1];
|   		}
|   	}

That (re)uses the timeout value for delay.
Please try again....

get_options() sets ints[0] to the number of parameters parsed
and tipar_setup() clearly wants to parse as you described:
| 	tipar=timeout,delay
so the ints[] array needs to be [3], not [2].

---
~Randy
