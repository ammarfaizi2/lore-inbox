Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131556AbRCNVAi>; Wed, 14 Mar 2001 16:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131555AbRCNVA2>; Wed, 14 Mar 2001 16:00:28 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:61957 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S131543AbRCNVAU>;
	Wed, 14 Mar 2001 16:00:20 -0500
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
From: Brad Douglas <brad@neruo.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10103141429440.24115-100000@callisto.of.borg>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 14 Mar 2001 12:57:20 -0800
Mime-Version: 1.0
Message-Id: <20010314210026Z131543-406+394@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Mar 2001 14:39:57 +0100, Geert Uytterhoeven wrote:
> On Wed, 14 Mar 2001, Benjamin Herrenschmidt wrote:
> > >I think registering fbcon as a PM client and doing the above when the
> > >fbdev suspend/resume hooks are called should work.  A memory backup is
> > >worked on until the resume is run and the backup is restored to the
> > >display.
> > >
> > >So the fbdev drivers would register PM with fbcon, not PCI, correct?
> > 
> > Either that, or the fbdev would register with PCI (or whatever), _and_
> > fbcon would too independently. In that scenario, fbcon would only handle
> > things like disabling the cursor timer, while fbdev's would handle HW
> > issues. THe only problem is for fbcon to know that a given fbdev is
> > asleep, this could be an exported per-fbdev flag, an error code, or
> > whatever. In this case, fbcon can either buffer text input, or fallback
> > to the cfb working on the backed up fb image (that last thing can be
> > handled entirely within the fbdev I guess).
> 
> I'd go for a fallback to dummycon. It's of no use to waste power on creating
> graphical images of the text console when asleep. And the fallback to dummycon
> is needed anyway while a fbdev is opened (in 2.5.x).

But wouldn't falling back to dummycon prevent the driver specific
suspend/resume calls from working?  Or at a minimum, make handling those
calls more complex?

No, there does not need to be graphical images of the text console -- a
simply text buffer would suffice.  But what about things like GTKFb and
Embedded QT?  They would certainly benefit from having a backup screen
image, right?  I do not believe there is any way to determine if the
console is in fact in a 'text' or graphical state.

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org


