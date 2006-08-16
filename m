Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWHPHdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWHPHdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWHPHdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:33:36 -0400
Received: from main.gmane.org ([80.91.229.2]:7311 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750979AbWHPHdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:33:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Polling for battery stauts and lost keypresses
Date: Wed, 16 Aug 2006 09:31:48 +0200
Message-ID: <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <200608141038.04746.gene.heskett@verizon.net> <20060814152000.GA19065@rhlx01.fht-esslingen.de> <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com> <20060814155437.GA801@rhlx01.fht-esslingen.de> <d120d5000608140906x47bc572blb1b9821ead987d7e@mail.gmail.com> <1q38ghnxvrliv$.zzgutgu0exkm$.dlg@40tude.net> <d120d5000608141317p50540cd5x5e8ec409dc9343ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-198-158.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 16:17:01 -0400, Dmitry Torokhov wrote:

> On 8/14/06, Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
>> On Mon, 14 Aug 2006 12:06:06 -0400, Dmitry Torokhov wrote:
>>
>>> On many laptops (including mine) polling battery takes a loooong time
>>> and is done in SMI mode in BIOS causing lost keypresses, jerky mouse
>>> etc. It is pretty common problem. I think I have my ACPI client
>>> refreshing every 3 minutes.
>>
>> BTW, polling battery status takes a lot on a Dell Inspiron 8200 too,
>> and all keypresses and mouse movements (and I think even network
>> IRQs?) are totally *dead* while polling.
>>
>> However, The Other OS(tm) *seems* to do it right enough to have no
>> noticeable keypress losses, even when updating the battery status. Is
>> it using different system calls, or what?
>>
> 
> I am not sure, but there are many things that may affect it:
> 
> 1. Battry attributes are divided into 2 groups - static (i think they
> go into /proc/acpi/battery/<name>/info and dynamic
> (/proc/acpi/batetry/state). Static attributes take really long time to
> pull and they do not change so it may wery well be they are polled one
> at startup. Dynamic attributes are cheaper to poll and even then OS
> may cache access or limit rate.

Well, this would explain why Linux freezes while polling only if Linux
polls for the slow, static ones just as much as it does for the
dynamic ones ...

> 2. Quite often there are OEM drivers that are tweaked to a specific
> hardware and involve hardware-specific hacks.

If I remember correctly (damn, I can't find a way to do a search on
the LKML archives ...) there was someone working on Dell stuff, at
least as far as fans and thermal sensors were concerned (based on the
code from Massimo Dal Zotto) to integrate them with the kernel sensors
framework. However, some of those patches where NACKed by someone from
Dell because they were sort of "guessy" about the addresses to poke
around to get the information, instead of using the data provided by
the BIOS on where to look for them ... however, there hasn't been any
news about that that stuff since ...

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

