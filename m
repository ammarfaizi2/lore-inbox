Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRFZUhQ>; Tue, 26 Jun 2001 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263605AbRFZUhI>; Tue, 26 Jun 2001 16:37:08 -0400
Received: from www.transvirtual.com ([206.14.214.140]:46097 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S265111AbRFZU1I>; Tue, 26 Jun 2001 16:27:08 -0400
Date: Tue, 26 Jun 2001 13:26:29 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Romain Dolbeau <dolbeau@irisa.fr>
cc: linux fbdev <Linux-fbdev-devel@lists.sourceforge.net>,
        Romain Dolbeau <dolbeaur@club-internet.fr>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbgen & multiple RGBA
In-Reply-To: <3B36F2D1.175CD2E@irisa.fr>
Message-ID: <Pine.LNX.4.10.10106261324280.30394-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For the color component, yes, but you can't use a memcmp
> on the 'fb_var_screeninfo', as some member of the struct
> are irrelevant to colormap switching (you don't want
> to reinstall the colormap if only the refresh rate changed,
> for instance).

But it does. If you look at the console code it always calls set_palette
which in turn calls fbcon_set_palette which in turn calls fb_set_cmap. 
This happens every time you VC switch. A few driver writers noticed this
and don't bother with calling fb_Set_var in con_switch but instead a few
pieces of the function. But because of the way the current console system
is designed the colormap will always be set on VC switches.

