Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWJGMWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWJGMWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 08:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWJGMWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 08:22:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:684 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751031AbWJGMWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 08:22:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m0FPEsZX82M+HiE5hmO1mHLQhVy2WQwG9PRRmovnfwuFbF5dk0FCdq02BCdW2i0zqtMnCQs2+a0ZOerIeDz7S3s5V7BhgmX3feB8acWG9rjz+blctkkrggGGpI3qifmiPsIpZoHvlWaDFCvFOA03Cue8MjBEEuv7YFBY1sVAqlM=
Message-ID: <45279C24.1080004@gmail.com>
Date: Sat, 07 Oct 2006 14:22:37 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, support@moxa.com.tw,
       "Michael H. Warfield" <mhw@wittsend.com>
Subject: Re: [PATCH] Char: remove unneded termbits redefinitions
References: <1236876321987@karneval.cz> <20061006181641.e437548e.akpm@osdl.org>
In-Reply-To: <20061006181641.e437548e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed,  4 Oct 2006 18:49:01 +0200 (CEST)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Char, remove unneded termbits redefinitions
>>
>> No need to redefine termbits in char tree.
> 
> drivers/char/ip2/ip2main.c:2498: error: 'B153600' undeclared (first use in this function)
> drivers/char/ip2/ip2main.c:2498: error: (Each undeclared identifier is reported only once
> drivers/char/ip2/ip2main.c:2498: error: for each function it appears in.)
> drivers/char/ip2/ip2main.c:2500: error: 'B307200' undeclared (first use in this function)
> 
> Unless you're a sparc user, methinks you didn't compile this one.
> 
> I suppose an appropriate fix would be to move the B153600 and B307200
> definitions into include/asm-*/termbits.h (those which don't already have it).
> But that's just a guess.

Hum, I thought I had at least compiled it :/. Next time I'll double-check!

The problem is, that sparc defines it in a little bit different way.
ip2 does this: <<EOF
#ifndef B153600
#       define B153600   0010005
#endif
#ifndef B307200
#       define B307200   0010006
#endif
#ifndef B921600
#       define B921600   0010007
#endif
EOF

and sparc termbits looks like this: <<EOF
/* This is what we can do with the Zilogs. */
#define  B76800   0x00001005
/* This is what we can do with the SAB82532. */
#define  B153600  0x00001006
#define  B307200  0x00001007
#define  B614400  0x00001008
#define  B921600  0x00001009
EOF

This diversity should be eliminated, I guess. What do char-folks think about 
this? Should we move this bits into asm-specific directories?

sorry,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
