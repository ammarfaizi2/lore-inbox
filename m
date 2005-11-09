Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKIMVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKIMVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKIMVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:21:55 -0500
Received: from [195.23.16.24] ([195.23.16.24]:40160 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750701AbVKIMVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:21:55 -0500
Message-ID: <4371E9DE.5040606@grupopie.com>
Date: Wed, 09 Nov 2005 12:21:50 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adayadil Thomas <adayadil.thomas@gmail.com>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Creating new System.map with modules symbol info
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>	 <1131487518.2789.26.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.61.0511081712210.6019@chaos.analogic.com> <fb7befa20511081437p3355ba0aic8c9c518d3cc7b19@mail.gmail.com>
In-Reply-To: <fb7befa20511081437p3355ba0aic8c9c518d3cc7b19@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adayadil Thomas wrote:
> [...]
> If i Use the original System.map, it doesnt find the symbol for the
> init_conntrack_syn
> ( EIP is pointing there)
> However, kallsyms has an entry for that
> f8b752c8 t init_conntrack_syn
> 
> If kallsyms has all the symbols, I am wondering why does it have lesser lines ?
> 
> wc -l
> 12343 kallsyms
> 32127 System.map

By default kallsyms only stores symbols that are int the kernel's text 
areas, whereas System.map has all the symbols.

You can make kallsyms store all the symbols by setting 
CONFIG_KALLSYMS_ALL in your kernel configuration, but the extra symbol 
data will increase your kernel size. Depending on the target host memory 
size this can be either negligeable or a big problem :)

However, module symbols appear in the /proc/kallsyms file using a 
totally different mechanism, and even if you don't set 
CONFIG_KALLSYMS_ALL, module data symbols (and others) still show up there.

By the way, if you had KALLSYMS configured in the first place, the 
kernel itself would translate those addresses for you for free.

> Will it work if I cat System.map and kallsyms together and do a sort and uniq
> so that i get the union of both ?

Unless you really need non-text symbols, kallsyms should have all the 
information you need. If you need _everything_ then you can just do 
something like (totally untested) "grep \\[ /proc/kallsyms >> 
System.map" to add the symbols from modules to the System.map.

I don't know if the tools out there will like this, though...

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
