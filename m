Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWIAR4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWIAR4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWIAR4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:56:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:1676 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750701AbWIAR4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:56:20 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F8732B.8080102@s5r6.in-berlin.de>
Date: Fri, 01 Sep 2006 19:51:39 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org> <20060901134425.GA32440@wohnheim.fh-wedel.de> <44F85267.1000607@s5r6.in-berlin.de> <20060901161920.GB32440@wohnheim.fh-wedel.de> <20060901163403.GC18276@stusta.de>
In-Reply-To: <20060901163403.GC18276@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Sep 01, 2006 at 06:19:20PM +0200, Jörn Engel wrote:
[...]
>> Assuming that select gets removed in the process, and
>> concentrating on oldconfig, would it be enough to have something like
>> this in the .config?
>> 
>> # CONFIG_USB_STORAGE has unmet dependencies: CONFIG_SCSI, CONFIG_BLOCK
>> 
>> Now people looking for usb mass storage can find the option without
>> grepping through Kconfig files, but also every single driver for every
>> single disabled subsystem shows up.  Might be a bit too much.

This comment or similar things are apparently not necessary _within 
subsystems_, just across subsystems, i.e. where the hierarchy of 
subdirectories and files does not match the hierarchy of dependencies.

> Common use case:
> A driver was changed to use FW_LOADER.
> The .config for the old kernel contains CONFIG_FW_LOADER=n.
> The user runs "make oldconfig" with the old .config in the new kernel.
> 
> How do you plan to handle this reasonably without select?

"make oldconfig" could ask questions when it sees need to disable 
formerly enabled options.

In general I think:
As long as we talk about the various prefab UIs to manipulate .config 
(i.e. "make {allyes, allmod, allno, def, g, menu, old, rand, silentold, 
update-po-, x, ''}config"), there may be ways to implement modes of 
operation which do what people expect from 'select' but with 'depends 
on' alone. To ensure that no user group is discriminated in the process, 
committees could be formed. (<- attempt on irony)

It will get difficult to entirely please users who don't use these 
interfaces to .config. But it seems these users are better off without 
'select'.
-- 
Stefan Richter
-=====-=-==- =--= ----=
http://arcgraph.de/sr/
