Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVDFNVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVDFNVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVDFNVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:21:35 -0400
Received: from alog0690.analogic.com ([208.224.223.227]:57311 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262204AbVDFNUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:20:15 -0400
Date: Wed, 6 Apr 2005 09:18:16 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dave Korn <dave.korn@artimi.com>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <hubicka@ucw.cz>, Gerold Jury <gerold.ml@inode.at>,
       jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
Subject: RE: [BUG mm] "fixed" i386 memcpy inlining buggy
In-Reply-To: <SERRANOEKRuYDlrjbud0000007e@SERRANO.CAM.ARTIMI.COM>
Message-ID: <Pine.LNX.4.61.0504060912420.22100@chaos.analogic.com>
References: <SERRANOEKRuYDlrjbud0000007e@SERRANO.CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1382007614-1112793496=:22100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1382007614-1112793496=:22100
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


Attached is inline ix86 memcpy() plus test code that tests its
corner-cases. The in-line code makes no jumps, but uses longword
copies, word copies and any spare byte copy. It works at all
offsets, doesn't require alignment but would work fastest if
both source and destination were longword aligned.

On Wed, 6 Apr 2005, Dave Korn wrote:

> ----Original Message----
>> From: Dave Korn
>> Sent: 06 April 2005 12:13
>
>> ----Original Message----
>>> From: Dave Korn
>>> Sent: 06 April 2005 12:06
>>
>>
>>   Me and my big mouth.
>>
>>   OK, that one does work.
>>
>>   Sorry for the outburst.
>>
>
>
> .... well, actually, maybe it doesn't after all.
>
>
>  What's that uninitialised variable ecx doing there eh?
>
>
>    cheers,
>      DaveK
> -- 
> Can't think of a witty .sigline today....
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1382007614-1112793496=:22100
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="memcpy.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0504060918160.22100@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="memcpy.c"

DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCg0K
DQovLw0KLy8gIElubGluZSBpeDg2IG1lbWNweSgpIHRoYXQgY29udGFpbnMg
bm8ganVtcHMuIE5vdCBjb3BpZWQgZnJvbQ0KLy8gIGFueWJvZHkuCUNvbnRy
aWJ1dGVkIGJ5IHJqb2huc29uQGFuYWxvZ2ljLmNvbQ0KLy8NCg0Kc3RhdGlj
IF9faW5saW5lX18gdm9pZCAqbWVtY3B5KHZvaWQgKmRzdCwgdm9pZCAqc3Jj
LCBzaXplX3QgbGVuKSB7DQogICAgICAgIHZvaWQgKnJldCA9IGRzdDsNCiAg
ICAgICAgX19hc21fXyBfX3ZvbGF0aWxlX18oCVwNCgkiY2xkXG4iCQkJXA0K
CSJzaHIgJDEsICUlZWN4XG4iCVwNCgkicHVzaGZcbiIJCVwNCgkic2hyICQx
LCAlJWVjeFxuIglcDQoJInB1c2hmXG4iCQlcDQoJInJlcFxuIgkJCVwNCgki
bW92c2xcbiIJCVwNCgkicG9wZlxuIgkJXA0KCSJhZGNsICUlZWN4LCAlJWVj
eFxuIglcDQoJInJlcFxuIgkJCVwNCgkibW92c3dcbiIJCVwNCgkicG9wZlxu
IgkJXA0KCSJhZGNsICUlZWN4LCAlJWVjeFxuIglcDQoJInJlcFxuIgkJCVwN
CgkibW92c2JcbiIJCVwNCgk6ICI9RCIgKGRzdCksICI9UyIgKHNyYyksICI9
YyIobGVuKQ0KCTogIjAiICAoZHN0KSwgIjEiICAoc3JjKSwgIjIiIChsZW4p
DQoJOiAibWVtb3J5IiApOw0KICAgIHJldHVybiByZXQ7DQp9DQoNCg0KY29u
c3QgY2hhciB0ZXN0ZXJbXT0JIjAxMjM0NTY3ODkiDQoJCQkiMDEyMzQ1Njc4
OSINCgkJCSIwMTIzNDU2Nzg5Ig0KCQkJIjAxMjM0NTY3ODkiDQoJCQkiMDEy
MzQ1Njc4OSINCgkJCSIwMTIzNDU2Nzg5Ig0KCQkJIjAxMjM0NTY3ODkiDQoJ
CQkiMDEyMzQ1Njc4OSI7DQpjaGFyIGFsbG9jYXRlZFsweDEwMDBdOw0KDQpp
bnQgbWFpbigpDQp7DQogICAgc2l6ZV90IGk7DQogICAgY2hhciBidWZbMHgx
MDAwXTsNCg0KICAgIG1lbXNldChidWYsIDB4MDAsIHNpemVvZihidWYpKTsN
CiAgICBmb3IoaT0wOyBpPCBzaXplb2YoYnVmKTsgaSsrKQ0KICAgICAgICBw
dXRzKG1lbWNweShidWYsIChjaGFyICopdGVzdGVyLCBpKSk7DQogICAgbWVt
c2V0KGJ1ZiwgMHgwMCwgc2l6ZW9mKGJ1ZikpOw0KICAgIGZvcihpPTA7IGk8
IHNpemVvZihidWYpLTE7IGkrKykNCiAgICAgICAgcHV0cyhtZW1jcHkoJmJ1
ZlsxXSwgKGNoYXIgKil0ZXN0ZXIsIGkpKTsNCiAgICBtZW1zZXQoYnVmLCAw
eDAwLCBzaXplb2YoYnVmKSk7DQogICAgZm9yKGk9MDsgaTwgc2l6ZW9mKGJ1
ZiktMjsgaSsrKQ0KICAgICAgICBwdXRzKG1lbWNweSgmYnVmWzJdLCAoY2hh
ciAqKXRlc3RlciwgaSkpOw0KICAgIG1lbXNldChidWYsIDB4MDAsIHNpemVv
ZihidWYpKTsNCiAgICBmb3IoaT0wOyBpPCBzaXplb2YoYnVmKS0zOyBpKysp
DQogICAgICAgIHB1dHMobWVtY3B5KCZidWZbM10sIChjaGFyICopdGVzdGVy
LCBpKSk7DQogICAgcmV0dXJuIDA7DQp9DQo=

--1879706418-1382007614-1112793496=:22100--
