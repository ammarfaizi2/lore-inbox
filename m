Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTH0OZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTH0OZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:25:32 -0400
Received: from [210.53.66.248] ([210.53.66.248]:40975 "EHLO cnc.intra")
	by vger.kernel.org with ESMTP id S263406AbTH0OZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:25:25 -0400
From: "dl-ipaddr" <dl-ipaddress@china-netcom.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Pentium Pro - sysenter - doublefault
Date: Wed, 27 Aug 2003 22:25:21 +0800
Message-ID: <001a01c36ca7$0c715cc0$fecf53d2@xuxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20030827140121.GA1973@mail.jlokier.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-OriginalArrivalTime: 27 Aug 2003 14:27:35.0764 (UTC) FILETIME=[5C22F940:01C36CA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

did you notice the announcement from www.apache.org and www.debian.org?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jamie Lokier
Sent: Wednesday, August 27, 2003 10:01 PM
To: Jim Houston; linux-kernel@vger.kernel.org; jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault


Richard Curnow wrote:
> OK, since I get something different to the other reports I saw:
> 
>  1:20PM-malvern-0-534-% ./sysenter  1:20PM-malvern-STKFLT-535-% echo 
> $? 144

Hi Richard,

That's because you ran it on a 2.5/2.6 kernel, right?  The test code is
meant for 2.4 kernels and earlier :)

Here is a more universal test:

	int main () {
		asm ("movl %%esp,%%ebp;sysenter" : : "a" (1), "b" (0));
		return 0;
	}

I expect it to do the first of these which is applicable:

	- raise SIGILL on Pentium and earlier Intel CPUs
	- raise SIGILL on non-Intel CPUs which don't have the SEP
capability
	- raise SIGSEGV on Pentium Pro CPUs
	- raise SIGSEGV on Pentium II CPUs with model == 3 and stepping
< 3
	- raise SIGSEGV on 2.4 kernels
	- exit with status 0 on 2.6 kernels

Enjoy,
-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

