Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVKOPMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVKOPMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVKOPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:12:48 -0500
Received: from [195.23.16.24] ([195.23.16.24]:15745 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932531AbVKOPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:12:48 -0500
Message-ID: <4379FAED.7030700@grupopie.com>
Date: Tue, 15 Nov 2005 15:12:45 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain> <dlal2q$kdo$1@sea.gmane.org>
In-Reply-To: <dlal2q$kdo$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani wrote:
> Alan Cox wrote:
> 
>>reasons. The ndis wrapper people have known it is coming for a long
>>time, and if it has a lot of users I'm sure someone in that community
>>will take the time to make patches.
> 
>[...]
> Any suggestions on how ndiswrapper can live with this patch would be greatly
> appreciated.

One idea that has not yet been suggested, is to use a x86 emulator to 
run the driver code.

I did some development a while ago, to reduce the size a x86 emulator to 
run VGA BIOS functions. If an emulator like this would make it to the 
kernel it could also be used to change video modes even using the VESA 
driver, suspend/resume the VGA using the VGA own code, etc.

The final size of the emulator was a little over 30k, but there was 
still room for even more reductions.


The advantages:

  - the driver runs in a complete sandbox

  - support for running NDIS drivers in multiple architectures (not just 
x86)

  - the emulator could be shared amongst more kernel subsystems in need 
of an emulator (VESA, for instance)


Disadvantages:

  - increase in kernel code size (about 30k)

  - decrease in driver code execution speed


I'm not really advocating for this, just wanted to make sure people 
would be aware of all the solutions available before committing to any 
approach.

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
