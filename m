Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUGBORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUGBORX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUGBORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:17:22 -0400
Received: from smtpout.azz.ru ([81.176.67.34]:10458 "HELO mailserver.azz.ru")
	by vger.kernel.org with SMTP id S264610AbUGBOQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:16:01 -0400
Message-ID: <40E56E96.3050702@vlnb.net>
Date: Fri, 02 Jul 2004 18:17:58 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Dependant modules question
References: <40E556E5.90708@vlnb.net> <Pine.LNX.4.53.0407020952270.3789@chaos>
In-Reply-To: <Pine.LNX.4.53.0407020952270.3789@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Did you execute `depmod -a` after putting your modules into the
> default  directories and their information into /etc/modules.conf ?
 >
> Example:
> /etc/modules.conf
> alias char-major-177  module-a		# First to load
> alias char-major-177  module-b		# Second to load
> alias char-major-177  off		# All done
> 
> 
> # cp module-a.o /lib/modules/`uname -r`/kernel/drivers/char
> # cp module-b.o /lib/modules/`uname -r`/kernel/drivers/char
> # depmod -a
> 
> The first time anybody tries to access a device with the major
> number of 177, its modules will be loaded in the correct order
> by modprobe.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.

Sure, I did. That works fine if A is built in the kernel tree (i.e. the 
sources of A stays there), not when both A and B are external modules.

Actually, the problem is a bit different: compiled B know nothing about 
A and doesn't reffer to it, so depmod and friends can't help. Ever if A 
already loaded, B refused to load (can't find the symbols). I suspect, I 
need to add something in the Makefile of A/B/both. But what?

Thanks,
Vlad

