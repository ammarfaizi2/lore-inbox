Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWEYBuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWEYBuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWEYBuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:50:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55438 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964796AbWEYBuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:50:12 -0400
Date: Thu, 25 May 2006 03:50:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] restore amikbd compatibility with 2.4
In-Reply-To: <20060524183634.44580870.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605250346080.32445@scrub.home>
References: <20060525002742.723577000@linux-m68k.org> <20060525003421.958272000@linux-m68k.org>
 <20060524183634.44580870.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 May 2006, Andrew Morton wrote:

> zippel@linux-m68k.org wrote:
> >
> > +	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
> >  +		static u_short temp_map[NR_KEYS] __initdata;
> >  +		if (!key_maps[i])
> >  +			continue;
> >  +		memset(temp_map, 0, sizeof(temp_map));
> >  +		for (j = 0; j < 0x78; j++) {
> >  +			if (!amikbd_keycode[j])
> >  +				continue;
> >  +			temp_map[j] = key_maps[i][amikbd_keycode[j]];
> >  +		}
> >  +		for (j = 0; j < NR_KEYS; j++) {
> >  +			if (!temp_map[j])
> >  +				temp_map[j] = 0xf200;
> >  +		}
> >  +		memcpy(key_maps[i], temp_map, sizeof(temp_map));
> >  +	}
> 
> I assume temp_map[] is static to avoid using too much stack.

Yes, although it should only be 1KB.

> But wouldn't it be simpler to make this code operate on key_maps[i] directly?

No, the remapping would overwrite data which still needs to be read.

bye, Roman
