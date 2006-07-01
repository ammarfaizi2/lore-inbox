Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWGAX1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWGAX1U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGAX1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:27:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:23190 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751197AbWGAX1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:27:20 -0400
Message-ID: <44A704A4.8080402@zytor.com>
Date: Sat, 01 Jul 2006 16:26:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Sam Ravnborg <sam@ravnborg.org>, Miles Lane <miles.lane@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com> <20060701230635.GA19114@mars.ravnborg.org> <44A7011B.6000702@zytor.com>
In-Reply-To: <44A7011B.6000702@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Sam Ravnborg wrote:
>>
>> For klibc you need to patch scripts/Kbuild.klibc
>>
>> Appending it to KLIBCWARNFLAGS seems the right place.
> 
> KLIBCREQFLAGS, rather.
> 
>> Do you know from what gcc version we can start using 
>> -fno-stack-protector?
> 
> Isn't there a macro to test if gcc supports a specific option already?
> 
> Either way, I can also add __stack_chk_fail() as an alias for abort(), 
> for people who actually want the feature.
> 

I looked at it again, and it looks like gcc depends on the TLS ABI in 
order to pick the value of the cookie.  That makes it a potentially lot 
more cantankerous option; I would like to be able to support stack-smash 
checking in klibc, but if it means implementing TLS on all 
architectures, then that would really defeat the purpose (and we should 
add -fno-stack-protector to KLIBCREQFLAGS.)

Arjan: I see a few stack-protector-related have your name on it, do you 
have any details on implementation constraints for this across 
architectures?

	-hpa
