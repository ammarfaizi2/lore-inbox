Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUATWBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbUATWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:01:14 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:31757 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265825AbUATWBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:01:07 -0500
Date: Tue, 20 Jan 2004 23:03:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040120230322.24cbe005.khali@linux-fr.org>
In-Reply-To: <1074556757661@kroah.com>
References: <10745567571488@kroah.com>
	<1074556757661@kroah.com>
Reply-To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself:

> (...) Greg, could
> you please apply the following patch to the "porting-clients" document
> so that at least the new drivers don't need to be converted
> afterwards?
> 
>  Documentation/i2c/porting-clients |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> 
> diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
> --- a/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
> +++ b/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
> @@ -92,7 +92,10 @@
>    i2c_get_clientdata(client) instead.
>  
>  * [Interface] Init function should not print anything. Make sure
> -  there is a MODULE_LICENSE() line.
> +  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
> +  by module_param(). Note that module_param has a third parameter,
> +  that you should set to 0 by default. See
> include/linux/moduleparam.h+  for details.
>  
>  Coding policy:

On second thought I think I shouldn't have done that change. I2c chip
drivers use SENSORS_INSMOD_* macros which in the end include
MODULE_PARM() calls.

Quoting Rusty Russell: "However, I never implemented mixing old
and new style in the same module, so if you're adding a parameter, it
makes sense to convert them all."

So maybe I shouldn't suggest that new drivers use the new style, since
they will mix old and new in this case. What about forgetting about that
doc change for now? Sorry for the trouble, I should have thought about
that before submitting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
