Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270515AbTGXIMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 04:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270517AbTGXIMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 04:12:34 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:23001 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270515AbTGXIMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 04:12:14 -0400
Message-ID: <3F1F9887.5010703@softhome.net>
Date: Thu, 24 Jul 2003 10:27:51 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David McCullough <davidm@snapgear.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David McCullough wrote:
> 
> A general comment on the use of inline throughout the kernel.  Although
> they may show gains on x86 platforms,  they often perform worse on 
> embedded processors with limited cache,  as well as adding size.  I
> can't see any way of coding around this though.  As long as x86 is
> driving influence,  other platforms will jut have to deal with it as
> best they can.
> 

   Actually I'm victim on over inlining too. Was at least.
   I was running some router on old Pentium's. I remember almost 
dramatical drop of performance with newer kernels because of inlining in 
net/*. But sure on Xeon P4 it boosts performance...

   Actually what I'm about.
   We have classical situation when we have mess of representation and 
intentions.

   Representation == 'inline', but intentions - 'inline or it will 
break' _and_ 'inline - it runs faster'.
   This obviously should be separated.

   even more.

#define INLINE_LEVEL some_platform_specific_number

---------

#define inline0 inline_always

#if INLINE_LEVEL >= 1
#  define inline1 inline_always
#else
#  define inline1
#endif
...
#if INLINE_LEVEL >= N
#  define inlineN inline_always
#else
#  define inlineN
#endif

    and so on, giving a platform chance to influence amount of inlining.
    better to put it into config with defined by platform defaults.

