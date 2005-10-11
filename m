Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVJKTyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVJKTyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbVJKTyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:54:49 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:39229 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750983AbVJKTyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:54:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ovet+7QQsADNhJuHwAWoMr0kurDycpWjR1Z1HPqek3x15/Fg9mLXYdvQzpUdDsm2LNrbDG+FZk7wkGhAjK+ST2NmjoduHSzpJBUTpkgSm9QLiEMA5m8QIM1qHqgsVrGv32WkohJYAMWgOwMwvFtfjkjFdZoaXn8uPfxzaNmXrwE=
Message-ID: <434C1189.4090207@gmail.com>
Date: Tue, 11 Oct 2005 21:24:57 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Georg Lippold <georg.lippold@gmx.de>
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <4345A9F4.7040000@uni-bremen.de>	<434A6220.3000608@gmx.de>	<9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>	<434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de>	<434A8D70.5060300@zytor.com>	<20051010171605.GA7793@georg.homeunix.org>	<434AB1EB.6070309@gmail.com> <434AD0EB.6000405@gmx.de>	<9e0cf0bf0510110132y64c5b42dsb2211d4e75d06f15@mail.gmail.com>	<434BED55.10603@gmx.de> <434BF9ED.9090405@gmail.com> <p73br1vsvup.fsf@verdi.suse.de>
In-Reply-To: <p73br1vsvup.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Alon Bar-Lev <alon.barlev@gmail.com> writes:
> 
>>+config COMMAND_LINE_MAX_SIZE
>>+	int "Maximum kernel command-line size"
>>+	default 512
>>+	help
>>+	  This option allows you to specify maximum kernel command-line
>>+	  for kernel to handle.
> 
> 
> I think making that a config is a really bad idea. What happens
> when the user specifies a very large value. Or a very small one?
> There are subtle dependencies with the boot loader, so this is
> mostly a lie anyways.  And it doesn't really safe enough memory to 
> bother with a CONFIG.

I don't understand this dependency. The cmd_line_ptr is a 
null terminated string which set by the boot loader.
The kernel reads this string until the null or 
COMMAND_LINE_MAX_SIZE.
If the user specified too large buffer or too small buffer 
it won't reflect the boot loader since it sets the maximum 
sizeof the buffer, and the kernel truncates it.

> Also the last time I tried to increase this all kind of systems
> with old bootloaders exploded (e.g. lilo on systems with large EDID
> information - search the archives). Have these issues been resolved now? 
> If yes then I would suggest to just double the default.
> If not it cannot be changed anyways.

I've looked at the sources of lilo and grub, both truncate 
the command line to 256 into the old protocol and set the 
cmd_line_ptr to point to the same place.

This change will no affect current implementation of the 
bootloader, but will allow them to change the code to set 
the cmd_line_ptr to the full command line.

I think that the maximum size should be set to 1024, but 
since the kernel allocates a static buffer, users may wish 
to optimize it. So I think that a configuration option is 
the right place.

Best Regards,
Alon Bar-Lev.
