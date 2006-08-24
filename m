Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWHYPb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWHYPb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWHYPb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:31:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12296 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030245AbWHYPbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:31:25 -0400
Date: Thu, 24 Aug 2006 20:31:39 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Polling for battery stauts and lost keypresses
Message-ID: <20060824203139.GC4539@ucw.cz>
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <200608141038.04746.gene.heskett@verizon.net> <20060814152000.GA19065@rhlx01.fht-esslingen.de> <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com> <20060814155437.GA801@rhlx01.fht-esslingen.de> <d120d5000608140906x47bc572blb1b9821ead987d7e@mail.gmail.com> <1q38ghnxvrliv$.zzgutgu0exkm$.dlg@40tude.net> <d120d5000608141317p50540cd5x5e8ec409dc9343ef@mail.gmail.com> <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-08-06 09:31:48, Giuseppe Bilotta wrote:
> On Mon, 14 Aug 2006 16:17:01 -0400, Dmitry Torokhov wrote:
> 
> > On 8/14/06, Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> >> On Mon, 14 Aug 2006 12:06:06 -0400, Dmitry Torokhov wrote:
> >>
> >>> On many laptops (including mine) polling battery takes a loooong time
> >>> and is done in SMI mode in BIOS causing lost keypresses, jerky mouse
> >>> etc. It is pretty common problem. I think I have my ACPI client
> >>> refreshing every 3 minutes.
> >>
> >> BTW, polling battery status takes a lot on a Dell Inspiron 8200 too,
> >> and all keypresses and mouse movements (and I think even network
> >> IRQs?) are totally *dead* while polling.
> >>
> >> However, The Other OS(tm) *seems* to do it right enough to have no
> >> noticeable keypress losses, even when updating the battery status. Is
> >> it using different system calls, or what?
> >>
> > 
> > I am not sure, but there are many things that may affect it:
> > 
> > 1. Battry attributes are divided into 2 groups - static (i think they
> > go into /proc/acpi/battery/<name>/info and dynamic
> > (/proc/acpi/batetry/state). Static attributes take really long time to
> > pull and they do not change so it may wery well be they are polled one
> > at startup. Dynamic attributes are cheaper to poll and even then OS
> > may cache access or limit rate.
> 
> Well, this would explain why Linux freezes while polling only if Linux
> polls for the slow, static ones just as much as it does for the
> dynamic ones ...

I guess patch caching battery/*/state would be welcome.
-- 
Thanks for all the (sleeping) penguins.
