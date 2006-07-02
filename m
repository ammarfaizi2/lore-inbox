Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWGBDEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWGBDEf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 23:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWGBDEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 23:04:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9098 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751474AbWGBDEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 23:04:34 -0400
Message-ID: <44A73790.5030006@zytor.com>
Date: Sat, 01 Jul 2006 20:03:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Miles Lane <miles.lane@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com> <20060701230635.GA19114@mars.ravnborg.org> <44A706C4.7070908@zytor.com> <20060702030121.GA7247@mars.ravnborg.org>
In-Reply-To: <20060702030121.GA7247@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>   
>> -KLIBCREQFLAGS     :=
>> +KLIBCREQFLAGS     := $(call cc_option, -fno-stack-protector, )
> 
> This needs to be $(call cc-option, ...)
> '-' not '_'.
> 

*plonk* OK... I feel dumb now :)

Miles: could you try this out?

>> +++ b/usr/klibc/arch/arm/MCONFIG
>> @@ -12,7 +12,7 @@ CPU_TUNE := strongarm
>>  
>>  KLIBCOPTFLAGS = -Os -march=$(CPU_ARCH) -mtune=$(CPU_TUNE)
>>  KLIBCBITSIZE  = 32
>> -KLIBCREQFLAGS = -fno-exceptions
>> +KLIBCREQFLAGS += -fno-exceptions
> 
> This should be fixed for KLIBCOPTFLAGS also. Unrelated to this issue.
> 

*Nod.*

	-hpa
