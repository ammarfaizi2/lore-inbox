Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030835AbWJDMZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030835AbWJDMZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030833AbWJDMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:25:51 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:62783 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030835AbWJDMZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:25:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=sm3TdKrsw5uTdtD7z2dvdzwgeIhXSjV2JrwZeOYLuiGDA1uhOEtcAx4A1csVQgTykLa4sCwc8aY7bsOTWA3j1O/q6UnKP0RKaPzq8BLUuJpg/p5R9LKGJAk8QxnO7lfePsQAg2R9lgaja9WJbuaE9aqnYyj9OFkbfCg0nANvE5M=
In-Reply-To: <20061004200214.GA6664@localhost.Internal.Linux-SH.ORG>
References: <20061004074535.GA7180@localhost.hsdv.com> <A1AC65D6-07AC-42CB-80F1-9621DBCACF83@gmail.com> <20061004200214.GA6664@localhost.Internal.Linux-SH.ORG>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F3D1520B-B37D-4DF8-9482-DE6D1A708F75@gmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de,
       ysato@users.sourceforge.jp
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Wed, 4 Oct 2006 21:25:43 +0900
To: Paul Mundt <lethal@linux-sh.org>
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 5, 2006, at 5:02 AM, Paul Mundt wrote:

> On Wed, Oct 04, 2006 at 08:30:36PM +0900, girish wrote:
>> question:  where is linux/ide-platform.h header?
>>
> answer: there isn't one, as it's not needed. The reason for using
> platform devices is so we get _away_ from this ridiculous static  
> set of
> definitions for I/O addresses and IRQs that are sprinkled around a lot
> of these drivers.

i wrote wrong file name:

where is linux/platform_device.h file?

as per the patch :


+#include <linux/ide.h>
+#include <linux/platform_device.h>
+
+/*
+ * Users use per-port registration with a simple set of 3 resources
+ * per port:
+ * 		- I/O Base (IORESOURCE_IO)
+ * 		- CTL Base (IORESOURCE_IO)
+ * 		- IRQ	   (IORESOURCE_IRQ)
+ */
+static int __devinit ide_platform_probe(struct platform_device *dev)
+{
+	struct resource *io_res, *ctl_res;
+	hw_regs_t hw;
+
+	if (unlikely(dev->num_resources != 3)) {
+		dev_err(&dev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	io_res = platform_get_resource(dev, IORESOURCE_IO, 0);
+	if (unlikely(io_res == NULL))
+		return -EINVAL;
+
