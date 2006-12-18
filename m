Return-Path: <linux-kernel-owner+w=401wt.eu-S1754239AbWLRQe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbWLRQe4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbWLRQe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:34:56 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:21482 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbWLRQez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:34:55 -0500
X-Greylist: delayed 1216 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 11:34:55 EST
Subject: Re: bug: kobject_add failed for audio with -EEXIST
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20061218155349.GA21282@elte.hu>
References: <20061218155349.GA21282@elte.hu>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 08:14:10 -0800
Message-Id: <1166458451.11560.5.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 16:53 +0100, Ingo Molnar wrote:
> an allyesconfig bootup generates the driver core warning below, in 
> alsa_card_dummy_init().
> 
> 	Ingo
> 
> ------------------>
> Calling initcall 0xc1ee1d35: alsa_card_dummy_init+0x0/0x8a()
> PM: Adding info for platform:snd_dummy.0
> kobject_add failed for audio with -EEXIST, don't try to register things with the same name in the same directory.

This is i386 or x86_64? This one, and the others, your been sending look
like initcall ordering issues. For instance, some alsa init usually runs
after alsa_card_dummy_init() , but in your kernel alsa_card_dummy_init()
runs first. It's a problem even in the same initcall level.

Daniel

