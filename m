Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTDNSUs (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbTDNSPT (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:15:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61336 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263650AbTDNSIA (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:08:00 -0400
Date: Mon, 14 Apr 2003 11:21:27 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, Alistair Strachan <alistair@devzero.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm2
Message-ID: <20030414182127.GD4112@kroah.com>
References: <200304132059.11503.alistair@devzero.co.uk> <20030413130543.081c80fd.akpm@digeo.com> <1050266723.767.1.camel@localhost> <20030414004926.GA23762@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414004926.GA23762@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 05:49:26PM -0700, Greg KH wrote:
> 
> I'll work on fixing this up on Monday...

David Miller pointed out the proper fix, and here it is.  Let me know if
this works for everyone or not.

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
