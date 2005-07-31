Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVGaLOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVGaLOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVGaLOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:14:35 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:25348 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261744AbVGaLND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:13:03 -0400
Message-ID: <42ECB23B.10801@roarinelk.homelinux.net>
Date: Sun, 31 Jul 2005 13:12:59 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>	<42EC9410.8080107@roarinelk.homelinux.net> <20050731021628.42e3ab98.akpm@osdl.org>
In-Reply-To: <20050731021628.42e3ab98.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
>>something broke the sonypi driver a bit after -mm2:
>> I can no longer set bluetooth-power for instance, and it logs these
>> messages:
>>
>> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
>> sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
>> sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)
>>
>> setting/getting brightness, getting battery/ac status still work.
>>
> 
> 
> Can you do a `patch -p1 -R' of the below, see if it fixes it?  It probably
> won't.
> 
> Also please test 2.6.13-rc4-mm1 which is missing the acpi tree...
> 
> Thanks.

Didn't help, and -rc4-mm1 has the same problem.
Also tried with CONFIG_ACPI=n and with cardbus disabled, no change.
Added a few debug lines to the module:

sonypi_call1(82) enter
sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 595)
sonypi_call1() leave
sonypi_call2(81, ff) enter
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 608)
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 610)
sonypi_call2() leave
sonypi_call1(82) enter
sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 595)
sonypi_call1() leave
sonypi: Sony Programmable I/O Controller Driverv1.26.
sonypi: detected type2 model, verbose = 1, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = off, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
sonypi: setbluetoothpower enter
sonypi_call2(96, 00) enter
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 608)
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 610)
sonypi_call2() leave
sonypi_call1(82) enter
sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 595)
sonypi_call1() leave
sonypi: setbluetoothpower leave

brightness for instance does not use the sonypi_callX() functions, and it works.
cat /dev/sonypi produces no more output either, and interrupt count for sonypi does
no longer increase when I press a hotkey or close the lid.

Thanks,

-- 
  Manuel Lauss
