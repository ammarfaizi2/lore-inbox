Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286667AbRLVEZo>; Fri, 21 Dec 2001 23:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286668AbRLVEZf>; Fri, 21 Dec 2001 23:25:35 -0500
Received: from femail7.sdc1.sfba.home.com ([24.0.95.87]:57985 "EHLO
	femail7.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S286667AbRLVEZT>; Fri, 21 Dec 2001 23:25:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Doug Ledford <dledford@redhat.com>, Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Scheduler ( was: Just a second ) ...
Date: Fri, 21 Dec 2001 15:23:41 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <20011218105459.X855@lynx.no> <3C1F8A9E.3050409@redhat.com>
In-Reply-To: <3C1F8A9E.3050409@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011222042513.BAFI14531.femail7.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 December 2001 01:27 pm, Doug Ledford wrote:

> Weel, evidently esd and artsd both do this (well, I assume esd does now, it
> didn't do this in the past).  Basically, they both transmit silence over
> the sound chip when nothing else is going on.  So even though you don't
> hear anything, the same sound output DMA is taking place.  That avoids

THAT explains it.

My Dell Inspiron 3500 laptop's built-in sound (NeoMagic MagicMedia 256 AV, 
uses ad1848 module) works fine when I first boot the sucker, but looses its 
marbles after an APM suspend and stops receiving interrupts.  (Extensive 
poking around with setpci has so far failed to get it working again, but on a 
shutdown and restart the bios sets it up fine.  Not a clue what's up there.  
The bios and module agree it's using IRQ 7, but lspci insists it's IRQ 11, 
both before and after apm suspend.  Boggle.)

I was confused for a while about how exactly it was failing because KDE and 
mpg123 from the command line fail in different ways.  mpg123 will play the 
same half-second clip in a loop (ahah! no interrupt!), but sound in kde just 
vanishes and I get silence and hung apps whenever I try to launch anything.

The clue is that it doesn't always fail when I suspend it without having X 
up.  Translation: maybe the sound card's getting hosed by being open and in 
use on APM shutdown!

Hmmm...  I should poke at this over the weekend...

(Nope, not a new problem.  My laptop's sound has been like this since at 
least 2.4.4, which I think was the first version I installed on the box.  But 
it's still annoying, I can go weeks without a true reboot 'cause I have a 
zillion konqueror windows and such open.  I have to clear my desktop to get 
sound working again for a few hours.  Obnoxious...)

Rob
