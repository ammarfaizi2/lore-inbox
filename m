Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281347AbRKLIks>; Mon, 12 Nov 2001 03:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281351AbRKLIki>; Mon, 12 Nov 2001 03:40:38 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:41743 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S281347AbRKLIk0>; Mon, 12 Nov 2001 03:40:26 -0500
Date: Mon, 12 Nov 2001 09:40:16 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] save sound mixer state over suspend
In-Reply-To: <3BEF6614.921EBED9@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111120934330.16450-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Jeff Garzik wrote:

> As we mentioned on IRC, ymfpci uses ac97_codec, which does not contain
> the ac97_reset function.

Being curious: Which IRC channel? - I checked the #kernelnewbies log, but 
that's apparently not it.

> > I cannot test the patch because my suspend/resume cycle
> > retains mixer levels without it (2.2.14 stock, PCG-Z505JE),
> > so I would not see any difference.

Interesting. My notebook is pretty much the European variant (PCG-Z600NE), 
but it doesn't retain the mixer levels.

> The patch looks ok, but I wonder about the order in ymfpci_resume.  You
> load the mixer values -then- call ymfpci_download_image and
> ymfpci_memload.  It seems for the purposes of general sanity and
> stability you would want to load the mixer values after doing those two
> operations.

Okay. I figured the ac97 codec and programming the chip itself wouldn't
interfere, but I agree that it looks saner to have the ac97_restore_state
at a later point. I'll change the patch accordingly.

--Kai

