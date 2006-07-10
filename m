Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWGJKHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWGJKHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWGJKHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:07:44 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:15408 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751390AbWGJKHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:07:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=SOcBHWeMI2+d/ROb0Md2CpHFsvX18JuyDmgZ858YqhxXcqYWqNWcnvXcnJmcs41JdEnLZwD5JjCQjGuLBgiwehOZ7PJkGZojDW1PbO5TlZEuZuNTRWR3STLSYGKxZFuTfRBlatLoNB/thFygJVAfQTl1q+AOhqVbDPzvsNFFvho=
Message-ID: <44B226E8.40104@pol.net>
Date: Mon, 10 Jul 2006 18:07:36 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net> <m3irm5hjr0.fsf@defiant.localdomain>
In-Reply-To: <m3irm5hjr0.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@pol.net> writes:
> 
>> Why don't you create a separate function for this, ie cirrusfb_create_i2c()
>> or something. This way, we eliminate the #ifdef/#endif inside the function.
> 
> #ifdef inside a function isn't a problem, while unnecessary complication
> (= worse readability) is.

There are better reasons (ie, smaller patch), but worse readability is not
one of them.

I could more easily grasp the code flow of cirrusfb_register() if you
just inserted "cirrusfb_create_i2c_buses()" instead of:

+		cinfo->bit_cirrus_data.setsda = alpine_setsda;
+		cinfo->bit_cirrus_data.setscl = alpine_setscl;
+		cinfo->bit_cirrus_data.getsda = alpine_getsda;
+		cinfo->bit_cirrus_data.getscl = alpine_getscl;
+		cinfo->bit_cirrus_data.udelay = 5;
+		cinfo->bit_cirrus_data.mdelay = 1;
+		cinfo->bit_cirrus_data.timeout = HZ;
+		cinfo->bit_cirrus_data.data = cinfo;
+		cinfo->cirrus_ops.owner = THIS_MODULE;
+		cinfo->cirrus_ops.id = I2C_HW_B_CIRRUS;
+		cinfo->cirrus_ops.class = I2C_CLASS_DDC;
+		cinfo->cirrus_ops.algo_data = &cinfo->bit_cirrus_data;
+		cinfo->cirrus_ops.dev.parent = info->device;
+		strlcpy(cinfo->cirrus_ops.name, "Cirrus Logic DDC I2C adapter",
+			I2C_NAME_SIZE);
+		if (!(err = i2c_bit_add_bus(&cinfo->cirrus_ops))) {
+			printk(KERN_DEBUG "Initialized Cirrus Logic I2C"
+			       " adapter\n");
 			cinfo->i2c_used = 1;
 		} else
-			printk(KERN_WARNING "Unable to initialize Alpine I2C"
-			       "adapter (result = %i)\n", err);
+			printk(KERN_WARNING "Unable to initialize Cirrus"
+			       " Logic I2C adapter (result = %i)\n", err);

Tony
