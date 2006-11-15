Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030652AbWKOQZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030652AbWKOQZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030657AbWKOQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:25:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030652AbWKOQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:25:16 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	 <20061114.192117.112621278.davem@davemloft.net>
	 <s5hbqn99f2v.wl%tiwai@suse.de>
	 <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 17:24:49 +0100
Message-Id: <1163607889.31358.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is why I'm so adamant that we need to _know_ that it works before we 
> use it. When irq's get mis-routed, things go downhill real fast. We're 
> usually talking "dead machines", and there is very little that a driver 
> can do about it.

well we could cheat some. And have the generic code for this just
register the irq handler for both somehow. At least the case for "only
does old style and no actual MSI" will work then.
For the duplicate issue... if the generic irq layer keeps track of the
"mirror" property of the handler it could be dealt with (eg clear the
unhandled count of the "mirror" as well on each handled irq).. 

I'll grant you that it's a bit evil, and probably ulgy to keep the
mirror information, but if it gets the thing reliable.....  it could
solve a lot of the mess.

(Oh and I would *love* for this to printk once if the kernel detects
cheating behavior so that we can make things like the linux firmware
test kit complain to the hw/bios folks early on)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

