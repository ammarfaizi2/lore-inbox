Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272441AbRIFKO6>; Thu, 6 Sep 2001 06:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272442AbRIFKOs>; Thu, 6 Sep 2001 06:14:48 -0400
Received: from [195.66.192.167] ([195.66.192.167]:33797 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272441AbRIFKOk>; Thu, 6 Sep 2001 06:14:40 -0400
Date: Thu, 6 Sep 2001 13:12:33 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1114728919.20010906131233@port.imtp.ilyichevsk.odessa.ua>
To: Rick Hohensee <humbubba@smarty.smart.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200109060151.VAA29489@smarty.smart.net>
In-Reply-To: <200109060151.VAA29489@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>#define min2(a,b) ({ \
>>    typeof(a) __a = (a); \
>>    typeof(b) __b = (b); \
>>    if( sizeof(a) != sizeof(b) ) BUG(); \
>>    if( ~(typeof(a))0 > 0 && ~(typeof(b))0 < 0) BUG(); \
>>    if( ~(typeof(a))0 < 0 && ~(typeof(b))0 > 0) BUG(); \
>>    (__a < __b) ? __a : __b; \
>>    })
>>
>>#define min3(type,a,b) ({ \
>>    type __a = (a); \
>>    type __b = (b); \
>>    if( sizeof(a) > sizeof(type) ) BUG(); \
>>    if( sizeof(b) > sizeof(type) ) BUG(); \
>>    (__a < __b) ? __a : __b; \
>>    })

RH> DesJardin's argument is finely crafted, but does this support it? Is min3
RH> intended to be what Linus was talking about?

My min2 requires types to be the same size and sign (after char/short->int
promotion - C always does that, seems we cannot control it - run
my test program and you'll see). If type is changed elsewhere later, min2
will barf - and this is good for preventing hard to track bugs.

Min3 is more permissive but requires programmer to indicate type
explicitly. However, it will bite you when you try convert long to
int, so it will catch some bugs too when someone decide to change
type of the variable.

Can you make better min? Another min addressing different type of bug?
It could be interesting. (We have similar issues with "less than" and
the like ops)

Don't know what Linus originally intended. I thought my two cents
might be useful.

RH> isn't what Linus was saying simply something like...

RH> #define min(type,a,b)           (type) a < (type) b ? (type) a : (type) b;

Looks too dangerous to me. Double evaluation of a and b, no ()
around them...

RH> Looking at the trade-offs should account for the simplicity.

Ifs inside my min2 and min3 optimize out to nothing. Checked that.
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


