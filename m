Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264985AbUD2V5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbUD2V5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbUD2V5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:57:31 -0400
Received: from aun.it.uu.se ([130.238.12.36]:10895 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264985AbUD2Vzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:55:36 -0400
Date: Thu, 29 Apr 2004 23:46:41 +0200 (MEST)
Message-Id: <200404292146.i3TLkfI0019612@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: filia@softhome.net
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004 11:30:25 +0200, Ihar 'Philips' Filipau wrote:
>Mikael Pettersson wrote:
>> This patch fixes three warnings from gcc-3.4.0 in 2.6.6-rc3:
>> - drivers/char/ftape/: use of cast-as-lvalue
>>  		if (get_unaligned((__u32*)ptr)) {
>> -			++(__u32*)ptr;
>> +			ptr += sizeof(__u32);
>>  		} else {
>
>   Can anyone explain what is the problem with this?
>   To me it seems pretty ligitimate code - why it was outlawed in gcc 3.4?
>
>   Previous code was agnostic to type of ptr, but you code presume ptr 
>being char pointer (to effectively increment by 4 bytes).

'ptr' _is_ a char pointer, and the code (visible in the part of
the patch you didn't include) already performed pointer arithmetic
on it relying on it being a char pointer. The old code had no
sane reason at all for updating 'ptr' via a cast-as-lvalue.

cast-as-lvalue is not proper C, has dodgey semantics, and can
always be replaced by proper C.
