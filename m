Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVDFPvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVDFPvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVDFPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:51:22 -0400
Received: from [195.23.16.24] ([195.23.16.24]:23471 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262236AbVDFPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:51:12 -0400
Message-ID: <42540560.2000205@grupopie.com>
Date: Wed, 06 Apr 2005 16:50:56 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@gmail.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Jesper Juhl <juhl-lkml@dif.dk>, Roland Dreier <roland@topspin.com>,
       LKML <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
References: <4252BC37.8030306@grupopie.com>	 <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost>	 <521x9pc9o6.fsf@topspin.com>	 <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost>	 <20050406112837.GC7031@wohnheim.fh-wedel.de>	 <4253D2CD.2040600@grupopie.com> <84144f02050406061077de4c2e@mail.gmail.com>
In-Reply-To: <84144f02050406061077de4c2e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi,
> 
> On Apr 6, 2005 3:15 PM, Paulo Marques <pmarques@grupopie.com> wrote:
> 
>>However "calloc" is the standard C interface for doing this, so it makes
>>some sense to use it here as well... :(
> 
> 
> I initally submitted kcalloc() with just one parameter but Arjan
> wanted it to be similar to standard calloc() so we could check for
> overflows. I don't see any reason not to introduce kzalloc() for the
> common case you mentioned (as suggested by Denis).

kzalloc it is, then.

By the way I did a quick measurement to see how much we could gain in 
kernel size by doing this. This is with a 2.6.11-rc2, defconfig kernel:

with kmalloc+memset:
    vmlinuz: 5521614
    bzImage: 2005274

with kzalloc:
    vmlinuz: 5513422
    bzImage: 2003927

So we gain 8kB on the uncompressed image and 1347 bytes on the 
compressed one. This was just a dumb test and actual results might be 
better due to smarter human cleanups.

Not a spectacular gain per se, but the increase in code readability is 
still worth it, IMHO.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
