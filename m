Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUAHAXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUAHAXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:23:07 -0500
Received: from dp.samba.org ([66.70.73.150]:2433 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262598AbUAHAW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:22:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Omkhar Arasaratnam <omkhar@rogers.com>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/advansys.c check_region() fix 
In-reply-to: Your message of "Tue, 30 Dec 2003 08:44:33 CDT."
             <20031230134433.GA22187@omkhar.ibm.com> 
Date: Thu, 08 Jan 2004 10:26:05 +1100
Message-Id: <20040108002255.69A532C46A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031230134433.GA22187@omkhar.ibm.com> you write:
> Another trivial check_region() fix verified by Gene

And almost certainly wrong.

The *point* of request_region() is that you do it before any I/O to
the region.

So you can't release it before calling AscGetChipVersion().

Converting this driver is quite a bit of work, since you have to trace
down every path which uses the region and make sure it's covered.  The
fact that it's formatted like an angry haiku doesn't help.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
