Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbUKHRPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUKHRPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUKHRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:15:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:54424 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261863AbUKHQ6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:58:30 -0500
Message-ID: <418FA2F1.2090003@osdl.org>
Date: Mon, 08 Nov 2004 08:46:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: isa memory address
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>
In-Reply-To: <1099901664.2718.92.camel@delphi.roma1.infn.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino Sergi wrote:
> Hi,
> 
> I'm working with an old data acquisition system that uses an 8-bit card
> in an ISA slot (address 0xd0000), by a simple driver I ported from
> kernel 1.1.x to 2.2.24.
> 
> It works fine, but I'd like to have features by newer kernels (2.4 or
> even 2.6), like new filesystems support.
> 
> On kernels >=2.4.0 check_region returns -EBUSY for that address,
> but it is not actually used; I tried to understand if something has been
> changed/removed, because of obsolescence of devices, in IO management,
> but I couldn't.
> 
> Does anybody have any explanation/suggestion?

Please post contents of /proc/iomem .
I'm guessing that it will show something like:
000e0000-000effff : Extension ROM
(but for address 000d0000).
So then the question becomes how to assign/allocate it for your
driver.

You might have to dummy up a call to release_resource() first,
then use request_resource() to acquire it.
Or just use the addresses anyway.... even though check_region() says
-EBUSY.  BTW, check_region() is deprecated in 2.6.x, so if your
driver could just use request_region() and release_region(), that
would be better.

> Thank you
> 
> Best Regards,
> 
> Antonino Sergi
> 
> PS:As I'm not subscribed, please CC me your answers.


-- 
~Randy
