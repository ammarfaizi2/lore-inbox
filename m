Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSJ0OHu>; Sun, 27 Oct 2002 09:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262404AbSJ0OHu>; Sun, 27 Oct 2002 09:07:50 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:53743 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262402AbSJ0OHt>; Sun, 27 Oct 2002 09:07:49 -0500
Message-ID: <3DBBF4EB.7030406@snapgear.com>
Date: Mon, 28 Oct 2002 00:15:07 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.44uc1 (MMU-less support)
References: <3DBAC09A.4090104@snapgear.com> <20021026201856.GA1670@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Sam Ravnborg wrote:
> On Sun, Oct 27, 2002 at 02:19:38AM +1000, Greg Ungerer wrote:
> 
>>   - arch Makefiles rewritten
> 
> Took a look at them.
> See comments below.

Thanks.
Rolled on these in to the next patch set.

Had to make one small adjustment:

> +
> +arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
> +				   include/config/MARKER
> +
> +include/asm-$(ARCH)/asm-offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
> +	@$(generate-asm-offsets.h) < $< > $@
> +
> +include/asm-$(ARCH)/asm-offsets.h: include/asm-$(ARCH)/asm-offsets.h.tmp
> +	@echo -n '  Generating $@'
> +	@$(update-if-changed)
> Combine it like this instead:
> include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
> 				   include/asm include/linux/version.h \
> 				   include/config/MARKER
> 	@echo -n '  Generating $@'
> 	@$(generate-asm-offsets.h) < $< > $@
                                           ^^^

This needs to be $@.tmp, "update-if-changed" specifically looks
for the .tmp named file.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

