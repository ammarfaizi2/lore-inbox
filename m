Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUH3SnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUH3SnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUH3SmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:42:17 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25799 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268303AbUH3Sjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:39:36 -0400
Message-ID: <4133740F.6090505@grupopie.com>
Date: Mon, 30 Aug 2004 19:38:07 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       mpm@selenic.com, linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com> <20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk> <412D236E.3030401@grupopie.com> <20040825234345.GN21964@parcelfarce.linux.theplanet.co.uk> <20040826025904.02bf4c0e.akpm@osdl.org> <412DBAD9.6020303@grupopie.com> <20040830182141.GB8990@mars.ravnborg.org>
In-Reply-To: <20040830182141.GB8990@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.37; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Aug 26, 2004 at 11:26:33AM +0100, Paulo Marques wrote:
> 
>>If there is a way to know at compile time the exported symbols, then 
>>scripts/kallsyms might generate a bitmap along with all the other data 
>>it generates so that checking is_exported would become O(1).
> 
> 
> If there exist a symbol named __ksymtab_{symbol} then you know it is exported.

Thanks for the sugestion.

I already looked at EXPORT_SYMBOL in module.h and reached the same 
conclusion, and wrote a patch that did just that.

The problem with that patch was that symbols exported with 
EXPORT_SYMBOL_GPL would show up as exported whereas in the previous 
version they didn't :(

I asked Rusty Russell in private if the old behaviour was the desired 
behaviour or if it would be better to uppercase the symbols that are 
uppercased in System.map (i.e. exported vs public), and he replied that 
the old behaviour was done on purpose and should be kept (at least that 
is what I understood, not being a native speaker and all).

So I'm writting a new version right now that checks that the 
__ksymtab_{symbol} is on the __ksymtab section and not on the 
__ksymtab_gpl section to keep the old behaviour.

Anyway, the patch really speeds up a "time cat /proc/kallsyms" from 
0.25s to 0.00s (I really need to do my own benchmark. "time" doesn't 
have enough resolution :)

I'll probably post it tonight.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
