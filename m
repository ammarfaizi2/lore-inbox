Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSFCJTS>; Mon, 3 Jun 2002 05:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSFCJTR>; Mon, 3 Jun 2002 05:19:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:44419 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317327AbSFCJTQ>;
	Mon, 3 Jun 2002 05:19:16 -0400
Date: Mon, 3 Jun 2002 11:19:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: FUD or FACTS ?? but a new FLAME!
Message-ID: <20020603111910.A13204@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10206021451310.5846-100000@master.linux-ide.org> <3CFB0063.3070309@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 07:36:35AM +0200, Martin Dalecki wrote:

> I have been reading the stuff about the difference between ATA/100 and
> ATA/133 talking about clock cycles, buffer sizes, transmission directions
> and what not and were quite unable to understand what the point was until I
> looked at the public Intel ICH4 spec (the one available to us mortals
> without connections :-)
> 
> ftp://download.intel.com/design/chipsets/manuals/29860002.pdf

Thanks for the pointer, I was unable to find it when I was assing ICH4
support - and most board-maker sites at that time advertised ATA-133.

> Intel do state that the ICH4/82801DB supports only ATA/100 not ATA/133.
> Looking through some reviews on the net on the 845E/G they do say the same
> thing.

Actually, it doesn't support ATA-100 correctly either. It has a 133MHz
base clock, and for ATA-100 uses a 3 clock cycle. 133MHz/3*2byte = 88.6 MB/sec.

So the maximum documented speed on ICH chips is 88.6 write, and 100.0
read - because there the drive dictates the speed.

> In the light of that perhaps the code in drivers/ide/piix.c stating that the
> ICH4 does ATA/133 is a bit optimistic and should be moved to the "try it if
> you want to " CONFIG_BLK_DEV_PIIX_TRY133 option.

Agreed. Martin, please do that. Also, please change the Config.in
comment to something like "Enable undocumented ATA-133 on ICH chips",
or somehting alike..

> Of course Vojtek might have better info that says otherwise.

No, I don't. ICH4 was designed to have ATA-133 capability, Intel
probably downgraded that in the spec because of some problems.

-- 
Vojtech Pavlik
SuSE Labs
