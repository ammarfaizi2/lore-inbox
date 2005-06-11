Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVFKSAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVFKSAN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVFKSAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:00:13 -0400
Received: from smtpout.mac.com ([17.250.248.83]:30935 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261764AbVFKR77 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:59:59 -0400
In-Reply-To: <20050610091515.GH4173@elf.ucw.cz>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com> <20050610091515.GH4173@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <151D7A8F-26C2-41D3-9FC5-BC9A45F5AA85@mac.com>
Cc: Tony Lindgren <tony@atomide.com>, Christian Hesse <mail@earthworm.de>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Date: Sat, 11 Jun 2005 13:59:42 -0400
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2005, at 05:15:15, Pavel Machek wrote:
> Hi!
>>> do {} while (0)
>>>
>>> , else you are preparing trap for someone.
>>>
>>
>> Can you please explain what the difference between these two are?
>> Some compiler version specific thing?
>>
>
> It took me quite some remembering. Problem is that with your macros,
> someone can write
>
>     dyn_tick_reprogram_timer()
>     printk();
>
> [notice missing ; at first line], and still get it compile. If you
> replace {} with do {} while (0), he'll get compile error as he should.

Actually, the real reason is for something like this:

#define myfunc1() {}
#define myfunc2() {}

if (a && b) myfunc1();
else        myfunc2();

This would be translated as:

if (a && b) {};
else        {};

Which would generate a syntax error:
zeus:~ kyle$ gcc -c `y -e .c` -o tmp.o <<'EOF'
 > #define myfunc1() {}
 > #define myfunc2() {}
 > void x() {
 >     int a = 0, b = 1;
 >     if (a && b) myfunc1();
 >     else        myfunc2();
 > }
 > EOF
/tmp/y.c8F08d.c: In function ‘x’:
/tmp/y.c8F08d.c:4: error: parse error before "else"

Cheers,
Kyle Moffett



