Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUHBLmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUHBLmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 07:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUHBLmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 07:42:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:5880 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266458AbUHBLmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 07:42:06 -0400
Date: Mon, 2 Aug 2004 13:34:26 +0200 (MEST)
Message-Id: <200408021134.i72BYQdN026747@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004 12:40:26 +0200, Adrian Bunk wrote:
>On Sat, Jul 31, 2004 at 10:41:53AM +0200, Mikael Pettersson wrote:
>>...
>> Did you know that there is a larger gcc-3.4 fixes patch:
>> <http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc340-fixes-v4-2.4.27-rc3>
>> ?
>> 
>> This patch handles all issues when using gcc-3.4 to compile
>> the current 2.4 kernel, of which cast-as-lvalue is just one.
>> The only difference, AFAIK, is that gcc-3.4 "merely" warns
>> about cast-as-lvalue while gcc-3.5 errors out on them.
>> 
>> All changes in the gcc-3.4 fixes patch are backports from
>> the 2.6 kernel, except in very few cases when 2.4 and 2.6
>> have diverged making slightly different fixes more appropriate
>> for 2.4.
>>...
>
>
>BTW:
>
>Please don't include the compiler.h part of your patch.
>It's already reverted in -mm, and we're currently fixing the inlines
>in 2.6 .
>
>This was started after with this patch in 2.6 somewhere a required 
>inlining did no longer occur (and a compile error is definitely better 
>than a potential runtime problem).

Which one was that? DaveM wrote recently that they had eliminated
SPARC's save_flags/restore_flags-in-same-stack-frame requirement.

>Although fixing it correctly touches at about three dozen files, these 
>are pretty straightforward patches (removing inlines or moving code 
>inside files). After all these issues are sorted out in 2.6, the inline 
>fixes could be backported to 2.4 .

I'll consider attacking the inlining issues, after I've reviewed my
cast-as-lvalue and fastcall fixes -- I noticed that at least one fix
had changed in 2.6 since I first adapted it to 2.4.

/Mikael
