Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTDNSS2 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbTDNSSZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:18:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54692 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263650AbTDNSRU (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:17:20 -0400
Date: Mon, 14 Apr 2003 11:31:29 -0700
From: Greg KH <greg@kroah.com>
To: Florin Iucha <florin@iucha.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in bus_add_driver with 2.5.67-bk4
Message-ID: <20030414183129.GB4306@kroah.com>
References: <20030412215544.GA1663@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030412215544.GA1663@iucha.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 04:55:44PM -0500, Florin Iucha wrote:
> 2.5.67-bk4 oopses at boot with:

Try the following patch from David Miller.

thanks,

greg k-h


# Input: change input_init() to be a subsys initcall
#
# This fixes oopses when it and the hid core are compiled into the kernel.

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Mon Apr 14 11:16:02 2003
+++ b/drivers/input/input.c	Mon Apr 14 11:16:02 2003
@@ -717,5 +717,5 @@
 	devclass_unregister(&input_devclass);
 }
 
-module_init(input_init);
+subsys_initcall(input_init);
 module_exit(input_exit);
