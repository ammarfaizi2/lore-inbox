Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTKXDM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 22:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTKXDM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 22:12:57 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:33421 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261744AbTKXDMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 22:12:55 -0500
Date: Sun, 23 Nov 2003 22:07:12 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       perex@suse.cz
Subject: Re: modules.pnpmap output support
Message-ID: <20031123220712.GE30835@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Takashi Iwai <tiwai@suse.de>, arvidjaar@mail.ru,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, perex@suse.cz
References: <s5hptfrjezz.wl@alsa2.suse.de> <E1ALky0-000N9I-00.arvidjaar-mail-ru@f25.mail.ru> <s5had6vj99t.wl@alsa2.suse.de> <20031120212320.GB25417@neo.rr.com> <s5hptfmx7wy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hptfmx7wy.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 12:44:45PM +0100, Takashi Iwai wrote:
> At Thu, 20 Nov 2003 21:23:20 +0000,
> Adam Belay wrote:

--> snip

> > The device ID is checked, but this checking occurs during the driver's
> > probe function, when it calls pnp_request_card_device.  This is needed
> > in order for us to properly deal with multidevice cards, especially in
> > ALSA.
>
> well, the probe callback of all ALSA isapnp drivers doesn't look for
> the matching device ids.  that is, the callback trusts that the pnp
> core passes the correct pnp_card_device_id, and it checks only the
> devices listed on this id.  so, as mentioned above, if there are
> multiple entries with the same card id but different device ids,
> probing the second entry will fail, because match_card() returns the
> first matching id.

Hmm, I agree, if there are multiple entries with the same card ID then
only the first ID would be matched.  I could add some code to match_card()
so that it checks to see if all of the devices in the list are present.
This would, however, break ALSA's current policy of enabling a card, even
if some of its device components are unavailabe.  Could you provide any
specific examples of multiple entries with the same card ID?  I'd like to
look at some closer.

>
> >   If possibly, I'd like to see the devices in these cards be
> > handled individually in 2.7 but note that doing so would require
> > changes to some drivers and subsystems.  The current system works well
> > for 2.6.
> >
> > Because of these factors, and the fact that pnp_device_id is also used,
> > I think that we have to include all of the IDs in the pnpidmap.  This
> > would include both the card id and the individual device IDs on each
> > card.  pnp_device_id can use the isapnp card device ids in addition to
> > the ids reported by the pnpbios.
>
> oh, can pnp_device_id be a card id, too, not only a device id?

Only a device ID, but those device IDs can reside on isapnp cards.

>
>
> Takashi


Thanks,
Adam
