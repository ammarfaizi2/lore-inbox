Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVGFRQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVGFRQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVGFRQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:16:28 -0400
Received: from alpha.polcom.net ([217.79.151.115]:42717 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261154AbVGFMta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:49:30 -0400
Date: Wed, 6 Jul 2005 14:49:22 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ast@domdv.de
Subject: Re: [swsusp] encrypt suspend data for easy wiping
In-Reply-To: <20050706091104.GB1301@elf.ucw.cz>
Message-ID: <Pine.LNX.4.63.0507061440470.7125@alpha.polcom.net>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org>
 <20050706091104.GB1301@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Pavel Machek wrote:

> Hi!
>
>>> To prevent data gathering from swap after resume you can encrypt the
>>> suspend image with a temporary key that is deleted on resume. Note
>>> that the temporary key is stored unencrypted on disk while the system
>>> is suspended... still it means that saved data are wiped from disk
>>> during resume by simply overwritting the key.
>>
>> hm, how useful is that?  swap can still contain sensitive userspace
>> stuff.
>
> At least userspace has chance to mark *really* sensitive stuff as
> unswappable. Unfortunately that does not work against swsusp :-(.
>
> [BTW... I was thinking about just generating random key on swapon, and
> using it, so that data in swap is garbage after reboot; no userspace
> changes needed. What do you think?]

I (and many others) are doing it already in userspace. Don't you know 
about dm-crypt? I think the idea is described in its docs or wiki...

I also think that doing this in swapon is risky. Because nobody will 
guarantee you that random seed was restored before swapon and basing this
random key only on boot time and (rather deterministic) irqs at boot 
is risky IMHO.

In userspace, init scripts should make sure that random seed is restored 
before using /dev/random for anything.


Grzegorz Kulewski
