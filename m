Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWBMXV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWBMXV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWBMXV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:21:27 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:51376
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030233AbWBMXV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:21:27 -0500
Message-ID: <43F11471.5070207@microgate.com>
Date: Mon, 13 Feb 2006 17:21:21 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty reference count fix
References: <1139861610.3573.24.camel@amdx2.microgate.com> <9a8748490602131415r5c6cd7by3a3d0bc03e27bd83@mail.gmail.com>
In-Reply-To: <9a8748490602131415r5c6cd7by3a3d0bc03e27bd83@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> I just applied the patch to 2.6.16-rc3 and booted the patched kernel.
> Unfortunately I can't tell you if it fixes the bug since I never
> successfully reproduced it, it just happened once out of the blue.
> What I can tell you though is that the patched kernel seems to behave
> just fine and doesn't seem to introduce any regressions on my system -
> but my testing has been quite limited so far.
> 
> Not the best feedback, I know, but it's the best I can give you at the moment.

Any feedback is good feedback. I'm not suprised it has not
happened again. The necessary conditions are not common and
the timing window is small. As Andrew pointed out,
DEBUG_PAGEALLOC likely helped uncover this.

Decoding the 2 oops to specific lines of code strongly
suggests this is what happened to you. The decoding showed
the tty open and close (release) paths from different
processes going after the same tty structure at the same time.

Thanks,
Paul

--
Paul Fulghum
Microgate Systems, Ltd




