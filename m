Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264870AbUD2Vji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbUD2Vji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUD2VhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:37:22 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:29587 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264870AbUD2VgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:36:08 -0400
Message-ID: <4091751C.7070507@softhome.net>
Date: Thu, 29 Apr 2004 23:35:24 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Mikael Pettersson <mikpe@user.it.uu.se>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Paul Wagland <paul@wagland.net>
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
References: <1PX8S-5z2-23@gated-at.bofh.it> <4090CB31.6090300@softhome.net> <200404292354.37091.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404292354.37091.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 29 April 2004 12:30, Ihar 'Philips' Filipau wrote:
> 
>>Mikael Pettersson wrote:
>>
>>>This patch fixes three warnings from gcc-3.4.0 in 2.6.6-rc3:
>>>- drivers/char/ftape/: use of cast-as-lvalue
>>> 		if (get_unaligned((__u32*)ptr)) {
>>>-			++(__u32*)ptr;
>>>+			ptr += sizeof(__u32);
>>> 		} else {
>>
>>   Can anyone explain what is the problem with this?
>>   To me it seems pretty ligitimate code - why it was outlawed in gcc 3.4?
> 
> 
> cast is not a lvalue. ++(__u32*)ptr is nonsense, just like ++4.
> 

   Yes. I see. C goes in direction of C++.
   For me cast in C is always "forget original type and assume this type."
   From this standpoint it makes a lot of sense. Is just like
((stuct { char a,b,c,d;})4).a - never tryed it in gcc (3.3 does not 
accept it), but IIRC was possible on old PC C compilers - Turbo C 2/3 - 
not sure name/version, but I used it. (Yes! recalled - M$VC/winbase.h 
use this kind of macros for manipulating bytes/words/dwords/etc)
   And in old C classes it was always said that in C you can convert 
anything to everything, it just size of types must be the same.

   Why not after all?

> 
> ptr = (void*) ((char*)ptr + sizeof(__u32));

   No Nice, But Accepted.

   I have just checked my code base - I do not use this feature in any 
way ;-)

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  A programmer is a person who passes as an exacting expert  |_|*|_|
  on the basis of being able to turn out, after innumerable  |_|_|*|
  punching, an infinite series of incomprehensible answers   |*|*|*|
  calculated with micrometric precisions from vague
  assumptions based on debatable figures taken from inconclusive
  documents and carried out on instruments of problematical accuracy
  by persons of dubious reliability and questionable mentality for
  the avowed purpose of annoying and confounding a hopelessly
  defenseless department that was unfortunate enough to ask for the
  information in the first place.
                 -- IEEE Grid newsmagazine

