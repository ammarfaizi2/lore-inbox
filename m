Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbTCTCyi>; Wed, 19 Mar 2003 21:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCTCyi>; Wed, 19 Mar 2003 21:54:38 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:58498 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S261304AbTCTCyh>;
	Wed, 19 Mar 2003 21:54:37 -0500
Date: Wed, 19 Mar 2003 22:08:49 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
Message-ID: <20030319220849.GB13998@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@wildrose.miee.ru>,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com> <861563974656.20030319180923@wr.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861563974656.20030319180923@wr.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 06:09:23PM +0300, Ruslan U. Zakirov wrote:
> JK> Following patch is to make ESS968 driver to work with PNP API.
> [SNIP]
> JK> +static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
> [SNIP]
>       Hello, Adam, Greg and other.
> As I think in this section of kernel it's not necessarily to use
> __devinit and __devexit.
> Soundcards(and other devices) can't be HotPlug as I know.
> And if we look at #define of this attributes, then we see that
> it useless with not HotPlug devices.
>
> 180 #ifdef CONFIG_HOTPLUG
> 181 #define __devinit
> 182 #define __devinitdata
> 183 #define __devexit
> 184 #define __devexitdata
> 185 #else
> 186 #define __devinit __init
> 187 #define __devinitdata __initdata
> 188 #define __devexit __exit
> 189 #define __devexitdata __exitdata
> 190 #endif
> And with changes from __init to __devinit and enabled CONFIG_HOTPLUG
> we loose advantage of __init.
> May be I've missed something?
>        Best regards, Ruslan.

Yes, I agree.  We should be using init for these particular drivers.  PnPBIOS
devices may be on docking stations and I'd like to leave them as __devinit but
for strictly isapnp devices such as these, init makes sense.  I'll add this to
my tree.

Thanks for bringing this to my attention.

-Adam
