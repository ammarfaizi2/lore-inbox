Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281269AbRKLGDz>; Mon, 12 Nov 2001 01:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281270AbRKLGDg>; Mon, 12 Nov 2001 01:03:36 -0500
Received: from mail217.mail.bellsouth.net ([205.152.58.157]:51875 "EHLO
	imf17bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281268AbRKLGDT>; Mon, 12 Nov 2001 01:03:19 -0500
Message-ID: <3BEF6614.921EBED9@mandrakesoft.com>
Date: Mon, 12 Nov 2001 01:03:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] save sound mixer state over suspend
In-Reply-To: <Pine.LNX.4.33.0111112107530.1518-100000@vaio> <20011112004719.A6091@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > Date: Sun, 11 Nov 2001 21:42:27 +0100 (CET)
> > From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
> > To: <linux-kernel@vger.kernel.org>
> > cc: Linus Torvalds <torvalds@transmeta.com>, Pete Zaitcev <zaitcev@redhat.com>
> 
> > The appended patch introduces two new functions to the ac97_codec
> > handling: ac97_save_state() and ac97_restore_state().
> > These functions save/restore the mixer state over suspend. (So after
> > resume the volume is the same it was before)
> 
> The patch itself looks ok, but I am wondering what is
> the difference between your ac97_restore_state and ac97_reset.
> I think you may be reinventing the wheel here.

As we mentioned on IRC, ymfpci uses ac97_codec, which does not contain
the ac97_reset function.


> I cannot test the patch because my suspend/resume cycle
> retains mixer levels without it (2.2.14 stock, PCG-Z505JE),
> so I would not see any difference.

2.2.14?  Is that a typo?  His was patch for 2.4.15-pre2...

Anyway, my comments per request:
The patch looks ok, but I wonder about the order in ymfpci_resume.  You
load the mixer values -then- call ymfpci_download_image and
ymfpci_memload.  It seems for the purposes of general sanity and
stability you would want to load the mixer values after doing those two
operations.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

