Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131527AbRC0UQA>; Tue, 27 Mar 2001 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRC0UPl>; Tue, 27 Mar 2001 15:15:41 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:778 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131527AbRC0UPe>; Tue, 27 Mar 2001 15:15:34 -0500
Message-ID: <3AC0F4D5.9E45E60C@t-online.de>
Date: Tue, 27 Mar 2001 22:15:17 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linas@linas.org
CC: linux-kernel@vger.kernel.org
Subject: Re: mouse problems in 2.4.2 -> lost byte
In-Reply-To: <20010325223358.71E5F1B7A4@backlot.linas.org>
Content-Type: multipart/mixed;
 boundary="------------AC164EE9E028337CC37F4575"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AC164EE9E028337CC37F4575
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

linas@linas.org wrote:

> 
> I am experiencing debilitating intermittent mouse problems & was about
...
> Symptoms:
> After a long time of flawless operation (ranging from nearly a week to
> as little as five minutes), the X11 pointer flies up to top-right corner,
                                                          ^^^^^^^^^^^^^^^^
> and mostly wants to stay there.  Moving the mouse causes a cascade of
> spurious button-press events get generated.

This is easily explained: some byte of the mouse protocol was lost.
(Some mouse protocols are even designed to allow
 easy resync/recovery by fixed bit patterns!)

Write an intelligent mouse driver for XFree86 to compensate for
lost bytes. 

Regards, Gunther

APPENDIX
========

Output ot litte test program:
> a.out
Simulating 1 lost byte
    1 -- ff 00 08 ---   -256 : -248   Buttons=MRL Overflow/errors:XY 
    2 -- 00 04 08 ---      4 :    8   Buttons=    Overflow/errors:  T
    3 -- 00 04 08 ---      4 :    8   Buttons=    Overflow/errors:  T
    4 -- 00 03 08 ---      3 :    8   Buttons=    Overflow/errors:  T
    5 -- 00 03 18 ---      3 :   24   Buttons=    Overflow/errors:  T
    6 -- ff 02 08 ---   -254 : -248   Buttons=MRL Overflow/errors:XY 
    7 -- 00 02 08 ---      2 :    8   Buttons=    Overflow/errors:  T
    8 -- 00 03 18 ---      3 :   24   Buttons=    Overflow/errors:  T
    9 -- ff 03 18 ---   -253 : -232   Buttons=MRL Overflow/errors:XY 
   10 -- ff 03 08 ---   -253 : -248   Buttons=MRL Overflow/errors:XY 
...

Probably XFree ignores data packets with XY overflow set. All other
packets move you to top-right corner.

Moving your mouse will quickly show button mania, as described by your post.
--------------AC164EE9E028337CC37F4575
Content-Type: application/octet-stream;
 name="gm_psauxprint.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gm_psauxprint.c"

Ly8gc2hvdyBlZmZlY3RzIG9mIGxvc3QgYnl0ZXMgb24gcHMvMiBtb3VzZSBwcm90b2NvbCAK
I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxlcnJuby5oPgppbnQgbWFpbih2b2lkKQp7
IAoJRklMRSAqZjsKCWludCBpPTAseCxhLHksIHhvLHlvLHhzLHlzLHIsbSxsLHQsZHgsZHk7
CgoJZj1mb3BlbigiL2Rldi9wc2F1eCIsInIiKTsKCWlmKGY9PU5VTEwpIHN0cmVycm9yKGVy
cm5vKTsKCiAvL3ByaW50ZigiU2ltdWxhdGluZyAyIGxvc3QgYnl0ZXNcbiIpOwogLy9hPWZn
ZXRjKGYpOyBhPWZnZXRjKGYpOwoKIHByaW50ZigiU2ltdWxhdGluZyAxIGxvc3QgYnl0ZVxu
Iik7CiBhPWZnZXRjKGYpOwoJd2hpbGUgKDEpIHsKCQlhPWZnZXRjKGYpOwoJCXg9ZmdldGMo
Zik7CgkJeT1mZ2V0YyhmKTsKCQlpKys7CgkJcHJpbnRmKCIlNWQgLS0gJTAyeCAlMDJ4ICUw
MngiLGksYSx4LHkpOwoKCQl5bz1hJjB4ODA7CgkJeG89YSYweDQwOwoJCXlzPWEmMHgyMDsK
CQl4cz1hJjB4MTA7CgkJdD1hJjB4MDg7CgkJbT1hJjB4MDQ7CgkJcj1hJjB4MDI7CgkJbD1h
JjB4MDE7CgoJCWR4PXg7CgkJZHk9eTsKCQlpZih4cykgZHg9eC0yNTY7CgkJaWYoeXMpIGR5
PXktMjU2OwoJCXByaW50ZigiIC0tLSAgICU0ZCA6ICU0ZCAgIEJ1dHRvbnM9JXMlcyVzIE92
ZXJmbG93L2Vycm9yczolcyVzJXNcbiIsCgkJCWR4LGR5LG0/Ik0iOiIgIiwgcj8iUiI6IiAi
LCBsPyJMIjoiICIsCgkJCXhvPyJYIjoiICIsIHlvPyJZIjoiICIsIHQ/IiAiOiJUIik7Cgl9
CglyZXR1cm4gMDsKfQkK
--------------AC164EE9E028337CC37F4575--

