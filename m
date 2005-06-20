Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVFUEoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVFUEoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVFTW56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:57:58 -0400
Received: from smtp2.mail.be.easynet.net ([212.100.160.76]:406 "EHLO
	smtp2.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id S261195AbVFTWcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:32:10 -0400
Message-ID: <42B744A4.3080104@looxix.net>
Date: Tue, 21 Jun 2005 00:35:16 +0200
From: Luc Van Oostenryck <lkml@looxix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org
Subject: Re: [PATCH] drivers/char/tipar.c: off by one array access
References: <42B58C12.6020503@looxix.net> <20050619200351.640e55ac.rdunlap@xenotime.net>
In-Reply-To: <20050619200351.640e55ac.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> On Sun, 19 Jun 2005 17:15:30 +0200 Luc Van Oostenryck wrote:
> 
> | In the setupt function, the delay variable is initialized with ints[2],
> | but ints is declared as:
> | 	int ints[2];
> | 
> | Since the module parameter should correspond to:
> | 	tipar=timeout,delay
> | 
> | I suppose that the following patch fix the problem.

...

> 
> That (re)uses the timeout value for delay.
> Please try again....
> 
> get_options() sets ints[0] to the number of parameters parsed
> and tipar_setup() clearly wants to parse as you described:
> | 	tipar=timeout,delay
> so the ints[] array needs to be [3], not [2].
> 
> ---
> ~Randy

Yes, sorry. Here is another patch.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -396,7 +396,7 @@ static struct file_operations tipar_fops
  static int __init
  tipar_setup(char *str)
  {
-	int ints[2];
+	int ints[3];

  	str = get_options(str, ARRAY_SIZE(ints), ints);


