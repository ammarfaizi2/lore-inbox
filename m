Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTDYV7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTDYV7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:59:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8120 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264535AbTDYV7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:59:03 -0400
Date: Fri, 25 Apr 2003 15:13:04 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: it87 driver converted to sysfs
Message-ID: <20030425221304.GA1657@kroah.com>
References: <20030424150113.GJ1069@iucha.net> <20030424160431.GC18690@kroah.com> <20030424165132.GK1069@iucha.net> <20030424172758.GA27365@kroah.com> <20030425215335.GN1069@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425215335.GN1069@iucha.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 04:53:35PM -0500, Florin Iucha wrote:
> On Thu, Apr 24, 2003 at 10:27:58AM -0700, Greg KH wrote:
> > Thanks, I've applied this and will send it on in a bit.
> > 
> > Oops, I've fixed the call to check_region, which should not have been
> > made.  Sorry I missed that last time.
> 
> I have booted 2.5.68-bk6 and upon modprobe it87 I get this:

Let me know if this patch fixes it or not.

thanks,

greg k-h


--- a/drivers/i2c/chips/it87.c	Thu Apr 24 13:35:19 2003
+++ b/drivers/i2c/chips/it87.c	Fri Apr 25 15:06:21 2003
@@ -585,6 +585,7 @@
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client)+sizeof(struct it87_data));
 
 	data = (struct it87_data *) (new_client + 1);
 	if (is_isa)
