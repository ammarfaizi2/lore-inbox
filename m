Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933718AbWKQQiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933718AbWKQQiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933720AbWKQQiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:38:03 -0500
Received: from [65.172.181.25] ([65.172.181.25]:48863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933718AbWKQQiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:38:01 -0500
Date: Fri, 17 Nov 2006 08:35:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Yinghai Lu <yinghai.lu@amd.com>
cc: Takashi Iwai <tiwai@suse.de>, Olivier Nicolas <olivn@trollprod.org>,
       Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <86802c440611170817i4452ae9ctb6d57f0879e877af@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611170831050.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> 
 <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org> 
 <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>
 <455B5D22.10408@garzik.org>  <s5hslgktu4a.wl%tiwai@suse.de>
 <455B6761.3050700@garzik.org>  <s5hodr7u0ve.wl%tiwai@suse.de>
 <455CEDC5.40200@trollprod.org>  <s5hwt5us5q2.wl%tiwai@suse.de>
 <86802c440611170817i4452ae9ctb6d57f0879e877af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2006, Yinghai Lu wrote:
>
> the fallback path from MSI test to ioapic still not look good.

I don't think there should be a fallback at all.

Let's just:

 - keep MSI disabled by default for now, until we know what's really going 
   on (and we can try enabling it every once in a while in a -rc1, just to 
   get more information ;)

 - when MSI is selected (ie both the HDA driver _and_ the system decides 
   that MSI is ok), it should just get used. No testing. No fallbacks. No 
   strange code at all. Just use it.

The whole notion of trying to see if MSI works is very suspect, and likely 
fragile. We should never _ever_ "switch" between the two modes. We choose 
one mode, and we stick to it. 

Eventually, MSI will hopefully be the more robust of the two methods. 
Maybe it will take a year. And maybe we'll end up not using MSI on a lot 
of the _current_ crop of motherboards. We don't want to carry the "fall 
back from MSI to INTx" code around. We just want a flag saying "use MSI" 
or "use INTx".

		Linus
